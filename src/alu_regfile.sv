module alu_regfile #(
    parameter DATA_WIDTH = 32, ADR_WIDTH =5, ALU_CTRL =3
) (
    input logic [ADR_WIDTH-1:0]r1,r2,r3,
    input logic [ALU_CTRL-1:0]aluctrl,
    input logic [DATA_WIDTH-1:0]immop,
    output logic [DATA_WIDTH-1:0]a0,aluout,
    input logic clk,
    input logic alusrc,
    input logic regwrite,
    output logic zero
);

logic [DATA_WIDTH-1:0]regop1,regop2;
logic [DATA_WIDTH-1:0]aluop2;
// logic [DATA_WIDTH-1:0]aluout;

always_comb begin
    if(alusrc) aluop2 = immop;
    else aluop2 = regop2;
end

alu #(DATA_WIDTH,ALU_CTRL) alu_1 (
    .op1(regop1),
    .op2(aluop2),
    .ctrl(aluctrl),
    .aluout(aluout),
    .zero(zero)
);

regfile #(DATA_WIDTH,ADR_WIDTH) regfile_1 (
    .clk(clk),
    .we3(regwrite),
    .a1(r1),
    .a2(r2),
    .a3(r3),
    .wd3(aluout),
    .rd1(regop1),
    .rd2(regop2),
    .a0(a0)
);
    
endmodule
