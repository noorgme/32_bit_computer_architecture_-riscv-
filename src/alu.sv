module alu #(
    parameter DATA_WIDTH = 32,CONTROLL_WIDTH = 3
)(
    input logic [DATA_WIDTH-1:0] op[2],
    input logic [CONTROLL_WIDTH-1:0] ctrl,
    output logic [DATA_WIDTH-1:0] aluout,
    output logic eq
);

    typedef enum [2:0]{ADD=0,SUB=1} alumodes;

    always_comb begin
        case (ctrl)
            ADD:    aluout = {op[0] + op[1]}[DATA_WIDTH-1:0];
            SUB:    aluout = {op[0] - op[1]}[DATA_WIDTH-1:0];
            default: aluout = op[0];
        endcase
        if(op[0]==op[1]) eq=1;
        else eq=0;
    end

endmodule
