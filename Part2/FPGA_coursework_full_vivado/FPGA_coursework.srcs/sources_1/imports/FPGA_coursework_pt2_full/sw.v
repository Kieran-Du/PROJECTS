module sw
#(

    parameter CNT_MAX = 13'd4999 //50ms
)(
    input       clk, //100Mhz
    input       reset,
    input       sw_in,
    output reg  sw_valid
);

reg [2:0] sw_in_r;
reg [12:0] cnt;
reg flag;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        sw_in_r <= 3'b0;
    end
    else begin
        sw_in_r <= {sw_in_r[1:0],sw_in};
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        flag <= 1'b0;
    end
    else if (cnt == CNT_MAX) begin
        flag <= 1'b0;
    end
    else if(^sw_in_r[2:1])
        flag <= 1'b1;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt <= 13'b0;
    end
    else if (^sw_in_r[2:1] || flag == 1'b0) begin
        cnt <= 13'b0;
    end
    else if(flag)
        cnt <= cnt + 1'b1;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        sw_valid <= 1'b0;
    end
    else if (cnt == CNT_MAX) begin
        sw_valid <= sw_in_r[2];
    end
end


endmodule