module controlUnit (
//Inputs
    input logic zero,
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7_5,
//Outputs
    output logic [1:0] PCSrc, //Select PC:=PC+4 (Sel0) or PC:=PC+ImmOp (Sel1) or PC:=ImmOp (Sel2)
    output logic ResultSrc,
    output logic MemWrite,
    output logic [3:0] ALUControl,
    output logic [1:0] ALUSrc,
    output logic [1:0] ImmSrc,
    output logic RegWrite,
    output logic RegSrc,
    output logic [2:0] DATAMEMControl
);
wire [1:0] BranchWire;
wire [1:0] ALUOpWire;

always_comb
    begin
    if ((BranchWire==2'b01) && (zero==1'b1))
        assign PCSrc = 2'b01;
    else if (BranchWire == 2'b10)
        assign PCSrc = 2'b10;
    else
        assign PCSrc = 2'b00;
    end


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
