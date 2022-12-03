"""This is the top level circuti
and is not yet complete"""

module RISCV #(
    parameter dataWidth = 32
)(
//Inputs
    input logic     clk,
    input logic     rst,

//Outputs
    output logic [dataWidth-1:0] a0

    
);

logic [dataWidth-1:0] instr;

//PC UNIT
pcTop PC (
//Inputs
    .clk (clk),
    .rst (rst),
    .PCsrc (PCsrc), //From Control
    .ImmOp (ImmOp), //From SignExtend
    
//Outputs
    .pc (A), //To Instr Mem*
);

//ALU AND REGISTER UNIT
//Deriving rs1, rs2 and rd from Instruction Word:
always_comb begin
    rs1 = instr[19:15];
    rs2 = instr[24:20];
    rd = instr[11:7];
end

alu_regfile #(dataWidth, 5, 3) ALU_REG(
//Inputs
    .clk (clk),
    .r ({rs1, rs2, rd}), //Register Addressing, may be error here in syntax?
    .alusrc (ALUsrc), //From Control
    .aluctrl (ALUctrl), //From Control
    .immop (ImmOp), //From SignExtend*
    .regwrite (RegWrite) //From Control
//Outputs
    .eq (EQ), //To Control*
    .a0 (a0)
);

//INSTRUCTION MEMORY UNIT (Model - Doesn't yet exist)
instrMem instrMem(
//Inputs
    .A (pc) //From PC
//Outputs
    .RD (instr) //To SignEx, Control, Register
);

//CONTROL UNIT
controlunit controlUnit(
//Inputs
    .EQ (eq) //From ALU
    .instr (instr)
//Output
    .RegWrite(regwrite), //To Register
    .ALUctrl(ALUctrl), //To ALU
    .ALUsrc(ALUsrc), //To ALU 
    .ImmSrc(ImmSrc), //To SignEx*
    .PCsrc(PCsrc) //To PC

);

//Not yet built
sextend signExtend(
    //
);


""" * means name not yet set as Instruction
memory not yet complete""" 



endmodule
