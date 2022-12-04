module pc #(
    parameter                                   DATA_WIDTH = 32
)(
    input logic     [DATA_WIDTH-1:0]            ImmOp,
    input logic                                 clk,
    input logic                                 PCsrc,
    input logic                                 rst,
    output logic    [DATA_WIDTH-1:0]            pc,
    output logic    [DATA_WIDTH-1:0]            count
);

    logic           [DATA_WIDTH-1:0]            next_PC;

    always_ff @(posedge clk)
        begin
            pc <= next_PC;
            count <= count + 1'b1;
        end

    always_comb
        if (rst == 1'b1)            next_PC = DATA_WIDTH'b0;
        else if (PCsrc == 1'b1)     next_PC = {pc + ImmOp}[DATA_WIDTH-1:0];
        else                        next_PC = {pc + DATA_WIDTH'b100}[DATA_WIDTH-1:0];
endmodule
