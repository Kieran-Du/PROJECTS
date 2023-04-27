module clk_div(
    input           clk_in,
    input           reset,
    output reg      clk_10k,
    output reg      clk_50M
);

reg [17:0] cnt;



always@(posedge clk_in or posedge reset) begin
    if(reset)
        clk_50M <= 1'b0;
    else
        clk_50M <= ~ clk_50M;
end

always@(posedge clk_in or posedge reset) begin
    if(reset) begin 
        cnt <= 17'b0;
        clk_10k <= 1'b0;
    end
    else if(cnt == 17'd4999) begin
        cnt <= 17'b0;
        clk_10k <= ~ clk_10k;
        end
    else
        cnt <= cnt + 1;
end


endmodule
