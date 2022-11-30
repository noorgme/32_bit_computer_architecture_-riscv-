module signextend (
    input logic     [11:0]      imm,
    output logic    [31:0]      immop
);

always_comb
    immop = {{20{imm[11]}}, imm};

endmodule
