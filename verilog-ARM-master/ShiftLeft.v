module ShiftLeft#(parameter length=32,parameter shift=2)(
	input [length-1:0] in,
	input [length-1:0] out
);
	assign out = in << shift;
endmodule 