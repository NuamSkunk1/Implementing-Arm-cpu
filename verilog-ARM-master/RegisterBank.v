module RegisterBank(
	input clock,
	input [4:0] reg1,
	input [4:0] reg2,
	input [4:0] regWrite,
	input [63:0] regWriteData,
	input isWrite,
	output [63:0] reg1Data,
	output [63:0] reg2Data
);
	reg [63:0] storage[0:31];
	initial
	begin
		storage[31] = 32'b0; // XZR
	
		storage[10] = 32'd5; // X10 = 5
	end
	
	assign reg1Data = storage[reg1];
	assign reg2Data = storage[reg2];

	always @(posedge clock)
	begin	
		if(isWrite==1)
			storage[regWrite] = regWriteData;
	end
endmodule
