module memoryunit #(
    parameter   DATA_WIDTH = 32, ADDRESS_WIDTH = 32
) (
    input logic     [ADDRESS_WIDTH-1:0] address,
    input logic     [DATA_WIDTH-1:0]    write_data,
    input logic     [2:0]               DATAMEMControl,
    input logic                         write_enable,
    input logic                         clk,
    output logic    [DATA_WIDTH-1:0]    read_data
);

logic [DATA_WIDTH-1:0] mem_in,mem_out;

datamemory #(DATA_WIDTH,ADDRESS_WIDTH) data_mem(
    .address(address),
    .write_data(mem_in),
    .write_enable(write_enable),
    .clk(clk),
    .read_data(d_out)
);

datacontroller #(DATA_WIDTH,ADDRESS_WIDTH) data_controll(
    .mem_data_in(write_data),
    .mem_data_out(d_out),
    .DATAMEMControl(DATAMEMControl),
    .write_data(mem_in),
    .read_data(read_data)
);
    
endmodule
