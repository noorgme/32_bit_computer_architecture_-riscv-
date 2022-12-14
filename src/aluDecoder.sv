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
        {2'b01, 3'b000, 2'b?}: ALUControl = 3'b000; //add, addi, beq, 
        {2'b01, 3'b001, 2'b?}, {2'b10, 3'b000, 2'b11}:                          ALUControl = 3'b001; //bne, subtract
        {2'b10, 3'b001, 2'b?},  {2'b00, 3'b001, 2'b00}, {2'b01, 3'b101, 2'b?} : ALUControl = 3'b110; //bge, SLL
        {2'b10, 3'b010, 2'b?},  {2'b00, 3'b010, 2'b?}, {2'b01, 3'b110, 2'b?} :  ALUControl = 3'b101; //bltu, slt, slti, need to add sltiu
        {2'b10, 3'b111, 2'b?}, {2'b00, 3'b111, 2'b?}, {2'b01, 3'b111, 2'b?} :   ALUControl = 3'b010; //and, bgeu
        {2'b10, 3'b110, 2'b?}, {2'b00, 3'b110, 2'b?}, {2'b01, 3'b100, 2'b?}  :  ALUControl = 3'b011; //or, ori, blt
        {2'b10, 3'b100, 2'b?}, {2'b00, 3'b100, 2'b?} :                          ALUControl = 3'b100; //xor, xori
        {2'b10, 3'b101, 2'b?}, {2'b00, 3'b101, 2'b00} :                         ALUControl = 3'b111; //shift right logical
        {2'b11, 3'b?, 2'b?} :                                                   ALUControl = 3'b000; //JALR!,LW,SW
        default : ALUControl = 3'b000;
    endcase
end 

endmodule
