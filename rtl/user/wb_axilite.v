module wb_axilite
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

    awvalid,
    awready,
    awaddr,
    wvalid,
    wready,
    wdata,

    arvalid,
    arready,
    araddr,
    rvalid,
    rready,
    rdata
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
    wb_valid = wbs_cyc_i && wbs_stb_i && (wbs_adr_i == 0x30000000~0x3000007F); //for axilite
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

    // axilite write signal(transmit coef from wb to fir)
    output reg  awvalid;
    input  wire awready;
    output reg [pADDR_WIDTH-1:0] awaddr;
    output reg  wvalid;
    input  wire wready;
    output reg [pDATA_WIDTH-1:0] wdata;

    // axilite write signal(transmit coef from wb to fir)
    output reg  arvalid;
    input  wire arready;
    output reg  [pADDR_WIDTH-1:0] araddr;
    input  wire rvalid;
    output reg  rready;
    input  wire [pDATA_WIDTH-1:0] rdata;

    // the return signal from fir to wb
    always@(posedge clk) begin
        if (rst) begin
        wb_ready  <= 1'b0;
        wbs_dat_o <= 32'h0;
        end else begin
            if (wb_valid && !wb_ready) begin
                if (wbs_we_i) begin
                    wb_ready  <= wready;
                    wbs_dat_o <= 32'h0;
                end else begin
                    wb_ready  <= rvalid;
                    wbs_dat_o <= rdata;
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
            //write initialize
            awvalid   <= 1'b0;
            wvalid    <= 1'b0;
            awaddr    <= wbs_adr_i[pADDR_WIDTH-1:0];
            wdata     <= wbs_dat_i;
            //read initialize
            arvalid   <= 1'b0;
            rready    <= 1'b0;
            araddr    <= wbs_adr_i[pADDR_WIDTH-1:0];
        end else begin
            if (wbs_we_i) begin
                awvalid   <= wb_valid;
                awaddr    <= wbs_adr_i[pADDR_WIDTH-1:0];
                wvalid    <= wb_valid;
                wdata     <= wbs_dat_i;

                arvalid   <= 1'b0;
                rready    <= 1'b0;
                araddr    <= wbs_adr_i[pADDR_WIDTH-1:0];
            end else begin
                awvalid   <= 1'b0;
                wvalid    <= 1'b0;
                awaddr    <= wbs_adr_i[pADDR_WIDTH-1:0];
                wdata     <= wbs_dat_i;

                arvalid   <= wb_valid;
                araddr    <= wbs_adr_i[pADDR_WIDTH-1:0];
                rready    <= wb_valid;
                end
            end
        end
endmodule
    

