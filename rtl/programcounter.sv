module programcounter #(
    parameter                                   DATA_WIDTH = 32
)(
    input logic     [DATA_WIDTH-1:0]            immOp_i,
    input logic                                 clk_i,
    input logic        [1:0]                    pcSrc_i,
    input logic                                 rst_i,
    input logic     [DATA_WIDTH-1:0]            aluResult_i,
    output logic    [DATA_WIDTH-1:0]            pc_o,
    output logic    [DATA_WIDTH-1:0]            pcPlus4_o
);

    always_comb pcPlus4_o = {pc_o + 4}[DATA_WIDTH-1:0];

    always_ff @(negedge clk_i)
    begin
        if (rst_i == 1'b1)              pc_o <= 'b0; //Reset PC
        else if (pcSrc_i == 2'b01)      pc_o <= {pc_o + immOp_i}[DATA_WIDTH-1:0]; //B-type generic and JAL
        else if (pcSrc_i == 2'b10)      pc_o <= aluResult_i; //JALR
        else                            pc_o <= pcPlus4_o; //Increment PC by 4
    end
        
endmodule
