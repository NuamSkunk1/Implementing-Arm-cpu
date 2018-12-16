`timescale 1ns/100ps

module ALU
  #( 
    parameter n = 64,
    parameter delay = 100
  )
  
  (
  input [n-1 : 0] in1,
  input [n-1 : 0] in2,
    input [3:0] operation,
  output zero,
    output reg [n-1 : 0] outputs
  );
  
  assign zero = ALUout ? 0 : 1;
  always @(operation, in1, in2) begin
    output = 64'bz;
    case(operation)
      4'b0000: outputs = in1 & in2;
      4'b0001: outputs = in1 | in2;
      4'b0010: outputs = in1 + in2;
      4'b0110: outputs = in1 - in2;
      4'b0111: outputs = in2;
      4'b1100: outputs = in1 ^ in2;
    endcase
  end
    
  endmodule
