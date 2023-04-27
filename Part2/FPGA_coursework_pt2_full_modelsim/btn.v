module btn
#(
    parameter CNT_MAX = 21'd1_999_999
)
(
    input       clk         ,
    input       reset       ,
    input       btn_in      ,

    output reg  btn_valid

);


reg [20:0] cnt ;



always@(posedge clk or posedge reset)
    if(reset)
        cnt <= 21'b0;
    else if(btn_in == 1'b0)
        cnt <= 21'b0;
    else if(cnt == CNT_MAX && btn_in == 1'b1)
        cnt <= cnt;
    else
        cnt <= cnt + 1'b1;


always@(posedge clk or posedge reset)
    if(reset)
        btn_valid <= 1'b0;
    else if(cnt == CNT_MAX - 1'b1)
        btn_valid <= 1'b1;
    else
        btn_valid <= 1'b0;

endmodule