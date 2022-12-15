module datacontroller #(
    parameter   DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] memDataIn_i, memDataOut_i, 
    input logic [2:0] dataMemControl_i,
    input logic [1:0] first_2_i,
    output logic [DATA_WIDTH-1:0] writeData_o, readData_o
);

    logic [4:0]    shiftb = {first_2_i, 3'b0}, shifth = {first_2_i[1], 4'b0};
    logic [7:0]    tmpb;
    logic [15:0]   tmph;
    logic [DATA_WIDTH-1:0] tmpData;

    always_comb 
    begin
        tmpb = {memDataIn_i >> shiftb}[7:0];
        tmph = {memDataOut_i >> shifth}[15:0];
        writeData_o = 32'b0;
        readData_o = 32'b0;
        tmpData = 0;

        case(DataMemControl_i)
            {3'b000} :
            begin
                readData_o = {{24{tmpb[7]}}, tmpb}; //lb
                tmpData = {{{memDataOut_i >> shiftb | memDataOut_i << (DATA_WIDTH - shiftb)}[DATA_WIDTH-1:8], memDataIn_i[7:0]}}[DATA_WIDTH-1:0];
                writeData_o = tmpData << shiftb | tmpData >> (DATA_WIDTH - shiftb); //sb
            end
            {3'b001} : 
            begin
                readData_o = {{16{tmph[15]}},tmph}; //lh
                tmpData = {{{memDataOut_i >> shifth | memDataOut_i << (DATA_WIDTH - shifth)}[DATA_WIDTH-1:16], memDataIn_i[15:0]}}[DATA_WIDTH-1:0];
                writeData_o = tmpData << shifth | tmpData >> (DATA_WIDTH - shifth); //sh
            end
            {3'b010} : 
            begin
                readData_o = memDataOut_i; //lw
                writeData_o = memDataIn_i; //sw
            end
            {3'b100}: readData_o = {{24{1'b0}}, tmpb}; //lbu
            {3'b101}: readData_o = {{16{1'b0}}, tmph}; //lhu
            default: 
            begin
                writeData_o = 32'b0;
                readData_o = 32'b0;
            end
        endcase
    end
endmodule
