
module Testbench ();

    reg clock;
    reg reset;
    wire [9:0] y;
    reg [0:8] address;
    wire [9:0] dataOut;

    dataROM u_dataROM(
        .clock(clock),
        .address(address),
        .dataOut(dataOut)
        );

    FIRFilter u_FIRFilter(
        .clock(clock),
        .reset(reset),
        .x(dataOut),
        .y(y)
        );

    initial begin
        clock = 0;
        reset = 1;
        #5;
        reset = 0;
    end

    always #10 clock = ~ clock ;

    always@(posedge clock or posedge reset)
    if(reset)
        address <= 9'b0;
    else if(address == 10'd511) begin
        #1;
	address <= 9'd0;
    end
    else begin
	#1;
        address <= address + 1'b1;
    end




endmodule
