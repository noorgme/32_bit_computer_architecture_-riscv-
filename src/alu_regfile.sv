module alu_regfile #(
    parameter DATA_WIDTH = 32, ADR_WIDTH =5, ALU_CTRL =3
) (
    input logic clk,
    input logic [ADR_WIDTH-1:0]r[3],
    input logic alusrc,
    input logic [ALU_CTRL-1:0]aluctrl,
    input logic [DATA_WIDTH-1:0]immop,
    input logic regwrite,
    output logic eq,
    output logic [DATA_WIDTH-1:0]a0
);

logic [DATA_WIDTH-1:0]regop[2];
logic [DATA_WIDTH-1:0]aluop2;
logic [DATA_WIDTH-1:0]aluout;

always_comb begin
    if(alusrc) aluop2 = immop;
    else aluop2 = regop[1];
end

alu #(DATA_WIDTH,ALU_CTRL) alu_1 (
    .op({regop[0],aluop2}),
    .ctrl(aluctrl),
    .aluout(aluout),
    .eq(eq)
);

regfile #(DATA_WIDTH,ADR_WIDTH) regfile_1 (
    .clk(clk),
    .we3(regwrite),
    .a(r),
    .wd3(aluout),
    .rd(regop),
    .a0(a0)
);
    
endmodule
