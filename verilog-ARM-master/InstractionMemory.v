module InstractionMemory(
	input [10:0] address,
	output [31:0] instraction
);
	
	reg [63:0] storage[0:127];
	initial
	begin
		storage[0] = 32'b10001101010000000000000000000000; // lw X0, [X10,0x00]
		storage[1] = 32'b10001101010000010000000000000001; // lw X1, [X10,0x01]
		storage[2] = 32'b00000000000000010001000000100000; // add X2, X0, X1

//32'b100011  01010 01000 0000 0000 0110 0000 lw
//32'b000000 10001 10010 01000 00000 100000 add


	end
	
	assign instraction = storage[address];

endmodule
