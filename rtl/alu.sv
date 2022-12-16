module alu #(
    parameter DATA_WIDTH = 32,CONTROLL_WIDTH = 4
)(
    input logic [DATA_WIDTH-1:0] op1_i , op2_i,
    input logic [CONTROLL_WIDTH-1:0] ctrl_i,
    output logic [DATA_WIDTH-1:0] alu_o,
    output logic zero_o
);

    typedef enum [CONTROLL_WIDTH-1:0]{ADD=0,SUB=1,AND=2,OR=3,XOR=4,SLT=5,SLL=6,SRL=7,SRA=8} alumodes;
    int signed op1sin = op1_i, op2sin = op2_i;

    always_comb begin
        case (ctrl_i)
            ADD:    alu_o = {op1_i + op2_i}[DATA_WIDTH-1:0];
            SUB:    alu_o = {op1_i - op2_i}[DATA_WIDTH-1:0];
            AND:    alu_o = {op1_i & op2_i};
            OR:     alu_o = {op1_i | op2_i};
            XOR:    alu_o = {op1_i ^ op2_i};
            SLT: 
            begin
                if(op1_i < op2_i) alu_o = op1_i;
                else alu_o = op2_i;
            end
            SLL: alu_o = {op1_i << op2_i}[DATA_WIDTH-1:0];
            SRL: alu_o = {op1_i >> op2_i}[DATA_WIDTH-1:0];
            SRA: alu_o = {op1_i >>> op2_i}[DATA_WIDTH-1:0];
            default: alu_o = op1_i;
        endcase

        zero_o = 0;
        
        case (ctrl_i)
            ADD:    if(op1_i == op2_i) zero_o = 1;//be1
            SUB:    if(op1sin != op2sin) zero_o = 1;//bne
            AND:    if(op1_i >= op2_i) zero_o = 1;//bgeu
            SLL:    if(op1sin >= op2sin) zero_o = 1;//bge
            OR:     if(op1sin < op2sin) zero_o = 1;//blt
            SLT:    if(op1_i < op2_i) zero_o = 1;//bltu
            default: zero_o = 0;
        endcase
    end

endmodule
