module top(
    input           clk     ,
    input           reset   ,

    //button and switch
    input           sw0_in  ,
    input           btn0_in ,
    input           btn1_in ,
    input           btn2_in ,
    input           btn3_in ,

    //uart
    output          tx      ,

    //DAC
    output          dac_sdi ,
    output          dac_cs  ,
    output          dac_sck ,
    output          dac_ld
);


wire            div_valid   ;
wire  [17:0]    div_value   ;

wire  [10:0]    amp_value   ;
wire            mode        ;
wire            valid_dds   ;
wire            ready_dds   ;


wire  [15:0]    fre_bcd     ;
wire  [11:0]    amp_bcd     ;
wire            valid_uart  ;
wire            ready_uart  ;

wire            clk_DDS     ;
wire            clk_50M     ;


wire [10:0] amp_dds;
wire mode_dds;
wire valid_to_dds;
wire [9:0] data_out_dds;
wire handshake;
reg [2:0] handshake_r;
wire spi2dac_load = ^handshake_r[1:0];


//inst of ctrl
ctrl u_ctrl(
        .clk        (clk        ),
        .reset      (reset      ),

        .btn_in_0   (btn0_in    ),
        .btn_in_1   (btn1_in    ),
        .btn_in_2   (btn2_in    ),
        .btn_in_3   (btn3_in    ),

        .sw_in_0    (sw0_in     ),
        .div_valid  (div_valid  ),
        .div_value  (div_value  ),

        .amp_value  (amp_value  ),
        .mode       (mode       ),
        .valid_dds  (valid_dds  ),
        .ready_dds  (ready_dds  ),

        .fre_bcd    (fre_bcd    ),
        .amp_bcd    (amp_bcd    ),
        .valid_uart (valid_uart ),
        .ready_uart (ready_uart )

    );

//inst of data_send
data_send u_data_send(
        .clk     (clk       ),
        .reset   (reset     ),
        .fre_bcd (fre_bcd   ),
        .amp_bcd (amp_bcd   ),
        .valid   (valid_uart),
        .ready   (ready_uart),
        .tx      (tx        )
    );


clk_div u_clk_div(
    .clk_in         (clk        ),
    .reset          (reset      ),
    .clk_div        (div_value  ),
    .clk_div_valid  (div_valid  ),
    .clk_DDS        (clk_DDS    ),
    .clk_50M        (clk_50M    )
);

cdc_handshake u_cdc_handshake
(
    .reset      (reset      ),
    .clk_a      (clk        ),
    .amp_in     (amp_value  ),
    .mode_in    (mode       ),
    .valid_a    (valid_dds  ),
    .ready_a    (ready_dds  ),

    .clk_b      (clk_DDS    ),
    .amp_out    (amp_dds    ),
    .mode_out   (mode_dds   ),
    .valid_b    (valid_to_dds  )
);

//inst of DDS
DDS u_DDS(
    .clk        (clk_DDS    ),
    .reset      (reset      ),

    .amp        (amp_dds    ),
    .mode       (mode_dds   ),
    .valid      (valid_to_dds  ),

    .data_out   (data_out_dds),
    .handshake  (handshake   )
    );


//inst of spi2dac
spi2dac u_spi2dac(
    .sysclk  (clk_50M        ),
    .data_in (data_out_dds   ),
    .load    (spi2dac_load   ),
    .dac_sdi (dac_sdi        ),
    .dac_cs  (dac_cs         ),
    .dac_sck (dac_sck        ),
    .dac_ld  (dac_ld         )
    );



//logic of handshake_r
always @(posedge clk or posedge reset) begin
    if (reset) begin
        handshake_r <= 3'b0;
    end
    else begin
        handshake_r <= {handshake_r[1:0],handshake};
    end
end




endmodule