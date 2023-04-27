module FIRFilter(
    input               clock,
    input               reset,
    input       [9:0]   x,
    output      [9:0]   y
    );


//definitions
reg [9:0] delay_1,delay_2,delay_3,delay_4;
wire [9:0] mul_0,mul_1,mul_2,mul_3,mul_4;

//data shift
always @(posedge clock or posedge reset) begin
    if (reset) begin
        delay_1 <= 10'b0;
        delay_2 <= 10'b0;
        delay_3 <= 10'b0;
        delay_4 <= 10'b0;
    end
    else begin
        delay_1 <= x;
        delay_2 <= delay_1;
        delay_3 <= delay_2;
        delay_4 <= delay_3;
    end
end

//coef mult
//000110011 coef
assign mul_0 = (x       >> 3) + (x       >> 4) + (x       >> 7) + (x       >> 8);
assign mul_1 = (delay_1 >> 3) + (delay_1 >> 4) + (delay_1 >> 7) + (delay_1 >> 8);
assign mul_2 = (delay_2 >> 3) + (delay_2 >> 4) + (delay_2 >> 7) + (delay_2 >> 8);
assign mul_3 = (delay_3 >> 3) + (delay_3 >> 4) + (delay_3 >> 7) + (delay_3 >> 8);
assign mul_4 = (delay_4 >> 3) + (delay_4 >> 4) + (delay_4 >> 7) + (delay_4 >> 8);

//outcome
assign y = mul_0 + mul_1 + mul_2 + mul_3 + mul_4;



endmodule

