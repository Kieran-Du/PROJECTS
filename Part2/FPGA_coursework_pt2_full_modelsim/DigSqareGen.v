module DigSqareGen(
    input                   clk         ,
    input                   reset       ,
    input           [10:0]  amp         ,
    output          [9:0]   y           ,
    output  reg             handshake
);

reg [4:0] cnt;
reg [10:0] y_r;

assign y = y_r + 10'd512;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        handshake <= 1'b0;
        y_r <=10'b0111111111;
    end
    else if (cnt == 5'd23) begin
        y_r  <= (~amp + 1);
        handshake <= ~handshake;
    end
    else if(cnt ==4'd12) begin
        y_r  <= amp;
        handshake <= ~handshake;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt <= 5'd0;
    end
    else if (cnt == 5'd23) begin
        cnt <= 5'd0;
    end
    else begin
        cnt <= cnt + 1'd1;
    end
end




endmodule
