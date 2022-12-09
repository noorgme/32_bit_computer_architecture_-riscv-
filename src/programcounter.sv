module programcounter #(
    parameter                                   DATA_WIDTH = 32
)(
    input logic     [DATA_WIDTH-1:0]            ImmOp,
    input logic                                 clk,
    input logic     [1:0]                       PCsrc,
    input logic                                 rst,
    output logic    [DATA_WIDTH-1:0]            pc,
    output logic    [DATA_WIDTH-1:0]            count,
    output logic    [DATA_WIDTH-1:0]            pcplus4
);

logic    [DATA_WIDTH-1:0]            next_PC;

    always_ff @(posedge clk)
        begin
            pc <= next_PC;
            count <= count + 1'b1;
            pcplus4 <= {pc + 'b100}[DATA_WIDTH-1:0];
        end

    always_comb
        begin
        
        if (rst == 1'b1)            next_PC = 'b0; //Reset PC
        else if (PCsrc == 2'b01)    next_PC = {pc + ImmOp}[DATA_WIDTH-1:0]; //B-type generic
        else if (PCsrc == 2'b10)    next_PC = ImmOp[DATA_WIDTH-1:0]; //JAL
        else                        next_PC = pcplus4; //Increment PC by 4
        end
        
endmodule
