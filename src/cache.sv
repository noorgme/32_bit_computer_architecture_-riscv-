module cache #(
    parameter DATA_WIDTH =32,ADDRESS_WIDTH = 30,CACHE_SIZE = 4,BLOCK_SIZE = 1
) (
    /* verilator lint_off UNUSED */
    /* verilator lint_off UNDRIVEN */
    input logic [ADDRESS_WIDTH-1:0] address,
    input logic [DATA_WIDTH-1:0] mem_data_in,
    output logic [DATA_WIDTH-1:0] d_out,
    output logic [ADDRESS_WIDTH-1:0] mem_address
);

parameter TAG_SIZE =  ADDRESS_WIDTH-CACHE_SIZE;
parameter V = DATA_WIDTH*BLOCK_SIZE+ADDRESS_WIDTH-CACHE_SIZE; //The V flag
logic [ADDRESS_WIDTH-CACHE_SIZE-1:0] tag = address[ADDRESS_WIDTH-1:CACHE_SIZE]; //tag
logic [CACHE_SIZE-BLOCK_SIZE-1:0] set = address[CACHE_SIZE-1:BLOCK_SIZE]; //Which Set
logic [BLOCK_SIZE-1:0] way = address[BLOCK_SIZE-1:0]; //Which Block
logic [V:0] tmpdata;


logic [V:0] cache_mem [2**(CACHE_SIZE-BLOCK_SIZE)-1:0];

always_comb begin
    if((cache_mem[set][V]!=0)&&(cache_mem[set][V-1:V-TAG_SIZE] == tag))begin
    end
    else begin
    end
end
    
endmodule
