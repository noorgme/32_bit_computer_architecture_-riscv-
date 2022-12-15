module datacontroller #(
    parameter   DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] mem_data_in, 
    input logic [3:0][DATA_WIDTH/4-1:0] mem_data_out, 
    input logic [2:0] DATAMEMControl,
    input logic [1:0] First_2,
    output logic [3:0][DATA_WIDTH/4-1:0] write_data,
    output logic [DATA_WIDTH-1:0] read_data
);

    always_comb begin
        write_data = 0;
        read_data = 0;
        case(DATAMEMControl)
            {3'b000}:begin
                read_data = {{24{mem_data_out[First_2][7]}},mem_data_out[First_2]}; //lb
                write_data = mem_data_out; 
                write_data[First_2] =mem_data_in[7:0]; //sb
            end
            {3'b001}: begin
                read_data = {{16{mem_data_out[{First_2[1],1'b0}+:2][15]}},mem_data_out[{First_2[1],1'b0}+:2]}; //lh
                write_data = mem_data_out;
                write_data[{First_2[1],1'b0}+:2]=mem_data_in[15:0]; //sh
            end
            {3'b010}: begin
                read_data = mem_data_out; //lw
                write_data =mem_data_in; //sw
            end
            {3'b100}: read_data = {{24{1'b0}},mem_data_out[First_2]}; //lbu
            {3'b101}: read_data = {{16{1'b0}},mem_data_out[{First_2[1],1'b0}+:2]}; //lhu
            default: begin
                write_data = 0;
                read_data = 0;
            end
        endcase
    end

endmodule
