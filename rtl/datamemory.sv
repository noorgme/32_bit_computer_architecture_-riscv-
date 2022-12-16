module datamemory #(
    parameter   DATA_WIDTH = 32, 
                ADDRESS_WIDTH = 30,
                MEMORY_SIZE = 16,
                SOURCE_FILE = "datamemory.mem"

)(
    input logic     [ADDRESS_WIDTH-1:0] address_i,
    input logic     [DATA_WIDTH-1:0]    writeData_i,
    input logic                         writeEnable_i,
    input logic                         clk_i,
    output logic    [DATA_WIDTH-1:0]    readData_o
);

    logic [DATA_WIDTH-1:0] dataMem [2 ** MEMORY_SIZE-1:0];

    always_comb readData_o = dataMem[{address_i}[MEMORY_SIZE-1:0]];

    initial 
    begin
        $display("Loading Data Memory...");
        $readmemh({"./rtl/generated/",SOURCE_FILE}, dataMem);
        $display("Done loading");
    end;

    always_ff @(posedge clk_i)
        begin
            if (writeEnable_i == 1'b1) 
                dataMem[{address_i}[MEMORY_SIZE-1:0]] <= writeData_i;
        end

endmodule
