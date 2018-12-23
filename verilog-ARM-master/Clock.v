module Clock#(parameter delay=100)(
	output reg clock
);
	always
	begin
		#delay;
		clock = 0;
		#delay;
		clock = 1;
	end
endmodule
