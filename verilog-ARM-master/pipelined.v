`timescale 1ns/100ps

module ARM_CPU_pipelined();

  wire clk; 
  wire [63 : 0] newPC, oldPC;
  wire [31: 0]Instruction;
  wire [95 : 0] IFID;
  wire [1 : 0] ALUOp;
  wire ALUSrc, Branch, MemRead, MemWrite;
  wire RegWrite, MemtoReg;
  wire [4 : 0] ReadRegister_2;
  wire [63 : 0] ReadData_1, ReadData_2, WriteData;
  wire [63 : 0] SignExtendOut;
  wire [279 : 0] IDEX;
  wire [3 : 0] ALUopt;
  wire [63 : 0] muxALUOut;
  wire isZero;
  wire [63 : 0] ALUresult;
  wire [63 : 0] newPC0, newPC1;
  wire [202 : 0] EXMEM;
  wire andBranch;
  wire [63 : 0] ReadData;
  wire [134 : 0] MEMWB;
  wire [63 : 0] muxWBOut;

  Clock myClock(.clk);
  
  ALU ALUPC(.in1(oldPC), .in2({61'd0, 3'b100}),
   .opt(4'b0010), .zero(), .ALUresult(newPC0));
   
  MUX2to1 muxPC(.in1(newPC0), .in2(EXMEM[68 : 5]),
   .selector(andBranch), .muxOut(newPC)); 
  
  Registre PC(.D(newPC), .clk, .reset(1'b0), .Q(oldPC));
  
  InstructionMemory instMemory( .ReadAddress(oldPC), .Instruction);
  
  Registre #(.n(96)) IF_ID
    (.D({oldPC  // IFID[95 : 32]
    , Instruction}),  // IFID[31 : 0]
     .clk, .reset(1'b0), .Q(IFID));
    
  ControlUnit control(.opCode(IFID[31:21]), 
    .ALUOp, .ALUSrc, .Branch, .MemRead, .MemWrite,
    .RegWrite, .MemtoReg);  
    
  MUX2to1 #(.n(5)) muxRF(.in1(IFID[20:16]), 
  .in2(IFID[4:0]), .selector(IFID[28]),
  .muxOut(ReadRegister_2));
  
  RegisterFile Registers( .ReadRegister_1(IFID[9 : 5]),
   .ReadRegister_2, .WriteRegister(MEMWB[134:130]),
   .WriteData(muxWBOut), .clk, .RegWrite(MEMWB[1]),
   .ReadData_1, .ReadData_2);
  
  SignExtend mySignExtend(.Instruction(IFID[31:0]),
   .out(SignExtendOut));
  
  Registre #(.n(280)) ID_EX
    (.D({
     IFID[4 : 0], // Rt = IDEX[279 : 275]
     IFID[31 : 21], // opcode = IDEX[274 : 264] 
     SignExtendOut, // IDEX[263 : 200]
     ReadData_2, // IDEX[199 : 136]
     ReadData_1, // IDEX[135 : 72]
     IFID[95 : 32], // oldPC = IDEX[71 : 8]
     ALUOp, ALUSrc, // EX = IDEX[7 : 5]
     Branch, MemRead, MemWrite, // M = IDEX[4 : 2]
     RegWrite, MemtoReg // WB = IDEX[1 : 0]
     }), 
    .clk, .reset(1'b0), .Q(IFID));
    
  ALUcontrol myALUcontrol(.ALUOp(IDEX[7 : 6]),
   .opcode(IDEX[274 : 264]), .opt(ALUopt));

  MUX2to1 muxALU(.in1(IDEX[199 : 136]), .in2(IDEX[263 : 200]),
   .selector(IDEX[5]), .muxOut(muxALUOut));
 
  ALU myALU(.in1(IDEX[135 : 72]), .in2(muxALUOut),
   .opt(ALUopt), .zero(isZero), .ALUresult);

  ALU ALUCond(.in1(IDEX[71 : 8]), .in2({SignExtendOut[61 : 0], 2'b00}),
   .opt(4'b0010), .zero(), .ALUresult(newPC1));
   
  Registre  #(.n(203)) EX_MEM(.D({
    IDEX[279 : 275], // Rt = EXMEM[202 : 198]
    IDEX[199 : 136], // ReadData_2 = EXMEM[197 : 134]
    ALUresult, // EXMEM[133 : 70]
    isZero, // EXMEM[69]
    newPC1, // EXMEM[68 : 5]
    Branch, MemRead, MemWrite, // M = EXMEM[4 : 2]
    RegWrite, MemtoReg // WB = EXMEM[1 : 0]
    }), 
    .clk, .reset(1'b0), .Q(EXMEM));
    
  and(andBranch, EXMEM[4], EXMEM[69]);
  
  DataMemory myDataMemory(.clk, .WriteData(EXMEM[197 : 134]),
     .Address(EXMEM[133 : 70]), .MemRead(EXMEM[3]),
     .MemWrite(EXMEM[2]), .ReadData);
     
  Registre  #(.n(135)) MEM_WB(.D({
    EXMEM[202 : 198], // Rt = MEMWB[134 : 130]
    EXMEM[133 : 70], // ALUresult = MEMWB[129 : 66]    
    ReadData, // MEMWB[65 : 2]
    RegWrite, MemtoReg // WB = MEMWB[1 : 0]
    }), 
    .clk, .reset(1'b0), .Q(MEMWB));
    
  MUX2to1 muxWB(.in1(MEMWB[65 : 2]), .in2(MEMWB[129 : 66]),
   .selector(MEMWB[0]), .muxOut(muxWBOut));
  
endmodule
