module regfile #(
    parameter DATA_WIDTH = 32,ADR_WIDTH = 5
) (
    input logic clk,
    input logic we3,
    input logic [ADR_WIDTH-1:0]a[3],
    input logic [DATA_WIDTH-1:0]wd3,
    output logic [DATA_WIDTH-1:0]rd[2],
    output logic [DATA_WIDTH-1:0]a0
);

    logic [DATA_WIDTH-1:0] ram_array [2**ADR_WIDTH-1:0];
    initial ram_array[0] = 0;

    always_comb begin
        rd[0] = ram_array[a[0]];
        rd[1] = ram_array[a[1]];
        a0 = ram_array[10];
    end

    always_ff @(posedge clk) begin
        if (we3) ram_array[a[2]] <= wd3;
    end
    
endmodule
