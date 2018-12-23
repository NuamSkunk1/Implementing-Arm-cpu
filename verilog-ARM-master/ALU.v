module ALU(
	input [3:0] operation,
	input [63:0] i0,
	input [63:0] i1,
	output reg [63:0] out,
	output reg resultZero
);

	always
	begin
		#10;
		case(operation)
			4'b0000: out = i0&i1; // AND
			4'b0001: out = i0|i1; // OR
			4'b0010: out = i0+i1; // ADD
			4'b0110: out = i0-i1; // SUBTRACT
			4'b0111: out = i1; // PASS INPUT B
			4'b1100: out = ~(i0|i1); // NOR
		endcase
		if(out == 64'b0)
			resultZero = 1;
		else
			resultZero = 0;
	end

endmodule
