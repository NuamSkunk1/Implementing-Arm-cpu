module Control(
	input [10:0] operation,
	output reg [8:0] out
);

	always @(operation)
	begin
		case (operation)
			6'b000000: out = 9'b100100010; // R-format
			6'b100011: out = 9'b011110000; // lw
			6'b101011: out = 9'b010001000; // sw
			6'b000100: out = 9'b000000101; // beq
			default: out = 9'b0;
		endcase
	end //compelete

endmodule
