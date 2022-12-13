module datamemory #(
    parameter   DATA_WIDTH = 32, 
                ADDRESS_WIDTH = 32,
                MEMORY_SIZE = 16
)(
    input logic     [ADDRESS_WIDTH-1:0] address,
    input logic     [DATA_WIDTH-1:0]    write_data,
    input logic                         write_enable,
    input logic                         clk,
    output logic    [DATA_WIDTH-1:0]    read_data
);

    logic [DATA_WIDTH-1:0] data_mem [2**MEMORY_SIZE-1:0];

    always_ff @(posedge clk)
        begin
            if (write_enable == 1'b1) 
                data_mem[{address}[MEMORY_SIZE+1:2]] <= d_in;
        end

endmodule
