`timescale 1ns/100ps

module Adder
  #(parameter n = 64,
  parameter delay = 50)
(
  input [n-1:0] x,
  input [n-1:0] y,
  input cin,
  output [n-1:0] z,
  output cout);
  
  assign {cout, z} = x + y + cin;
  
endmodule
