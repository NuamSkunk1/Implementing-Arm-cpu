`timescale 1ns/1ns

module Register
  #( 
  parameter n = 64
  )
  (
  input [n-1 : 0] D,
  input clk,
  input reset,
  output reg [n-1 : 0] Q
  );
  
  always @(posedge clk)begin
    if (reset)
      Q <= {n{1'b0}};
    else
      Q <= D;   
    end 
    
endmodule 