module alu #(
    parameter DATA_WIDTH = 32,CONTROLL_WIDTH = 3
)(
    input logic [DATA_WIDTH-1:0] op1,op2,
    input logic [CONTROLL_WIDTH-1:0] ctrl,
    output logic [DATA_WIDTH-1:0] aluout,
    output logic zero
);

    typedef enum [CONTROLL_WIDTH-1:0]{ADD=0,SUB=1,AND=2,OR=3,SLT=5} alumodes;
    int signed op1sin = op1, op2sin = op2;

    always_comb begin
        case (ctrl)
            ADD:    aluout = {op1 + op2}[DATA_WIDTH-1:0];
            SUB:    aluout = {op1 - op2}[DATA_WIDTH-1:0];
            AND:    aluout = {op1 & op2};
            OR:     aluout = {op1 | op2};
            SLT:begin
                if(op1<op2) aluout = op1;
                else aluout = op2;
            end
            default: aluout = op1;
        endcase
        zero = 0;
        case (ctrl)
            ADD:    if(op1 == op2) zero = 1;
            SUB:    if(op1sin >= op2sin) zero = 1;
            AND:    if(op1 >= op2) zero = 1;
            OR:     if(op1sin < op2sin) zero = 1;
            SLT:    if(op1 < op2) zero = 1;
            default: zero = 0;
        endcase
    end

endmodule
