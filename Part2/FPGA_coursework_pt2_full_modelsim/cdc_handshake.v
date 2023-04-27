module cdc_handshake
(
	input				reset,
	input				clk_a,
	input		[10:0] 	amp_in,
	input				mode_in,
	input				valid_a,
	output	reg			ready_a,

	input				clk_b,
	output	reg	[10:0]	amp_out,
	output	reg			mode_out,
	output	reg			valid_b
);

	reg 				valid_cdc;
	reg	[10:0]			amp_temp;
	reg                            mode_temp;

	reg	valid_cdc_r,valid_cdc_2r,valid_cdc_3r;
	reg	response,response_r,response_2r,response_3r;

	wire valid_cdc_b = valid_cdc_2r ^ valid_cdc_3r;
	wire response_a = response_2r ^ response_3r;

	always@(posedge clk_a or posedge reset)
	begin
		if(reset) begin
			valid_cdc <= 1'b0;
			amp_temp  <= 11'b00111111111;
			mode_temp <= 1'b0;
		end
		else if(ready_a & valid_a) begin
			valid_cdc <= ~valid_cdc;
			mode_temp <= mode_in;
			amp_temp <= amp_in;
		end
	end

	always@(posedge clk_a or posedge reset)
	begin
		if(reset) begin
			ready_a <= 1'b1;
		end
		else if(ready_a & valid_a) begin
			ready_a <= 1'b0;
		end
		else if(response_a)
			ready_a <= 1'b1;
	end
	

	always@(posedge clk_b or posedge reset)
	begin
		if(reset) begin
			valid_cdc_r  <= 1'b0	;
			valid_cdc_2r <= 1'b0	;
			valid_cdc_3r <= 1'b0	;
		end
		else begin
			valid_cdc_r  <= valid_cdc;
			valid_cdc_2r <= valid_cdc_r;
			valid_cdc_3r <= valid_cdc_2r;
		end
	end

	always@(posedge clk_a or posedge reset)
	begin
		if(reset) begin
			response_r  <= 1'b0	;
			response_2r <= 1'b0	;
			response_3r <= 1'b0	;
		end
		else begin
			response_r  <= response;
			response_2r <= response_r;
			response_3r <= response_2r;
		end
	end

	always@(posedge clk_b or posedge reset)
	begin
		if(reset) begin
			amp_out <= 11'b00111111111;
			mode_out <= 1'b0;
			valid_b <= 1'b0;
			response <= 1'b0;
		end
		else if(valid_b)
			valid_b <= 1'b0;
		else if(valid_cdc_b) begin
			amp_out <= amp_temp;
			mode_out <= mode_temp;
			valid_b <= 1'b1;
			response <= ~response;
		end
	end



endmodule
