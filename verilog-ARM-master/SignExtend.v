

module SignExtend
  (input [31 : 0] instruction,
  output reg [63 : 0] out
  );
  
  wire opcodeID = instruction[31:30];
  reg sign;
  
  always @(instruction) begin 
    out = 64'bz;
    case (opcodeID)
      2'b00: begin   //unconditional
        sign = instruction[25];
        out = {{38{sign}}, instruction[25:0]};
      end 
    endcase
  end
  
endmodule
  
  
