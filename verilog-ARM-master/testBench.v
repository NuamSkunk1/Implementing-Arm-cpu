`timescale 1ns/1ns

module testBench;
   parameter n = 64;
   reg [n-1:0] dataIn = 0;
   wire [n-1:0] newPC = 0;
   wire [n-1:0] oldPC = 0;
   wire myClk = 1;
   integer i;
   reg pos = 1'b1;
   reg neg = 1'b0;
   reg [n-1:0] add4 = 4;
   
   
   Adder #(.n(n)) myAdder(.x(oldPC), .y(add4), .cin(neg), .z(newPC), .cout());
  
   Register #( .n(n)) PC(.D(newPC), .clk(myClk), .reset(neg), .Q(oldPC));
   
   Clock myClock(.clk(myClk));
   
   Memory #(.size(1024), .log2Size(10), .n(n)) 
   myMem(.clk(myClk), .DataIn(dataIn), .Address(newPC),
         .memRead(pos), .memWr(pos), .DataOut());
    
  initial
    for(i=0; i<32; i=i+1) begin
       dataIn = i; 
       #100;
    end
    
    
  always @(dataIn) begin   
    $display("dataIn = %0d,  dataOut = %0d, newPC = %0d \n", myMem.DataIn, myMem.DataOut, PC.D);
  end
  
endmodule