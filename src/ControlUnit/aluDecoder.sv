module aluDecoder (
//Inputs
    input logic [2:0] funct3,
    input logic       funct7_5,
    input logic       op5,
    input logic [1:0] ALUOp,
//Ouputs
    output logic [2:0] ALUControl
);


always_comb begin
    casez({ALUOp, funct3, {op5, funct7_5}})
        {2'b00, 3'bx, 2'bx} : ALUControl = 3'b000; //add (for lw, sw)
        {2'b01, 3'bx, 2'bx} : ALUControl = 3'b001; //subtract (for beq)
        {2'b10, 3'b000, 2'b00}, {2'b10, 3'b000, 2'b01}, {2'b10, 3'b000, 2'b10}: ALUControl = 3'b000; //add
        {2'b10, 3'b000, 2'b11} : ALUControl = 001; //subtract
        {2'b10, 3'b010, 2'bx} : ALUControl = 101; //set less than
        {2'b10, 3'b110, 2'bx} : ALUControl = 011; //or
        {2'b10, 3'b111, 2'bx} : ALUControl = 010; //and
    endcase
end 

endmodule