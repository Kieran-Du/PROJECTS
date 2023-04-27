module uart_tx
#(
    parameter BAUDRATE = 115200,
    parameter CLKRATE = 100_000_000
)
(
    input           clk ,
    input           reset,
    input           valid,
    input   [7:0]   data,
    output  reg     ready,
    output  reg     tx
    );

//**********definitions**********************//
parameter BAUD_MAX = CLKRATE/BAUDRATE - 1; // the maximum of baud_count

reg [9:0] baud_cnt;

reg [1:0] st_cr,st_nx; //state machine
parameter   IDLE  = 2'd0,
             START = 2'd1,
             TRS   = 2'd2,
             STOP  = 2'd3;
reg [7:0] data_r;
reg [2:0] data_cnt;

//********behavior of state machine******//
always@(posedge clk or posedge reset) begin
    if(reset)
        st_cr <= IDLE;
    else
        st_cr <= st_nx;
end

always@(*) begin
    if(reset)
        st_nx = IDLE;
    else begin
        case(st_cr)
            IDLE:
                if(ready & valid)
                    st_nx = START;
                else
                    st_nx = IDLE;
            START:
                if(baud_cnt == BAUD_MAX)
                    st_nx = TRS;
                else
                   st_nx = START;
            TRS:
                if(baud_cnt == BAUD_MAX && data_cnt == 3'd7)
                    st_nx = STOP;
                else
                    st_nx = TRS;
            STOP:
                if(baud_cnt == BAUD_MAX)
                    st_nx = IDLE;
                 else
                    st_nx = STOP;
            default:
                st_cr = IDLE;
        endcase
    end
end

//*********behavior of ready*******//
always@(posedge clk or posedge reset) begin
    if(reset)
        ready <= 1'b1;
    else if(valid & ready)
        ready <= 1'b0;
    else if(st_cr == IDLE)
        ready <= 1'b1;
end

//********bahavior of baud_cnt******//
always@(posedge clk or posedge reset) begin
    if(reset)
        baud_cnt  <= 10'b0;
    else if(baud_cnt == BAUD_MAX || st_cr == IDLE)
        baud_cnt <= 10'b0;
    else
        baud_cnt <= baud_cnt + 1'b1;
end


//********bahavior of data_cnt*****//
always@(posedge clk or posedge reset) begin
    if(reset)
        data_cnt <= 3'b0;
    else if(st_cr == IDLE)
        data_cnt <= 3'b0;
    else if(baud_cnt == BAUD_MAX && st_cr == TRS)
        data_cnt <= data_cnt + 1'b1;
end

//********behavior of tx**********//
always@(posedge clk or posedge reset) begin
    if(reset) begin
        tx <= 1'b1;
    end
    else if(st_cr == TRS && baud_cnt == 10'd0) begin
        tx <= data_r[data_cnt];
    end
    else if(st_cr == START) begin
        tx <= 1'b0;
    end
    else if(st_cr == IDLE || st_cr == STOP) begin
        tx <= 1'b1;
    end
end
//********behavior of data_r******//
always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_r <= 8'b0;

    end
    else if (valid & ready) begin
        data_r <= data;
    end
end





endmodule
