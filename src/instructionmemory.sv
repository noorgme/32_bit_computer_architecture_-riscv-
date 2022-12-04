module instructionmemory #(
    parameter   ADDR_WIDTH = 8,
                DATA_WIDTH = 32
    
)(
    input logic clk_i,
    input logic [ADDR_WIDTH-1:0] addr_i,
    output logic [DATA_WIDTH-1:0] dout_o
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDR_WIDTH-1:0];

initial begin
    $display("Loading instruction ROM...");
    $readmemh("./src/generated/magic_rom_8x32.mem", rom_array);
end;

always_ff @(posedge clk_i)
    dout_o <= rom_array [addr_i];

endmodule
