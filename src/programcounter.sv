module pc #(
    parameter                                   DATA_WIDTH = 32
)(
    input logic     [DATA_WIDTH-1:0]            ImmOp,
    input logic                                 clk,
    input logic                                 PCsrc,
    input logic                                 rst,
    output logic    [DATA_WIDTH-1:0]            pc
);

    logic           [DATA_WIDTH-1:0]            next_PC;

    always_ff @(posedge clk)
        pc <= next_PC;

    always_comb
        if (rst == 1'b1) begin
            next_PC = 'b0;
        end else if (PCsrc == 1'b1) begin
            next_PC = {pc + ImmOp}[DATA_WIDTH-1:0];
        end else begin
            next_PC = {pc + 'b100}[DATA_WIDTH-1:0];
        end

endmodule
