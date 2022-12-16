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
    output logic [7:0] dataOut_o
);

logic [BITNESS-1:0] aluSrcA, aluSrcB, regFileD2;

logic [BITNESS-1:0] pc;

logic [INSTR_WIDTH-1:0] instr;

logic regWrite;

logic aluSrc;

logic [2:0] immSrc;

logic [BITNESS-1:0] result;

/* verilator lint_off UNUSED */
// we keep some bits of a0 unused in case we want to use it as a debug output or similar: there is no disadvantage to having it exposed to the main module
logic [BITNESS-1:0] a0;
/* verilator lint_on UNUSED */

logic [BITNESS-1:0] immExt;

logic [3:0] aluCtrl;

logic [BITNESS-1:0] aluResult;

logic aluEq;

wire [1:0] pcSrc;

logic [1:0] resultSrc;

logic memWrite;

logic [BITNESS-1:0] readData;

wire  instrFunct7_5  = instr[30];

wire [2:0] instrFunct3  = instr[14:12];

wire [6:0] instrOp = instr[6:0];

wire [BITNESS-1:0] pcPlus4;


always_comb 
begin
    dataOut_o = a0[7:0];

    if (aluSrc == 1'b1)
        aluSrcB = immExt;
    else if (aluSrc == 1'b0)
        aluSrcB = regFileD2;
    //else if (alusrc == 2'b10)
        //alu_src_b = PCplus4;
    else
        aluSrcB = 'b1111111;

    if (resultSrc == 2'b00)
        result = readData;
    else if (resultSrc == 2'b01)
        result = aluResult;
    else if (resultSrc == 2'b10)
        result = pcPlus4; //JAL/JALR return storage
    else if (resultSrc == 2'b11)
        result = immExt;
    else
        result = 'b1111111; //Shouldn't happen
end;

/* verilator lint_off PINMISSING */
// need this for unused count pin

programcounter #() programcounter (
    .immOp_i(immExt),
    .clk_i(clk_i),
    .pcSrc_i(pcSrc),
    .rst_i(rst_i),
    .pc_o(pc),
    .pcPlus4_o(pcPlus4),
    .aluResult_i (aluResult)
);
/* verilator lint_on PINMISSING */


instructionmemory #(BITNESS, INSTR_WIDTH, "instructionmemory.tmp.mem") instructionmemory (
    .addr_i(pc),
    .data_o(instr)
);

alu #(BITNESS,4) alu (
    .op1_i(aluSrcA),
    .op2_i(aluSrcB),
    .ctrl_i(aluCtrl),
    .alu_o(aluResult),
    .zero_o(aluEq)
);

regfile #(BITNESS, REG_ADDR_WIDTH) registerfile(
    .clk_i(clk_i),
    .we3_i(regWrite),
    .a1_i(instr[19:15]),
    .a2_i(instr[24:20]),
    .a3_i(instr[11:7]),
    .wd3_i(result),
    .rd1_o(aluSrcA),
    .rd2_o(regFileD2),
    .a0_o(a0)
);

memoryunit #() memoryunit(
    .address_i(aluResult),
    .writeData_i(regFileD2),
    .writeEnable_i(memWrite),
    .dataMemControl_i(instrFunct3),
    .clk_i(clk_i),
    .readData_o(readData)
);

controlUnit #() controlunit(
    .funct3_i(instrFunct3),
    .funct7_5_i(instrFunct7_5),
    .zero_i(aluEq),
    .op_i(instrOp),
    .pcSrc_o(pcSrc),
    .resultSrc_o(resultSrc),
    .regWrite_o(regWrite),
    .aluControl_o(aluCtrl),
    .aluSrc_o(aluSrc),
    .immSrc_o(immSrc),
    .memWrite_o(memWrite)
);

signextend #() signextend(
    .toExtend_i(instr[31:7]),
    .immSrc_i(immSrc),
    .immOp_o(immExt)
);

final 
begin
    $display("Writing register dump...");
    $writememh("./rtl/generated/registerdump.tmp.mem", registerfile.ramArray);
    $display("Done writing register dump");
end;


endmodule
