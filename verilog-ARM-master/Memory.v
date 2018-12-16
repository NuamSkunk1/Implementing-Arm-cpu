`timescale 1ns/100ps

module Memory
  #( parameter size = 1024,
     parameter log2Size = 10, 
     parameter n = 64
     )
     
  ( 
  input clk,
  input [n-1 : 0] DataIn,
  input [n-1 : 0] Address,
  input memRead,
  input memWrite,
  output [n-1 : 0] DataOut
  );
  
  reg [n-1 : 0] Memory [0 : size-1];
  assign DataOut = memRead ? Memory[Address] : {n{1'bz}}; 
  
  always @(posedge clk) begin
    if(memWrite)
      Memory[Address[log2Size-1 : 0]] <= DataIn;  
  end

endmodule     
