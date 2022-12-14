module datacontroller #(
    parameter   DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] mem_data_in, mem_data_out, 
    input logic [2:0] DATAMEMControl,
    input logic [1:0] First_2,
    output logic [DATA_WIDTH-1:0] write_data, read_data
);

    logic [4:0]    shiftb = {First_2,3'b0},shifth = {First_2[1],4'b0};
    logic [7:0]    tmpb_out;
    logic [15:0]   tmph_out;
    logic [DATA_WIDTH-1:0] tmp_data;

    always_comb begin
        tmpb_out = {mem_data_out >> shiftb}[7:0];
        tmph_out = {mem_data_out >> shifth}[15:0];
        write_data = 32'b0;
        read_data = 32'b0;
        tmp_data = 0;
        case(DATAMEMControl)
            {3'b000}:begin
                read_data = {{24{tmpb_out[7]}}, tmpb_out}; //lb
                tmp_data = {{{mem_data_out>>shiftb|mem_data_out<<(DATA_WIDTH-shiftb)}[DATA_WIDTH-1:8],mem_data_in[7:0]}}[DATA_WIDTH-1:0];
                write_data = tmp_data<<shiftb|tmp_data>>(DATA_WIDTH-shiftb); //sb
            end
            {3'b001}: begin
                read_data = {{16{tmph_out[15]}},tmph_out}; //lh
                tmp_data = {{{mem_data_out>>shifth|mem_data_out<<(DATA_WIDTH-shifth)}[DATA_WIDTH-1:16],mem_data_in[15:0]}}[DATA_WIDTH-1:0];
                write_data = tmp_data<<shifth|tmp_data>>(DATA_WIDTH-shifth); //sh
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
