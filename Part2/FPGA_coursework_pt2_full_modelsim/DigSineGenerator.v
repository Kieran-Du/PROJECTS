module DigSineGenerator(
    input                   clk,
    input                   reset,
    input           [10:0]  y2_init,
    input                   valid   ,
    output signed   [9:0]   y,
    output reg handshake
);
reg signed [10:0] y_1,y_2;
wire signed [10:0] y_r;

always@(posedge clk or posedge reset) begin
    if(reset)
        handshake <= 1'b0;
    else
        handshake <= ~handshake;
end


always@(posedge clk or posedge reset) begin
    if(reset) begin
        y_1 <= 11'b0;
        y_2 <= 11'b00010000000;  //sin(2*pi*F0/Fs)
    end
    else if(valid) begin
        y_1 <= 11'b0;
        y_2 <= y2_init;
    end
    else begin
        y_1 <= y_r;
        y_2 <= y_1;
    end
end

//012356
assign y_r = {y_1[10],{0{y_1[10]}},y_1[9:0]} + {y_1[10],{1{y_1[10]}},y_1[9:1]} + {y_1[10],{2{y_1[10]}},y_1[9:2]} + {y_1[10],{3{y_1[10]}},y_1[9:3]} + {y_1[10],{5{y_1[10]}},y_1[9:5]} + {y_1[10],{6{y_1[10]}},y_1[9:6]} - y_2;
 
assign y = y_r + 10'd512;


endmodule