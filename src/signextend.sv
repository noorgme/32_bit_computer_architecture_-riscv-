module signextend (
    /* verilator lint_off UNUSED */
    input logic     [31:7]      toextend_i,
    /* verilator lint_on UNUSED */
    input logic     [1:0]       immsrc_i,
    output logic    [31:0]      immop_o
);

// see lecture 7 slide 15
always_comb
    case(immsrc_i)
        2'b00: begin
            immop_o = {{20{toextend_i[31]}}, toextend_i[31:20]};
        end
        2'b01: begin
            immop_o = {{20{toextend_i[31]}}, toextend_i[31:25], toextend_i[11:7]};
        end
        2'b10: begin
            immop_o = {{20{toextend_i[31]}}, toextend_i[7], toextend_i[30:25], toextend_i[11:8], 1'b0};
            //immop_o = {{20{toextend_i[31]}}, toextend_i[7], toextend_i[30:25], 4'b1, 1'b0};
        end
        default begin
            // shouldn't happen
            immop_o = 32'hDEADBEEF;
        end
    endcase
endmodule
