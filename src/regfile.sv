module regfile #(
    parameter DATA_WIDTH = 32,ADR_WIDTH = 5
) (
    input logic clk_i,
    input logic we3_i,
    input logic [ADR_WIDTH-1:0]a1_i, a2_i , a3_i,
    input logic [DATA_WIDTH-1:0]wd3_i,
    output logic [DATA_WIDTH-1:0]rd1_o, rd2_o,
    output logic [DATA_WIDTH-1:0]a0_o
);

    logic [DATA_WIDTH-1:0] ramArray [2**ADR_WIDTH-1:0];
    initial ramArray[0] = 0;

    always_comb 
    begin
        rd1_o = ramArray[a1_i];
        rd2_o = ramArray[a2_i];
        a0_o = ramArray[10];
    end

    always_ff @(posedge clk_i) 
    begin
        if (we3_i && (a3_i != 'b0)) ramArray[a3_i] <= wd3_i;
    end
    
endmodule
