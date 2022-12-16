module aluDecoder (
//Inputs
    input logic [2:0] funct3_i,
    input logic       funct7_5_i,
    input logic       op5_i,
    input logic [1:0] aluOp_i,
//Ouputs
    output logic [3:0] aluControl_o
);


always_comb 
    begin
    casez({aluOp_i, funct3_i, {op5_i, funct7_5_i}})
        {2'b01, 3'b000, 2'b?}:                                                  aluControl_o = 4'b0000; //add, addi, beq = 0
        {2'b01, 3'b001, 2'b?}, {2'b10, 3'b000, 2'b11}:                          aluControl_o = 4'b0001; //bne, subtract = 1
        {2'b10, 3'b001, 2'b?},  {2'b00, 3'b001, 2'b00}, {2'b01, 3'b101, 2'b?} : aluControl_o = 4'b0110; //bge, sll = 6
        {2'b10, 3'b010, 2'b?},  {2'b00, 3'b010, 2'b?}, {2'b01, 3'b110, 2'b?} :  aluControl_o = 4'b0101; //bltu, slt, slti, need to add sltiu = 5
        {2'b10, 3'b111, 2'b?}, {2'b00, 3'b111, 2'b?}, {2'b01, 3'b111, 2'b?} :   aluControl_o = 4'b0010; //and, bgeu = 2
        {2'b10, 3'b110, 2'b?}, {2'b00, 3'b110, 2'b?}, {2'b01, 3'b100, 2'b?}  :  aluControl_o = 4'b0011; //or, ori, blt = 3
        {2'b10, 3'b100, 2'b?}, {2'b00, 3'b100, 2'b?} :                          aluControl_o = 4'b0100; //xor, xori = 4
        {2'b10, 3'b101, 2'b?0}, {2'b00, 3'b101, 2'b00} :                        aluControl_o = 4'b0111; //srl = 7
        {2'b10, 3'b101, 2'b?1} :                                                aluControl_o = 4'b1000; //sra = 8
        {2'b11, 3'b?, 2'b?} :                                                   aluControl_o = 4'b0000; //JALR! = 0, LW, SW
        default :                                                               aluControl_o = 4'b0000;
    endcase
    end 

endmodule
