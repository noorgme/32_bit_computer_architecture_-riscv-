module instructionmemory #(
    /* verilator lint_off UNUSED */
    parameter   ADDR_WIDTH = 10,
                DATA_WIDTH = 32,
                SOURCE_FILE = "magic_rom_8x32.mem",
                SPACE_WIDTH = 8
    
    
)(
    input logic [ADDR_WIDTH-1:0] addr_i,
    output logic [DATA_WIDTH-1:0] data_o
    // verilator lint_on UNUSED
);

logic [DATA_WIDTH-1:0] romArray [2**SPACE_WIDTH-1:0];

initial begin
    $display("Loading instruction ROM...");
    $readmemh({"./rtl/generated/",SOURCE_FILE}, romArray);
    $display("Done loading");
end;

always_comb data_o = romArray[{{addr_i}[ADDR_WIDTH - 1:2]}[SPACE_WIDTH - 1:0]];

endmodule
