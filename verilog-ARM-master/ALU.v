
module ALU
  #( 
    parameter n = 64,
    parameter delay = 100
  )
  
  (
  input [n-1 : 0] in1,
  input [n-1 : 0] in2,
  input [3:0] opt,
  output zero,
  output reg [n-1 : 0] ALUout
  );
  
  assign zero = ALUout ? 0 : 1;
  always @(opt, in1, in2) begin
    ALUout = 64'bz;
    case(opt)
      4'b0000: ALUout = in1 & in2;
      4'b0001: ALUout = in1 | in2;
      4'b0010: ALUout = in1 + in2;
      4'b0110: ALUout = in1 - in2;
      4'b0111: ALUout = in2;
      4'b1100: ALUout = in1 ^ in2;
    endcase
  end
    
  endmodule
