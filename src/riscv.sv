module riscv #(
    parameter BITNESS = 32,
    parameter INSTR_WIDTH = 32,
    parameter REG_ADDR_WIDTH = 5
) (
    input logic rst_i,
    /* verilator lint_off UNUSED */
    // not using int_i for anything just yet
    input logic int_i,
    /* verilator lint_on UNUSED */
    input logic clk_i,
    output logic [7:0] data_out_o
);

logic [BITNESS-1:0] alu_src_a, alu_src_b, regfile_d2;

logic [BITNESS-1:0] pc;

logic [INSTR_WIDTH-1:0] instr;

logic regwrite;

logic alusrc;

logic [2:0] immsrc;

logic [BITNESS-1:0] result;

/* verilator lint_off UNUSED */
// we keep some bits of a0 unused in case we want to use it as a debug output or similar: there is no disadvantage to having it exposed to the main module
logic [BITNESS-1:0] a0;
/* verilator lint_on UNUSED */

logic [BITNESS-1:0] immext;

logic [3:0] alu_ctrl;

logic [BITNESS-1:0] aluresult;

logic alu_eq;

wire [1:0] pcsrc;

logic [1:0] resultsrc;

logic memwrite;

logic [BITNESS-1:0] readdata;

wire  instr_funct7_5  = instr[30];

wire [2:0] instr_funct3  = instr[14:12];

wire [6:0] instr_op = instr[6:0];

wire [BITNESS-1:0] PCplus4;


always_comb begin
    data_out_o = a0[7:0];

    if (alusrc == 1'b1)
        alu_src_b = immext;
    else if (alusrc == 1'b0)
        alu_src_b = regfile_d2;
    //else if (alusrc == 2'b10)
        //alu_src_b = PCplus4;
    else
        alu_src_b = 'b1111111;

    if (resultsrc == 2'b00)
        result = readdata;
    else if (resultsrc == 2'b01)
        result = aluresult;
    else if (resultsrc == 2'b10)
        result = PCplus4; //JAL/JALR return storage
    else if (resultsrc == 2'b11)
        result = immext;
    else
        result = 'b1111111;//Shouldn't happen

end;

/* verilator lint_off PINMISSING */
// need this for unused count pin
programcounter #() programcounter (
    .ImmOp(immext),
    .clk(clk_i),
    .PCsrc(pcsrc),
    .rst(rst_i),
    .pc(pc),
    .pcplus4(PCplus4),
    .ALUresult (aluresult)
);
/* verilator lint_on PINMISSING */


instructionmemory #(BITNESS, INSTR_WIDTH, "instructionmemory.tmp.mem") instructionmemory (
    .addr_i(pc),
    .dout_o(instr)
);

alu #(BITNESS,4) alu (
    .op1(alu_src_a),
    .op2(alu_src_b),
    .ctrl(alu_ctrl),
    .aluout(aluresult),
    .zero(alu_eq)
);

regfile #(BITNESS, REG_ADDR_WIDTH) registerfile(
    .clk(clk_i),
    .we3(regwrite),
    .a1(instr[19:15]),
    .a2(instr[24:20]),
    .a3(instr[11:7]),
    .wd3(result),
    .rd1(alu_src_a),
    .rd2(regfile_d2),
    .a0(a0)
);

memoryunit #() memoryunit(
    .address(aluresult),
    .write_data(regfile_d2),
    .write_enable(memwrite),
    .DATAMEMControl(instr_funct3),
    .clk(clk_i),
    .read_data(readdata)
);

controlUnit #() controlunit(
    .funct3(instr_funct3),
    .funct7_5(instr_funct7_5),
    .zero(alu_eq),
    .op(instr_op),
    .PCSrc(pcsrc),
    .ResultSrc(resultsrc),
    .RegWrite(regwrite),
    .ALUControl(alu_ctrl),
    .ALUSrc(alusrc),
    .ImmSrc(immsrc),
    .MemWrite(memwrite)
);

signextend #() signextend(
    .toextend_i(instr[31:7]),
    .immsrc_i(immsrc),
    .immop_o(immext)
);


endmodule
