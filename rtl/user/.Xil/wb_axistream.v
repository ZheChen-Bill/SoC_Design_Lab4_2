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

    // transfer 
endmodule
