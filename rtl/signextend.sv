module signextend (
    /* verilator lint_off UNUSED */
    input logic     [31:7]      toExtend_i,
    /* verilator lint_on UNUSED */
    input logic     [2:0]       immSrc_i,
    output logic    [31:0]      immOp_o
);

// see lecture 7 slide 15
always_comb
    case(immSrc_i)
        3'b000: begin
            immOp_o = {{20{toExtend_i[31]}}, toExtend_i[31:20]}; //I-type op form
        end
        3'b001: begin
            immOp_o = {{20{toExtend_i[31]}}, toExtend_i[31:25], toExtend_i[11:7]}; //S-type Imm form
        end
        3'b010: begin
            immOp_o = {{20{toExtend_i[31]}}, toExtend_i[7], toExtend_i[30:25], toExtend_i[11:8], 1'b0}; //B-type Imm form
            //immOp_o = {{20{toExtend_i[31]}}, toExtend_i[7], toExtend_i[30:25], 4'b1, 1'b0};
        end
        3'b011: immOp_o = {{12{toExtend_i[31]}}, toExtend_i[19:12], toExtend_i[20], toExtend_i[30:21], 1'b0}; //JAL Imm Form (20-bit imm)
        3'b100: immOp_o = {toExtend_i[31:12],12'b0}; //lui
        default 
        begin
            // shouldn't happen
            immOp_o = 32'hDEADBEEF; //lol
        end
    endcase
endmodule
