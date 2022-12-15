module signextend (
    /* verilator lint_off UNUSED */
    input logic     [31:7]      toextend_i,
    /* verilator lint_on UNUSED */
    input logic     [2:0]       immsrc_i,
    output logic    [31:0]      immop_o
);

// see lecture 7 slide 15
always_comb
    case(immsrc_i)
        3'b000: begin
            immop_o = {{20{toextend_i[31]}}, toextend_i[31:20]}; //I-type op form
        end
        3'b001: begin
            immop_o = {{20{toextend_i[31]}}, toextend_i[31:25], toextend_i[11:7]}; //S-type Imm form
        end
        3'b010: begin
            immop_o = {{20{toextend_i[31]}}, toextend_i[7], toextend_i[30:25], toextend_i[11:8], 1'b0}; //B-type Imm form
            //immop_o = {{20{toextend_i[31]}}, toextend_i[7], toextend_i[30:25], 4'b1, 1'b0};
        end
        3'b011: immop_o = {{12{toextend_i[31]}}, toextend_i[19:12], toextend_i[20], toextend_i[30:21], 1'b0}; //JAL Imm Form (20-bit imm)
        3'b100: immop_o = {toextend_i[31:12],12'b0}; //lui
        default begin
            // shouldn't happen
            immop_o = 32'hDEADBEEF; //lol
        end
    endcase
endmodule
