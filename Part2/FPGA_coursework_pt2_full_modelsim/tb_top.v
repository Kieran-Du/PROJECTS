module tb_top;

reg           clk     ;
reg           reset   ;

//button and switch
reg           sw0_in  ;
reg           btn0_in ;
reg           btn1_in ;
reg           btn2_in ;
reg           btn3_in ;

//uart
wire          tx      ;


//DAC
wire          dac_sdi ;
wire          dac_cs  ;
wire          dac_sck ;
wire          dac_ld  ;






initial begin
    #100;


        repeat(9) begin
            repeat(5000) begin
              @(negedge  clk);
              btn2_in = $random();
              #1;
              @(negedge  clk);
            end
            btn2_in = 1'b1;
            #30000;
            repeat(5000) begin
              @(negedge  clk);
              btn2_in = $random();
              #1;
              @(negedge  clk);
            end
            btn2_in = 1'b0;
            #500000;
        
        #10000000;
        end
  repeat(20) begin
    repeat(5000) begin
        @(negedge  clk);
        btn0_in = $random();
        #1;
        @(negedge  clk);
    end

    btn0_in = 1'b1;

    #30000;
    repeat(5000) begin
        @(negedge  clk);
        btn0_in = $random();
        #1;
        @(negedge  clk);
    end
    btn0_in = 1'b0;
    #500000;   
    #10000000; 
  end


    #1000;
    //$finish;
end



//reset
initial begin
    clk = 1'b0;
    reset = 1'b1;
    sw0_in = 1'b0;
    btn0_in = 1'b0;
    btn1_in = 1'b0;
    btn2_in = 1'b0;
    btn3_in = 1'b0;
    #13;
    reset = 1'b0;
end


always #5 clk = ~clk;




top u_top(
    .clk    (clk        ),
    .reset  (reset      ),

    .sw0_in (sw0_in     ),
    .btn0_in(btn0_in    ),
    .btn1_in(btn1_in    ),
    .btn2_in(btn2_in    ),
    .btn3_in(btn3_in    ),

    .tx     (tx         ),

    .dac_sdi(dac_sdi    ),
    .dac_cs (dac_cs     ),
    .dac_sck(dac_sck    ),
    .dac_ld (dac_ld     )
    );



endmodule