module    divider_cell
    #(parameter N=5,
      parameter M=3)
    (
      input                     clk,
      input                     reset,
      input                     en,

      input [M:0]               dividend,
      input [M-1:0]             divisor,
      input [N-M:0]             merchant_ci ,
      input [N-M-1:0]           dividend_ci , 

      output reg [N-M-1:0]      dividend_kp,  
      output reg [M-1:0]        divisor_kp,  
      output reg                rdy ,
      output reg [N-M:0]        merchant ,
      output reg [M-1:0]        remainder
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rdy            <= 'b0 ;
            merchant       <= 'b0 ;
            remainder      <= 'b0 ;
            divisor_kp     <= 'b0 ;
            dividend_kp    <= 'b0 ;
        end
        else if (en) begin
            rdy            <= 1'b1 ;
            divisor_kp     <= divisor ;
            dividend_kp    <= dividend_ci ;
            if (dividend >= {1'b0, divisor}) begin
                merchant    <= (merchant_ci<<1) + 1'b1 ;
                remainder   <= dividend - {1'b0, divisor} ;
            end
            else begin
                merchant    <= merchant_ci<<1 ;
                remainder   <= dividend ;
            end
        end // if (en)
        else begin
            rdy            <= 'b0 ;
            merchant       <= 'b0 ;
            remainder      <= 'b0 ;
            divisor_kp     <= 'b0 ;
            dividend_kp    <= 'b0 ;
        end
    end

endmodule