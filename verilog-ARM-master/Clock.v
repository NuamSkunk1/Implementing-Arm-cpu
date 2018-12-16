`timescale 1ns/1ns

module Clock
  #(parameter delay = 100)
  (
  output reg clk = 1
  );
  
  always #delay clk = ~clk;
  
endmodule
