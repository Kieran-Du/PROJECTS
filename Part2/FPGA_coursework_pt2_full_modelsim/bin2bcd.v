module bin2bcd #(
    parameter W = 18
) 
(

    input [W - 1 : 0] bin ,  

    output reg [W + (W - 4) / 3: 0] bcd
);

integer i, j;

always @(bin) begin
    for (i = 0; i <= W + (W - 4) / 3; i = i + 1)
        bcd[i] = 0;     
    bcd[W - 1: 0] = bin;                                
    for (i = 0; i <= W - 4; i = i + 1)                    
        for (j = 0; j <= i / 3; j = j + 1)                   
            if (bcd[W - i + 4 * j -: 4] > 4)                
                bcd[W - i + 4 * j -: 4] = bcd[W - i + 4 * j -: 4] + 4'd3; 
end

endmodule
