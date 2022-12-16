module controlUnit (
//Inputs
    input logic zero_i,
    input logic [6:0] op_i,
    input logic [2:0] funct3_i,
    input logic funct7_5_i,
//Outputs
    output logic [1:0] pcSrc_o, //Select PC:=PC+4 (Sel0) or PC:=PC+ImmOp (Sel1) or PC:=ImmOp (Sel2)
    output logic [1:0] resultSrc_o,
    output logic memWrite_o,
    output logic [3:0] aluControl_o,
    output logic aluSrc_o,
    output logic [2:0] immSrc_o,
    output logic regWrite_o
);

wire [1:0] branchWire;
wire [1:0] aluOpWire;

always_comb
    begin
        if (((branchWire == 2'b01) && (zero_i == 1'b1)) || (branchWire == 2'b10))       assign pcSrc_o = 2'b01;
        else if (branchWire == 2'b11)                                                   assign pcSrc_o = 2'b10;
        else                                                                            assign pcSrc_o = 2'b00;
    end

mainDecoder mainDecoder(
//Inputs
    .op_i (op_i),
//Outputs
    .branch_o (branchWire),
    .immSrc_o (immSrc_o),
    .aluSrc_o (aluSrc_o),
    .resultSrc_o (resultSrc_o),
    .regWrite_o (regWrite_o),
    .memWrite_o (memWrite_o),
    .aluOp_o (aluOpWire)
);

aluDecoder aluDecoder (
//Inputs
    .funct3_i (funct3_i),
    .funct7_5_i (funct7_5_i),
    .op5_i (op_i[5]),
    .aluOp_i (aluOpWire),
//Outputs
    .aluControl_o (aluControl_o)
);

endmodule
