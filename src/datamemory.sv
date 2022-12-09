module datamemory #(
    parameter   DATA_WIDTH = 32, 
                ADDRESS_WIDTH = 32,
                MEMORY_SIZE = 16
)(
    input logic     [ADDRESS_WIDTH-1:0] address,
    input logic     [DATA_WIDTH-1:0]    write_data,
    input logic     [2:0]               DATAMEMControl,
    input logic                         write_enable,
    input logic                         clk,
    output logic    [DATA_WIDTH-1:0]    read_data
);

    logic [DATA_WIDTH-1:0] data_mem [2**MEMORY_SIZE-1:0];
    logic [DATA_WIDTH-1:0]    d_out,d_in,tmp_intop,tmp_inbottom;
    logic [4:0]    shiftb = {2'b11 & address[1:0],3'b0},shifth = {1'b1 & address[1],4'b0};
    logic [7:0]    tmpb_out;
    logic [15:0]   tmph_out;

    always_comb begin
        tmpb_out = {d_out >> shiftb}[7:0];
        tmph_out = {d_out >> shifth}[15:0];
        d_in = 32'b0;
        read_data = 32'b0;
        tmp_inbottom =32'b0;
        tmp_intop =32'b0;
        case(DATAMEMControl)
            {3'b000}:begin
                tmp_intop = {d_out >> (shiftb+8)}[31:0];
                tmp_inbottom = {d_out << shiftb}[31:0];
                read_data = {{24{tmpb_out[7]}}, tmpb_out}; //lb
                d_in = {{tmp_intop,write_data[7:0],tmp_inbottom}>>shiftb}[31:0]; //sb
            end
            {3'b001}: begin
                tmp_intop = {d_out >> (shiftb+16)}[31:0];
                tmp_inbottom = {d_out << shiftb}[31:0];
                read_data = {{16{tmph_out[15]}},tmph_out}; //lh
                d_in = {{tmp_intop,write_data[15:0],tmp_inbottom}>>shifth}[31:0]; //sh
            end
            {3'b010}: begin
                read_data = d_out; //lw
                d_in = write_data; //sw
            end
            {3'b100}: read_data = {{24{1'b0}}, tmpb_out}; //lbu
            {3'b101}: read_data = {{16{1'b0}},tmph_out}; //lhu
            default: begin
                d_in = 32'b0;
                read_data = 32'b0;
            end
        endcase
    end

    always_ff @(posedge clk)
        begin
            d_out <= data_mem[{address}[MEMORY_SIZE+1:2]];
            if (write_enable == 1'b1) 
                data_mem[{address}[MEMORY_SIZE+1:2]] <= d_in;
        end

endmodule
