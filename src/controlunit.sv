module controlunit (
    input logic                 eq,
    // verilator lint_off UNUSED
    input logic     [31:0]      instr,
    // verilator lint_on UNUSED
    output logic                PCsrc,
    output logic                ImmSrc,
    output logic                ALUsrc,
    output logic                ALUctrl,
    output logic                RegWrite
); 

logic [6:0] opcode;
assign opcode = instr[6:0];
logic [2:0] funct3;
assign funct3 = instr[14:12];

always_comb begin

    // PCsrc controls whether the program counter takes the value from pc+4 (0) or 
    // the value of pc+ImmOp (1). Should be high if branching instruction and we should branch
    // Currently only implemented for bne, beq
    if (opcode == 99) begin
        // Is a branch instruction
        
        if (funct3 == 'b000) begin
            // beq, is rs1 equal to rs2? if so, input eq == 1
            if (eq == 1) PCsrc = 1;
            else PCsrc = 0;
        end else if (funct3 == 'b001) begin
            // bne, is rs1 not equal to rs2? if so, input eq == 0
            if (eq == 0) PCsrc = 1;
            else PCsrc = 0;
        end else begin
            // unimplemented instruction
            PCsrc = 0;
        end
    end else begin 
        PCsrc = 0;
    end

    // ImmSrc does nothing as of Lab4
    ImmSrc = 0;

    // ALUsrc selects whether RD2 is fed into the ALU (0) or sign extended immediate is fed into the ALU (1)
    // Therefore it should be high for instructions with ALU operations involving imm and low for 
    // instructions involving rs2
    // op should be 51, 99
    if (opcode inside {7'D51, 7'D99}) ALUsrc = 1;
    else ALUsrc = 0;

    // ALUctrl selects whether the 2nd operand of the ALU is RD2 (0) or ImmOp (1).
    // It should therefore be 0 when working with RD2 alu instructions or 1 otherwise

    // Uses imm not rd2?
    if (opcode inside {3, 19, 35, 23, 55, 103}) ALUctrl = 1;
    else ALUctrl = 0;



    // RegWrite controls whether ALUOut is written to the regfile.
    // Should only be high for instructions which have register output destination
    // This is the case if instruction is arithmetic, logic, load or jump and link
    // op will therefore be 3, 19, 51, 23, 55
    if (opcode inside {3, 19, 51, 23, 51}) RegWrite = 1;
    else RegWrite = 0;

end 
endmodule
