module tb_topall;
 reg clk;
 reg reset;
 wire dac_sdi;		
 wire dac_cs;	
 wire dac_sck;	
 wire dac_ld;


initial begin
    clk = 1'b1;

end
initial begin
    reset = 1'b1;
    #40;
    reset = 1'b0;
    #40;
    reset = 1'b1;
    #40;
    reset = 1'b0;
end

always #5 clk = ~clk; //100MHz

top_sig u_top_sig(
    .clk(clk),
    .reset(reset),
    .dac_sdi(dac_sdi),
    .dac_cs(dac_cs),			
    .dac_sck(dac_sck),		
    .dac_ld(dac_ld)
);


endmodule
