module programcounter #(
    parameter                                   DATA_WIDTH = 32
)(
    input logic     [DATA_WIDTH-1:0]            ImmOp,
    input logic                                 clk,
    input logic        [1:0]                    PCsrc,
    input logic                                 rst,
    input logic     [DATA_WIDTH-1:0]            ALUresult,
    output logic    [DATA_WIDTH-1:0]            pc,
    output logic    [DATA_WIDTH-1:0]            pcplus4
);

    always_comb pcplus4 = {pc + 4}[DATA_WIDTH-1:0];

    always_ff @(negedge clk)
        begin
        if (rst == 1'b1)            pc <= 'b0; //Reset PC
        else if (PCsrc == 2'b01)    pc <= {pc + ImmOp}[DATA_WIDTH-1:0]; //B-type generic and JAL
        else if (PCsrc == 2'b10)    pc <= ALUresult; //JALR
        else                        pc <= pcplus4; //Increment PC by 4
        end
        
endmodule
