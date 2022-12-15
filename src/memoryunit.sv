module memoryunit #(
    parameter   DATA_WIDTH = 32, 
                ADDRESS_WIDTH = 32, 
                MEMORY_SIZE = 14, 
                SOURCE_FILE = "datamemory.mem"
)(
    input logic     [ADDRESS_WIDTH-1:0] address_i,
    input logic     [DATA_WIDTH-1:0]    writeData_i,
    input logic     [2:0]               DataMemControl_i,
    input logic                         writeEnable_i,
    input logic                         clk_i,
    output logic    [DATA_WIDTH-1:0]    readData_o
);

logic [DATA_WIDTH-1:0] memIn, memOut;

datamemory #(DATA_WIDTH, ADDRESS_WIDTH - 2, MEMORY_SIZE, SOURCE_FILE) dataMemory1(
    .address_i(address_i[ADDRESS_WIDTH-1:2]),
    .writeData_i(memIn),
    .writeEnable_i(writeEnable_i),
    .clk_i(clk_i),
    .readData_o(memOut)
);

datacontroller #(DATA_WIDTH) dataController1(
    .memDataIn_i(writeData_i),
    .memDataOut_i(memOut),
    .DataMenControl_i(DataMemControl_i),
    .first_2_i(address_i[1:0]),
    .writeData_o(memIn),
    .readData_o(readData_o)
);
    
endmodule
