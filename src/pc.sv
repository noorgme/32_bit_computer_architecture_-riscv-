module pc #(
    parameter                                   DATA_WIDTH = 32
)(
    input logic     [DATA_WIDTH-1:0]            ImmOp,
    input logic                                 clk,
    input logic                                 PCsrc,
    input logic                                 rst,
    output logic    [DATA_WIDTH-1:0]            pcounter
);

    logic           [DATA_WIDTH-1:0]            next_PC;

    always_ff @(posedge clk)
        pcounter <= next_PC;

    always_comb
        if (rst == 1'b1) begin
            next_PC = 'b0;
        end else if (PCsrc == 1'b1) begin
            next_PC = {pcounter + ImmOp}[DATA_WIDTH-1:0];
        end else begin
            next_PC = {pcounter + 'b100}[DATA_WIDTH-1:0];
        end

endmodule
