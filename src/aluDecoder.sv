module aluDecoder (
//Inputs
    input logic [2:0] funct3,
    input logic       funct7_5,
    input logic       op5,
    input logic [1:0] ALUOp,
//Ouputs
    output logic [3:0] ALUControl,
    output logic [2:0] DATAMEMControl
);


always_comb begin
    DATAMEMControl = {funct3[2:0]};
    casez({ALUOp, funct3, {op5, funct7_5}})
        {2'b00, 3'b?, 2'b?} : ALUControl = 4'b0000; //add (for lw, sw)
        {2'b10, 3'b000, 2'b00}, {2'b10, 3'b000, 2'b01}, {2'b10, 3'b000, 2'b10}: ALUControl = 4'b0000; //add
        {2'b01, 3'b?, 2'b?} : ALUControl = 4'b0001; //subtract (for beq)
        {2'b10, 3'b000, 2'b11} : ALUControl = 4'b0001; //subtract
        {2'b10, 3'b111, 2'b?} : ALUControl = 4'b0010; //and
        {2'b10, 3'b110, 2'b?} : ALUControl = 4'b0011; //or
        {2'b10, 3'b100, 2'b?} : ALUControl = 4'b0100; //xor
        {2'b10, 3'b010, 2'b?} : ALUControl = 4'b0101; //set less than
        {2'b10, 3'b001, 2'b?} : ALUControl = 4'b0110; //shift left logical
        {2'b10, 3'b101, 2'b?} : ALUControl = 4'b0111; //shift right logical
        {2'b11, 3'b?, 2'b?} : ALUControl = 4'b1000; //JAL!
        default : ALUControl = 4'b0000;
    endcase
end 

endmodule
