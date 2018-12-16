module MUX2to1
  #( 
  parameter n = 64
  )
  
  (
  input [n-1 : 0] in1,
  input [n-1 : 0] in2,
  input selector,
  output [n-1 : 0] muxOut
  );
  
  assign muxOut = selector ? in2 : in1; 
  
endmodule