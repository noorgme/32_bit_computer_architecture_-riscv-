module datacontroller #(
    parameter   DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] memDataIn_i, 
    input logic [3:0][DATA_WIDTH/4-1:0] memDataOut_i, 
    input logic [2:0] dataMemControl_i,
    input logic [1:0] first_2_i,
    output logic [3:0][DATA_WIDTH/4-1:0] writeData_o,
    output logic [DATA_WIDTH-1:0] readData_o
);

    always_comb begin
        writeData_o = 0;
        readData_o = 0;
        case(dataMemControl_i)
            {3'b000}:
            begin
                readData_o = {{24{memDataOut_i[first_2_i][7]}},memDataOut_i[first_2_i]}; //lb
                writeData_o = memDataOut_i; 
                writeData_o[first_2_i] = memDataIn_i[7:0]; //sb
            end
            {3'b001}: 
            begin
                readData_o = {{16{memDataOut_i[{first_2_i[1],1'b0}+:2][15]}},memDataOut_i[{first_2_i[1],1'b0}+:2]}; //lh
                writeData_o = memDataOut_i;
                writeData_o[{first_2_i[1],1'b0}+:2] = memDataIn_i[15:0]; //sh
            end
            {3'b010}: 
            begin
                readData_o = memDataOut_i; //lw
                writeData_o = memDataIn_i; //sw
            end
            {3'b100}: readData_o = {{24{1'b0}},memDataOut_i[first_2_i]}; //lbu
            {3'b101}: readData_o = {{16{1'b0}},memDataOut_i[{first_2_i[1],1'b0}+:2]}; //lhu
            default: 
            begin
                writeData_o = 0;
                readData_o = 0;
            end
        endcase
    end
endmodule
