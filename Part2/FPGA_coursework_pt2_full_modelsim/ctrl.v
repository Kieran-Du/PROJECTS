module ctrl(
    input               clk     , //100Mhz
    input               reset       ,

    //input from buttons
    input               btn_in_0    ,
    input               btn_in_1    ,
    input               btn_in_2    ,
    input               btn_in_3    ,

    //input from switch
    input               sw_in_0     ,

    //to clk div
    output              div_valid   ,
    output      [17:0]  div_value   ,

    //interface with cdc handshake
    output reg  [10:0]  amp_value   ,
    output reg          mode        ,
    output reg          valid_dds   ,
    input               ready_dds   ,

    //interface with data_send
    output      [15:0]  fre_bcd     ,
    output      [11:0]  amp_bcd     ,
    output reg          valid_uart  ,
    input               ready_uart

);

//***********definitions*****************//
wire btn_0,btn_1,btn_2,btn_3;
wire sw_0;
reg [10:0] fre_r;
reg fre_valid;
reg sw_r;
wire [17:0] amp_value_3v3;


//**********logic of fre_r**************//
always @(posedge clk or posedge reset) begin
    if (reset) begin
        fre_r <= 11'd440;
        fre_valid <= 1'b0;
    end
    else if (btn_0 && fre_r <= 11'd1990) begin
        fre_r <= fre_r + 11'd10;
        fre_valid <= 1'b1;
    end
    else if(btn_1 && fre_r >= 11'd110) begin
        fre_r <= fre_r -11'd10;
        fre_valid <= 1'b1;
    end
    else begin
        fre_valid <= 1'b0;
    end
end

//******interface with dds handshake**********//
always @(posedge clk or posedge reset) begin
    if (reset) begin
        mode <= sw_0;
    end
    else if(sw_r ^ sw_0) begin
        mode <= sw_0;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        sw_r <= 1'b0;
    end
    else begin
        sw_r <= sw_0;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        amp_value <= 11'b00111111111;
    end
    else if (btn_2 && amp_value >= 11'd30) begin
        amp_value <= amp_value - 11'd25;

    end
    else if(btn_3 && amp_value <= 11'd486) begin
        amp_value <= amp_value + 11'd25;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        valid_dds <= 1'b0;
    end
    else if (valid_dds & ready_dds) begin
        valid_dds <= 1'b0;
    end
    else if((btn_2 && amp_value >= 11'd30) || (btn_3 && amp_value <= 11'd486) || (sw_r ^ sw_0)) begin
        valid_dds <= 1'b1;
    end
end

//interface with data_send
always @(posedge clk or posedge reset) begin
    if (reset) begin
        valid_uart <= 1'b0;
    end
    else if (valid_uart & ready_uart) begin
        valid_uart <= 1'b0;
    end
    else if((btn_2 && amp_value >= 11'd30) || (btn_3 && amp_value <= 11'd486) || (btn_0 && fre_r <= 11'd1990) || (btn_1 && fre_r >= 11'd110)) begin
        valid_uart <= 1'b1;
    end
end

assign amp_value_3v3 = ({amp_value,8'b0} + {amp_value,6'b0} + {amp_value,3'b0} + {amp_value,1'b0}) >> 9;

//***************inst********************//

//inist of buttons
btn u0_btn(
        .clk        (clk        ),
        .reset      (reset      ),
        .btn_in     (btn_in_0   ),
        .btn_valid  (btn_0      )
    );

btn u1_btn(
        .clk        (clk        ),
        .reset      (reset      ),
        .btn_in     (btn_in_1   ),
        .btn_valid  (btn_1      )
    );

btn u2_btn(
        .clk        (clk        ),
        .reset      (reset      ),
        .btn_in     (btn_in_2   ),
        .btn_valid  (btn_2      )
    );

btn u3_btn(
        .clk        (clk        ),
        .reset      (reset      ),
        .btn_in     (btn_in_3   ),
        .btn_valid  (btn_3      )
    );

//inst of switch
sw u0_sw(
        .clk        (clk        ),
        .reset      (reset      ),
        .sw_in      (sw_in_0    ),
        .sw_valid   (sw_0       )
    );

//divider
divider_man #(
        .M          (11         ),
        .N          (22         )
    )u_divider_man(

        .clk        (clk        ),
        .reset      (reset      ),
        .data_rdy   (fre_valid  ),
        .dividend   (22'd2200000),
        .divisor    (fre_r      ),
        .res_rdy    (div_valid  ),
        .merchant   (div_value  )
    );

bin2bcd #(
        .W(18)

    ) fre2bcd(
        .bin(fre_r),
        .bcd(fre_bcd)
    );

bin2bcd #(
        .W(18)
    ) amp2bcd (
        .bin(amp_value_3v3),
        .bcd(amp_bcd)
    );




endmodule