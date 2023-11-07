module wb_axistream(
//    clk,
//    rst_n,
    wb_valid,
    wb_ready,
    wbs_we_i,
    wdata,
    wbs_dat_o,
    sm_tvalid,
    sm_tready,
    sm_tdata,
//    sm_tlast,
    ss_tvalid,
    ss_tready,
    ss_tdata
//    ss_tlast
);
    // clock and reset signal
    //input wire clk;
    //input wire rst_n;

    /*
    // wishbone origin signal
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

    // wishbone transform
    wb_valid = wbs_cyc_i && wbs_stb_i && (wbs_adr_i == 0x30000080); //for axi_stream_write
    wb_valid = wbs_cyc_i && wbs_stb_i && (wbs_adr_i == 0x30000084); //for axi_stream_read
    assign wbs_ack_o = wb_ready;
    wstrb = wbs_sel_i & {4{wbs_we_i}};
    wbs_dat_o = rdata; //output data
    wdata = wbs_dat_i; //input data
    */

    // wishbone signal
    input  wire wb_valid;
    output reg  wb_ready;
    input  wire wbs_we_i;
    input  wire wdata;
    output reg  wbs_dat_o;

    // stream master signal(transmit data from wb to fir)
    output reg  sm_tvalid;
    input  wire sm_tready;
    output reg  sm_tdata;
    //output wire sm_tlast;

    // stream slave signal (receive data from fir to wb)
    input  wire ss_tvalid;
    output reg  ss_tready;
    input  wire ss_tdata;
    //input  wire ss_tlast;

    // transfer wbs to stream
    always@* begin
        if (wbs_we_i) begin
            sm_tvalid = wb_valid;
            wb_ready = sm_tready;
            sm_tdata  = wdata;
        end else begin
            ss_tready = wb_valid;
            wb_ready = ss_tvalid;
            wbs_dat_o = ss_tdata;
        end
    end

endmodule
    

