module wb_axistream
#(  parameter pADDR_WIDTH=12,
    parameter pDATA_WIDTH=32
)(
    clk,
    rst,

    wbs_adr_i,
    wb_valid,
    wb_ready,
    wbs_we_i,
    wbs_dat_i,
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
    input wire clk;
    input wire rst;

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
    input  wire [pDATA_WIDTH-1:0] wbs_adr_i;
    input  wire wb_valid;
    output reg  wb_ready;
    input  wire wbs_we_i;
    input  wire [pDATA_WIDTH-1:0] wbs_dat_i;
    output reg  [pDATA_WIDTH-1:0] wbs_dat_o;

    // stream master signal(transmit data from wb to fir)
    output reg  sm_tvalid;
    input  wire sm_tready;
    output reg  [pDATA_WIDTH-1:0] sm_tdata;
    //output wire sm_tlast;

    // stream slave signal (receive data from fir to wb)
    input  wire ss_tvalid;
    output reg  ss_tready;
    input  wire [pDATA_WIDTH-1:0] ss_tdata;
    //input  wire ss_tlast;

    // register for input X[n];
    reg [pDATA_WIDTH-1:0] inputbuffer;

    // the return signal from fir to wb
    always@(posedge clk) begin
        if (rst) begin
            wb_ready  <= 1'b0;
            wbs_dat_o <= 32'h0;
        end else begin
            if (wb_valid && !wb_ready) begin
                    if ((wbs_adr_i == 32'h30000080) && wbs_we_i) begin
                        wb_ready  <= sm_tready;
                        wbs_dat_o <= 32'h0;
                    end else if ((wbs_adr_i == 32'h30000080) && (!wbs_we_i)) begin
                        wb_ready  <= 1'b1;
                        wbs_dat_o <= inputbuffer;
                    end else if ((wbs_adr_i == 32'h30000084) && (!wbs_we_i)) begin
                        wb_ready  <= ss_tvalid;
                        wbs_dat_o <= ss_tdata;
                    end else if ((wbs_adr_i == 32'h30000084) && (wbs_we_i)) begin
                        wb_ready  <= 1'b1;
                        wbs_dat_o <= 32'h0;
                    end else begin
                        wb_ready  <= 1'b0;
                        wbs_dat_o <= 32'h0;
                    end
                end else begin
                    wb_ready  <= 1'b0;
                    wbs_dat_o <= 32'h0;
                end
            end
        end 

    // the input signal from wb to fir
    always@(posedge clk) begin
        if (rst) begin
            sm_tvalid <= 1'b0;
            sm_tdata  <= 32'h0;
            ss_tready <= 1'b0;
        end else begin 
            if ((wbs_adr_i == 32'h30000080) && wbs_we_i) begin
                sm_tvalid <= wb_valid;
                sm_tdata  <= wbs_dat_i;
                ss_tready <= 1'b0;
            end else if ((wbs_adr_i == 32'h30000080) && (!wbs_we_i)) begin
                sm_tvalid <= 1'b0;
                sm_tdata  <= 32'h0;
                ss_tready <= 1'b0;
            end else if ((wbs_adr_i == 32'h30000084) && (!wbs_we_i)) begin
                sm_tvalid <= 1'b0;
                sm_tdata  <= 32'h0;
                ss_tready <= wb_valid;
            end else begin
                sm_tvalid <= 1'b0;
                sm_tdata  <= wbs_dat_i;
                ss_tready <= 1'b0;
            end
        end
    end

    always@(posedge clk) begin
        if (rst) begin
            inputbuffer <= 32'h0;
        end else if(wbs_we_i) begin
            inputbuffer <= wbs_dat_i;
        end else begin
            inputbuffer <= inputbuffer;
        end
    end

endmodule
    

