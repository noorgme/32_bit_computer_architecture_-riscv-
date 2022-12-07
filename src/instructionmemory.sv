

module instructionmemory #(
    /* verilator lint_off UNUSED */
    parameter   ADDR_WIDTH = 8,
                DATA_WIDTH = 32
    
    
)(
    input logic clk_i,
    input logic [ADDR_WIDTH-1:0] addr_i,
    output logic [DATA_WIDTH-1:0] dout_o
    // verilator lint_on UNUSED
);

logic [DATA_WIDTH-1:0] rom_array [2**10-1:0];

initial begin
    $display("Loading instruction ROM...");
    $readmemh("./src/generated/instructionmemory.tmp.mem", rom_array);
    $display("Done loading");
end;

always_ff @(posedge clk_i)
    dout_o <= rom_array[{{addr_i}[ADDR_WIDTH-1:2]}[9:0]];

endmodule
