

module instructionmemory #(
    /* verilator lint_off UNUSED */
    parameter   ADDR_WIDTH = 10,
                DATA_WIDTH = 32,
                SOURCE_FILE = "JALtest.mem",
                SPACE_WIDTH = 8
    
    
)(
    input logic clk_i,
    input logic [ADDR_WIDTH-1:0] addr_i,
    output logic [DATA_WIDTH-1:0] dout_o
    // verilator lint_on UNUSED
);

logic [DATA_WIDTH-1:0] rom_array [2**SPACE_WIDTH-1:0];

initial begin
    $display("Loading instruction ROM...");
    $readmemh({"/home/noorgme/Documents/iac/riscv2/src/generated/",SOURCE_FILE}, rom_array);
    $display("Done loading");
end;

always_ff @(posedge clk_i)
    dout_o <= rom_array[{{addr_i}[ADDR_WIDTH-1:2]}[SPACE_WIDTH-1:0]];

endmodule
