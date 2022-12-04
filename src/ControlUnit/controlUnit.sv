module controlUnit (
//Inputs
    input logic zero,
    input logic [31:0] instr,
//Outputs
    output logic PCSrc, //Select PC:=PC+4 (Sel0) or PC:=PC+ImmOp (Sel1) 
    output logic ResultSrc,
    output logic MemWrite,
    output logic [2:0] ALUControl,
    output logic ALUSrc,
    output logic ImmSrc,
    output logic RegWrite
);
logic BranchWire;
wire [1:0] ALUOpWire;

assign PCSrc = BranchWire & 0; //Why? Won't this always be 0 and hence never branch


mainDecoder mainDecoder(
//Inputs
    .op (instr[6:0]),
//Outputs
    .Branch (BranchWire),
    .ImmSrc (ImmSrc)
    .ALUSrc (ALUSrc),
    .ResultSrc (ResultSrc),
    .RegWrite (RegWrite),
    .MemWrite (MemWrite),
    .ALUOp (ALUOpWire),

);

aluDecoder aluDecoder (
//Inputs
    .funct3 (instr[14:12]),
    .funct7_5 (instr[30]),
    .op5 (instr[5]),
    .ALUOp (ALUOpWire),
//Outputs
    .ALUControl (ALUControl)
);


endmodule

