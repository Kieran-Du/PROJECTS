module top_sig(
    input clk,
    input reset,
    output dac_sdi,		// SPI serial data out
    output dac_cs,			// chip select - low when sending data to dac
    output dac_sck,		// SPI clock, 16 cycles at half sysclk freq
    output dac_ld
);
wire clk_10k;
wire clk_50M;
wire [9:0] data;
wire handshake;
wire load;
reg [1:0] handshake_r;
always@(posedge clk_50M or posedge reset)
if(reset)
    handshake_r <= 2'b0;
else
    handshake_r <= {handshake_r[0],handshake};

assign load = ^handshake_r;



clk_div u_clk_div(
    .clk_in(clk),
    .reset(reset),
    .clk_50M(clk_50M),
    .clk_10k(clk_10k)
);

DigSineGenerator u_DigSineGenerator(
    .clk(clk_10k),
    .reset(reset),
    .y(data),
    .handshake(handshake)
);

spi2dac u_spi2dac(
    .sysclk(clk_50M),
    .data_in(data),
    .load(load),
    .dac_sdi(dac_sdi),
    .dac_cs(dac_cs),			
    .dac_sck(dac_sck),		
    .dac_ld(dac_ld)
);


endmodule
