module aluDecoder (
//Inputs
    input logic [2:0] funct3,
    input logic       funct7_5,
    input logic       op5,
    input logic [1:0] ALUOp,
//Ouputs
    output logic [2:0] ALUControl,
    output logic [2:0] DATAMEMControl
);


always_comb begin
    DATAMEMControl = {funct3[2:0]};
    casez({ALUOp, funct3, {op5, funct7_5}})
        {2'b00, 3'b?, 2'b?} : ALUControl = 3'b000; //add (for lw, sw)
        {2'b10, 3'b000, 2'b00}, {2'b10, 3'b000, 2'b01}, {2'b10, 3'b000, 2'b10}: ALUControl = 3'b000; //add
        {2'b01, 3'b?, 2'b?} : ALUControl = 3'b001; //subtract (for beq)
        {2'b10, 3'b000, 2'b11} : ALUControl = 3'b001; //subtract
        {2'b10, 3'b111, 2'b?} : ALUControl = 3'b010; //and
        {2'b10, 3'b110, 2'b?} : ALUControl = 3'b011; //or
        {2'b10, 3'b100, 2'b?} : ALUControl = 3'b100; //xor
        {2'b10, 3'b010, 2'b?} : ALUControl = 3'b101; //set less than
        {2'b10, 3'b001, 2'b?} : ALUControl = 3'b110; //shift left logical
        {2'b10, 3'b101, 2'b?} : ALUControl = 3'b111; //shift right logical
        default : ALUControl = 3'b000;
    endcase
end 

endmodule
