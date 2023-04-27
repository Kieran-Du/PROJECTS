module clk_div(
    input           clk_in,
    input           reset,
    input   [17:0]  clk_div,
    input           clk_div_valid,
    output reg      clk_DDS,
    output reg      clk_50M
);

reg [17:0] cnt;
reg [17:0] clk_div_r;

always @(posedge clk_in or posedge reset) begin
    if (reset) begin
        clk_div_r <= 18'd4999;
    end
    else if (clk_div_valid) begin
        clk_div_r <= clk_div;
    end
end

always@(posedge clk_in or posedge reset) begin
    if(reset)
        clk_50M <= 1'b0;
    else
        clk_50M <= ~ clk_50M;
end

always@(posedge clk_in or posedge reset) begin
    if(reset) begin 
        cnt <= 17'b0;
        clk_DDS <= 1'b0;
    end
    else if(cnt >= clk_div_r) begin
        cnt <= 17'b0;
        clk_DDS <= ~ clk_DDS;
        end
    else
        cnt <= cnt + 1;
end


endmodule