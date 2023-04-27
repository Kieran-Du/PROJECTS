module DDS(
    input           clk     ,
    input           reset   ,

    //interface with cdc_handshake
    input   [10:0]  amp     ,
    input           mode    ,
    input           valid   ,


    //interface with spi2dac
    output signed [9:0]   data_out,
    output          handshake
);

reg [10:0] amp_r;
reg mode_r;
wire [9:0] data_out_sine, data_out_sqare;
wire handshake_sine,handshake_sqare;


wire [10:0] y2_init_sine = (amp >> 2) + (amp >> 6) + (amp >> 8) + (amp >> 9);


assign data_out = mode ? data_out_sqare : data_out_sine;
assign handshake = mode ? handshake_sqare : handshake_sine;


always @(posedge clk or posedge reset) begin
    if (reset) begin
        amp_r <= 11'b00111111111;
        mode_r <= 1'b0;
    end
    else if (valid) begin
        amp_r <= amp;
        mode_r <= mode;
    end
end



//inst of DigSineGenerator

DigSineGenerator u_DigSineGenerator(
        .clk        (clk            ),
        .reset      (reset          ),
        .y2_init    (y2_init_sine   ),
        .valid      (valid          ),
        .y          (data_out_sine  ),
        .handshake  (handshake_sine )
    );

//inst of DigSqareGen
DigSqareGen u_DigSqareGen(
        .clk      (clk              )   ,
        .reset    (reset            )   ,
        .amp      (amp              )   ,
        .y        (data_out_sqare   )   ,
        .handshake(handshake_sqare  )
    );


endmodule