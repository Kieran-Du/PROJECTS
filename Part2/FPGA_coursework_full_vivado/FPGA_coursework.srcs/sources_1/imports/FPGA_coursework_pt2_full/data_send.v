module data_send(
    input           clk,
    input           reset,
    input   [15:0]  fre_bcd,
    input   [11:0]  amp_bcd,
    input           valid,
    output  reg     ready,
    output          tx
    );

//********defitions**********//
//"Fre:xxxxHz, Amp:x.xxV\n"
reg [7:0] data_r [0:21];
wire [7:0] sym0 = 8'b00110000; // ascii of '0'
wire ready_tx;
reg valid_tx;
reg [4:0] byte_cnt;
wire [7:0] data = data_r[byte_cnt];


//*******valid_tx************//
always @(posedge clk or posedge reset) begin
    if (reset) begin
        valid_tx <= 1'b0;
    end
    else if (ready & valid) begin
        valid_tx <= 1'b1;
    end
    else if(byte_cnt == 5'd21)
        valid_tx <= 1'b0;
end

//*******byte_cnt************//
always@(posedge clk or posedge reset) begin
    if(reset)
        byte_cnt <= 5'd0;
    else if(byte_cnt == 5'd21)
        byte_cnt <= 5'd0;
    else if(valid_tx & ready_tx)
        byte_cnt <= byte_cnt + 1'b1;
end

//*******ready**************//
always @(posedge clk or posedge reset) begin
    if (reset) begin
        ready <= 1'b1;
    end
    else if (ready & valid) begin
        ready <= 1'b0;
    end
    else if(byte_cnt == 5'd0 && (!valid_tx) && ready_tx) begin
        ready <= 1'b1;
    end
end



//******init data_r*********//

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_r[0] <= 8'b01000110; //'F'
        data_r[1] <= 8'b01110010; //'r'
        data_r[2] <= 8'b01100101; //'e'
        data_r[3] <= 8'b00111010; //':'
        data_r[4] <= sym0;
        data_r[5] <= sym0;
        data_r[6] <= sym0;
        data_r[7] <= sym0;
        data_r[8] <= 8'b01001000; //'H'
        data_r[9] <= 8'b01111010; //'z'
        data_r[10] <= 8'b00101100; //','
        data_r[11] <= 8'b00100000; //' '
        data_r[12] <= 8'b01000001; //'A'
        data_r[13] <= 8'b01101101; //'m'
        data_r[14] <= 8'b01110000; //'p'
        data_r[15] <= 8'b00111010; //':'
        data_r[16] <= sym0;
        data_r[17] <= 8'b00101110; //'.'
        data_r[18] <= sym0;
        data_r[19] <= sym0;
        data_r[20] <= 8'b01010110; //'V'
        data_r[21] <= 8'b00001101; //'\n'
    end
    else if (valid & ready) begin
        data_r[4] <= sym0 + fre_bcd[15:12];
        data_r[5] <= sym0 + fre_bcd[11:8];
        data_r[6] <= sym0 + fre_bcd[7:4];
        data_r[7] <= sym0 + fre_bcd[3:0];


        data_r[16] <= sym0 + amp_bcd[11:8];
        data_r[18] <= sym0 + amp_bcd[7:4];
        data_r[19] <= sym0 + amp_bcd[3:0];

    end
end


//*******inst of uart tx*****//
uart_tx u_tx(
    .clk    (clk    ),
    .reset  (reset  ),
    .valid  (valid_tx),
    .data   (data),
    .ready  (ready_tx),
    .tx     (tx     )
);

endmodule