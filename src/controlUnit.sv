module controlUnit (
//Inputs
    input logic zero,
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7_5,
//Outputs
    output logic PCSrc, //Select PC:=PC+4 (Sel0) or PC:=PC+ImmOp (Sel1) 
    output logic ResultSrc,
    output logic MemWrite,
    output logic [2:0] ALUControl,
    output logic ALUSrc,
    output logic [1:0] ImmSrc,
    output logic RegWrite,
    output logic RegSrc,
    output logic [2:0] DATAMEMControl
);
wire BranchWire;
wire [1:0] ALUOpWire;

assign PCSrc = BranchWire & zero;


mainDecoder mainDecoder(
//Inputs
    .op (op),
//Outputs
    .Branch (BranchWire),
    .ImmSrc (ImmSrc),
    .ALUSrc (ALUSrc),
    .ResultSrc (ResultSrc),
    .RegWrite (RegWrite),
    .RegSrc (RegSrc),
    .MemWrite (MemWrite),
    .ALUOp (ALUOpWire)

);

aluDecoder aluDecoder (
//Inputs
    .funct3 (funct3),
    .funct7_5 (funct7_5),
    .op5 (op[5]),
    .ALUOp (ALUOpWire),
//Outputs
    .ALUControl (ALUControl),
    .DATAMEMControl (DATAMEMControl)
);


endmodule
