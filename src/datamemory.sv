module datamemory #(
    parameter   DATA_WIDTH = 32, 
                ADDRESS_WIDTH = 16
)(
    input logic     [ADDRESS_WIDTH-1:0] A,
    input logic     [DATA_WIDTH-1:0]    WD,
    input logic                         WE,
    input logic                         clk,
    output logic    [DATA_WIDTH-1:0]    RD
);

logic [DATA_WIDTH-1:0] data_mem [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) 
    begin
        if(WE == 1'b1)
            data_mem [A] <= WD;
        RD <= data_mem [A];
    end


endmodule
