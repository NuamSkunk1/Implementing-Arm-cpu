`timescale 1ns/100ps

module SignExtend
  (input [31 : 0] instruction,
  output reg [63 : 0] out
  );
  
  wire opcodeID = instruction[31:30];
  reg sigN;
  
  always @(instruction) begin 
    out = 64'bz;
    case (opcodeID)
      2'b00: begin   //unconditional
        sigN = instruction[25];
        out = {{38{sign}}, instruction[25:0]};
      end
      
      2'b10: begin    //conditional 
        sign = instruction[23];
        out = {{45{sign}}, instruction[23:5]};
      end
      
      2'b11: begin   // LDUR, STUR
        sign = instruction[20];
        out = {{55{sign}}, instruction[20:12]};
      end 
    endcase
  end
  
endmodule
  
  
