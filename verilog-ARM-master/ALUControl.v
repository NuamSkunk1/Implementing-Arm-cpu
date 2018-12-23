module ALUControl(
	input [1:0] AluOP,
	input [5:0] in2,
	output reg [3:0] out
);

	always 
	begin
		#10;
		casex (AluOP)
			2'b00: out = 4'b0010; // LW SW
			2'bx1: out = 4'b0110; // branch
			2'b1x: casex(in2) // R-type
					6'bxx0000: out = 4'b0010;
					6'bxx0010: out = 4'b0110;
					6'bxx0100: out = 4'b0000;
					6'bxx0101: out = 4'b0001;
					6'bxx1010: out = 4'b0111;
				endcase
		endcase
	end

endmodule 
