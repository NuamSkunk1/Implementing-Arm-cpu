module PC(
	input clock,
	input [31:0] in,
	output [31:0] out
);
	reg [31:0] data;
	initial
	begin
		data = 32'b0;	
	end

	always @(posedge clock)
	begin
		data = in;
	end	
	assign out = data;
endmodule
