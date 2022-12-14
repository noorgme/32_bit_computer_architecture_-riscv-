module alu #(
    parameter DATA_WIDTH = 32,CONTROLL_WIDTH = 4
)(
    input logic [DATA_WIDTH-1:0] op1,op2,
    input logic [CONTROLL_WIDTH-1:0] ctrl,
    output logic [DATA_WIDTH-1:0] aluout,
    output logic zero
);

    typedef enum [CONTROLL_WIDTH-1:0]{ADD=0,SUB=1,AND=2,OR=3,XOR=4,SLT=5,SLL=6,SRL=7,SRA=8} alumodes;
    int signed op1sin = op1, op2sin = op2;

    always_comb begin
        case (ctrl)
            ADD:    aluout = {op1 + op2}[DATA_WIDTH-1:0];
            SUB:    aluout = {op1 - op2}[DATA_WIDTH-1:0];
            AND:    aluout = {op1 & op2};
            OR:     aluout = {op1 | op2};
            XOR:    aluout = {op1 ^ op2};
            SLT:begin
                if(op1<op2) aluout = op1;
                else aluout = op2;
            end
            SLL: aluout = {op1 << op2}[DATA_WIDTH-1:0];
            SRL: aluout = {op1 >> op2}[DATA_WIDTH-1:0];
            SRA: aluout = {op1 >>> op2}[DATA_WIDTH-1:0];
            default: aluout = op1;
        endcase
        zero = 0;
        case (ctrl)
            ADD:    if(op1 == op2) zero = 1;//be1
            SUB:    if(op1sin != op2sin) zero = 1;//bne
            AND:    if(op1 >= op2) zero = 1;//bgeu
            SLL:    if(op1sin>=op2sin) zero = 1;//bge
            OR:     if(op1sin < op2sin) zero = 1;//blt
            SLT:    if(op1 < op2) zero = 1;//bltu
            default: zero = 0;
        endcase
    end

endmodule
