module memoryunit #(
    parameter   DATA_WIDTH = 32, ADDRESS_WIDTH = 32, MEMORY_SIZE = 14, SOURCE_FILE = "datamemory.mem"
) (
    input logic     [ADDRESS_WIDTH-1:0] address,
    input logic     [DATA_WIDTH-1:0]    write_data,
    input logic     [2:0]               DATAMEMControl,
    input logic                         write_enable,
    input logic                         clk,
    output logic    [DATA_WIDTH-1:0]    read_data
);

logic [DATA_WIDTH-1:0] mem_in,mem_out;

datamemory #(DATA_WIDTH,ADDRESS_WIDTH-2,MEMORY_SIZE,SOURCE_FILE) datamemory1(
    .address(address[ADDRESS_WIDTH-1:2]),
    .write_data(mem_in),
    .write_enable(write_enable),
    .clk(clk),
    .read_data(mem_out)
);

datacontroller #(DATA_WIDTH) data_controller1(
    .mem_data_in(write_data),
    .mem_data_out(mem_out),
    .DATAMEMControl(DATAMEMControl),
    .First_2(address[1:0]),
    .write_data(mem_in),
    .read_data(read_data)
);
    
endmodule
