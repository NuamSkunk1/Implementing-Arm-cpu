`timescale 1ns/1ns

module TB_Adder;
  reg [7:0] x;
  reg [7:0] y;
  reg cin;
  wire [7:0] s;  //must not initialized
  integer i;
  
  initial 
    for(i = 0; i < 20; i = i+1) begin
      x = $random;
      y = $random;
      cin = $random;
      #100; 
    end
  
  always @(s) begin
    #5;
    $display("%0d + %0d + %0d = %0d,   %0d \n", x, y, cin, uut.z, uut.cout);
  end
  
  Adder #(.n(8)) uut
  (.x(x),
  .y(y),
  .z(s),
  .cin(cin),
  .cout()
  );
  
endmodule
  
  
  
  
  
 