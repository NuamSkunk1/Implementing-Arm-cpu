module SignExtend32to64
		#( 
 		 parameter n = 64,
 		 parameter delay = 100
			)
			(
			 input [n-1:0] instruction,
			 output reg [n-1:0] out);
	 #delay always @(instruction) begin
		case(instruction[31:29])
		3'b010: out = { {55{instruction[20]}}  , instruction[20:12] }; //D
		3'b100: out = { {45{instruction[23]}}  , instruction[23:5] }; //CBZ
		endcase
	end
endmodule
