// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 32,
    parameter DELAYS=10
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output reg [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire rst;

    wire [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;

    // wdata and rdata for bram
    wire [31:0] rdata; 
    wire [31:0] wdata;
    wire [BITS-1:0] count;

    // set valid signal
    wire valid;
    wire valid2;
    wire valid3;
    wire [3:0] wstrb;
    wire [31:0] la_write;
    wire decoded;
    wire decoded2;
    wire decoded3;
    // set ready and delay signal
    reg  bram_ready;
    wire axistream_ready;
    wire axilite_ready;
    wire ready;
    reg [BITS-17:0] delayed_count;
    // Signal for wb_axistream
    wire        sm_tvalid;
    wire        sm_tready;
    wire [31:0] sm_tdata;
    wire [31:0] axistream_rdata;

    wire        ss_tvalid;
    wire        ss_tready;
    wire [31:0] ss_tdata;
    wire        ss_tlast;

    // Signal for wb_axilite write
    wire        awvalid;
    wire        awready;
    wire [11:0] awaddr;
    wire        wvalid;
    wire        wready;
    wire [31:0] fir_wdata;
    // Signal for wb_axilite read
    wire        arvalid;
    wire        arready;
    wire [11:0] araddr;
    wire        rvalid;
    wire        rready;
    wire [31:0] fir_rdata;
    wire [31:0] axilite_rdata;
    // ram for tap
    wire [3:0]        tap_WE;
    wire              tap_EN;
    wire [(BITS-1):0] tap_Di;
    wire     [(11):0] tap_A;
    wire [(BITS-1):0] tap_Do;

    // ram for data RAM
    wire [3:0]        data_WE;
    wire              data_EN;
    wire [(BITS-1):0] data_Di;
    wire     [(11):0] data_A;
    wire [(BITS-1):0] data_Do;

    // WB MI A
    assign valid  = wbs_cyc_i && wbs_stb_i && decoded;
    assign valid2 =  wbs_cyc_i && wbs_stb_i && decoded2;
    assign valid3 =  wbs_cyc_i && wbs_stb_i && decoded3;
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};

    always@* begin
        if (bram_ready) begin
            wbs_dat_o = rdata;
        end else if (axistream_ready) begin
            wbs_dat_o = axistream_rdata;
        end else if (axilite_ready) begin
            wbs_dat_o = axilite_rdata;
        end else begin
            wbs_dat_o = 32'h0;
        end 
    end

    assign wdata = wbs_dat_i;
    assign ready = (bram_ready|axistream_ready|axilite_ready);
    assign wbs_ack_o = ready;
    // IO
    assign io_out = count;
    assign io_oeb = {(`MPRJ_IO_PADS-1){rst}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    assign la_data_out = {{(127-BITS){1'b0}}, count};
    // Assuming LA probes [63:32] are for controlling the count register  
    assign la_write = ~la_oenb[63:32] & ~{BITS{valid}};
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;
    // Decoded wishbone address
    assign decoded  = wbs_adr_i[31:24] == 8'h38 ? 1'b1: 1'b0;
    assign decoded2 = (wbs_adr_i[31:0] == 32'h30000080 | wbs_adr_i[31:0] == 32'h30000084) ? 1'b1: 1'b0;
    assign decoded3 = (wbs_adr_i[31:0] >= 32'h30000000 & wbs_adr_i[31:0] <= 32'h3000007F) ? 1'b1: 1'b0;


    always @(posedge clk) begin
        if (rst) begin
            bram_ready <= 1'b0;
            delayed_count <= 16'b0;
        end else begin
            bram_ready <= 1'b0;
            if (valid && !bram_ready) begin
                if (delayed_count == DELAYS) begin
                    delayed_count <= 16'b0;
                    bram_ready <= 1'b1;
                end else begin
                    delayed_count <= delayed_count + 1;
                end
            end
        end
    end
    
    wb_axistream wb_axistream(
        .clk(clk),
        .rst(rst),

        .wbs_adr_i(wbs_adr_i),
        .wb_valid(valid2),
        .wb_ready(axistream_ready),
        .wbs_we_i(wbs_we_i),
        .wbs_dat_i(wbs_dat_i),
        .wbs_dat_o(axistream_rdata),

        .sm_tvalid(sm_tvalid),
        .sm_tready(sm_tready),
        .sm_tdata(sm_tdata),

        .ss_tvalid(ss_tvalid),
        .ss_tready(ss_tready),
        .ss_tdata(ss_tdata)
    );

    wb_axilite wb_axilite(
        .clk(clk),
        .rst(rst),

        .wbs_adr_i(wbs_adr_i),
        .wb_valid(valid3),
        .wb_ready(axilite_ready),
        .wbs_we_i(wbs_we_i),
        .wbs_dat_i(wbs_dat_i),
        .wbs_dat_o(axilite_rdata),

        .awvalid(awvalid),
        .awready(awready),
        .awaddr(awaddr),
        .wvalid(wvalid),
        .wready(wready),
        .wdata(fir_wdata),

        .arvalid(arvalid),
        .arready(arready),
        .araddr(araddr),
        .rvalid(rvalid),
        .rready(rready),
        .rdata(fir_rdata)
    );

    fir fir_DUT(
        .awready(awready),
        .wready(wready),
        .awvalid(awvalid),
        .awaddr(awaddr),
        .wvalid(wvalid),
        .wdata(fir_wdata),
        .arready(arready),
        .rready(rready),
        .arvalid(arvalid),
        .araddr(araddr),
        .rvalid(rvalid),
        .rdata(fir_rdata),
        .ss_tvalid(sm_tvalid),
        .ss_tready(sm_tready),
        .ss_tdata(sm_tdata),
        .ss_tlast(1'b0),
        .sm_tready(ss_tready),
        .sm_tvalid(ss_tvalid),
        .sm_tdata(ss_tdata),
        .sm_tlast(ss_tlast),

        // ram for tap
        .tap_WE(tap_WE),
        .tap_EN(tap_EN),
        .tap_Di(tap_Di),
        .tap_A(tap_A),
        .tap_Do(tap_Do),

        // ram for data
        .data_WE(data_WE),
        .data_EN(data_EN),
        .data_Di(data_Di),
        .data_A(data_A),
        .data_Do(data_Do),

        .axis_clk(clk),
        .axis_rst_n(~rst)

    );

    // RAM for tap
    bram11 tap_RAM (
        .CLK(clk),
        .WE(tap_WE),
        .EN(tap_EN),
        .Di(tap_Di),
        .A(tap_A),
        .Do(tap_Do)
    );

    // RAM for data: choose bram11 or bram12
    bram11 data_RAM(
        .CLK(clk),
        .WE(data_WE),
        .EN(data_EN),
        .Di(data_Di),
        .A(data_A),
        .Do(data_Do)
    );

    bram user_bram (
        .CLK(clk),
        .WE0(wstrb),
        .EN0(valid),
        .Di0(wbs_dat_i),
        .Do0(rdata),
        .A0(wbs_adr_i)
    );


endmodule

`default_nettype wire