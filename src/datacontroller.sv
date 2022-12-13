module datacontroller #(
    parameter   DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] mem_data_in, mem_data_out, 
    input logic [2:0] DATAMEMControl,
    input logic [1:0] First_2,
    output logic [DATA_WIDTH-1:0] write_data, read_data
);

    logic [DATA_WIDTH-1:0]    tmp_intop,tmp_inbottom;
    logic [4:0]    shiftb = {2'b11 & First_2,3'b0},shifth = {1'b1 & First_2[1],4'b0};
    logic [7:0]    tmpb_out;
    logic [15:0]   tmph_out;

    always_comb begin
        tmpb_out = {mem_data_out >> shiftb}[7:0];
        tmph_out = {mem_data_out >> shifth}[15:0];
        write_data = 32'b0;
        read_data = 32'b0;
        tmp_inbottom =32'b0;
        tmp_intop =32'b0;
        case(DATAMEMControl)
            {3'b000}:begin
                tmp_intop = {mem_data_out >> (shiftb+8)}[31:0];
                tmp_inbottom = {mem_data_out << (32-shiftb)}[31:0];
                read_data = {{24{tmpb_out[7]}}, tmpb_out}; //lb
                write_data = {{tmp_intop,mem_data_in[7:0],tmp_inbottom}>>(32-shiftb)}[31:0]; //sb
            end
            {3'b001}: begin
                tmp_intop = {mem_data_out >> (shiftb+16)}[31:0];
                tmp_inbottom = {mem_data_out << (32-shiftb)}[31:0];
                read_data = {{16{tmph_out[15]}},tmph_out}; //lh
                write_data = {{tmp_intop,mem_data_in[15:0],tmp_inbottom}>>(32-shifth)}[31:0]; //sh
            end
            {3'b010}: begin
                read_data = mem_data_out; //lw
                write_data = mem_data_in; //sw
            end
            {3'b100}: read_data = {{24{1'b0}}, tmpb_out}; //lbu
            {3'b101}: read_data = {{16{1'b0}},tmph_out}; //lhu
            default: begin
                write_data = 32'b0;
                read_data = 32'b0;
            end
        endcase
    end

endmodule
