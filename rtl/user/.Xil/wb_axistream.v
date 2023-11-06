module wb_axistream(
    clk,
    rst_n,
    wb_valid,
    wb_ready,
    wbs_we_i,
    wdata,
    wbs_dat_o,
    sm_tvalid,
    sm_tready,
    sm_tdata,
    sm_tlast,
    ss_tvalid,
    ss_tready,
    ss_tdata,
    ss_tlast
);
    // clock and reset signal
    input wire clk;
    input wire rst_n;
    // wishbone signal     
    /*
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    wb_valid = wbs_cyc_i && wbs_stb_i && (wbs_adr_i == 0x30000080); //for axi_stream_write
    wb_valid = wbs_cyc_i && wbs_stb_i && (wbs_adr_i == 0x30000084); //for axi_stream_read
    wstrb = wbs_sel_i & {4{wbs_we_i}};
    wbs_dat_o = rdata; //output data
    wdata = wbs_dat_i; //input data
    */

    input  wire wb_valid;
    output wire wb_ready;
    input  wire wbs_we_i;
    input  wire wdata;
    output wire wbs_dat_o;

    // stream master signal(transmit data from wb to fir)
    output wire sm_tvalid;
    input  wire sm_tready;
    output wire sm_tdata;
    output wire sm_tlast;
    // stream slave signal (receive data from fir to wb)
    input  wire ss_tvalid;
    output wire ss_tready;
    input  wire ss_tdata;
    input  wire ss_tlast;

    // transfer wbs to stream
    always@* begin
        if (wbs_we_i) begin

        end else begin

    assign sm_tvalid = wb_valid;
    assign sm_tready = wb_ready;
    assign 
    end



















endmodule
