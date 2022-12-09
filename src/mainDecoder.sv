module mainDecoder (
   //Inputs
    input logic      [6:0]      op,
    //Outputs
    output logic     [1:0]      Branch,  
    output logic     [1:0]      ImmSrc, //Select Immediate offset done by signextend, differs between I-type and S-type instructions
    output logic     [1:0]      ALUSrc, //ALU recieves SignExt Immediate (1) or RD2 (0)
    output logic                ResultSrc, //Result source from ALU result (Sel0) or Data Memory (Sel1)
    output logic                RegWrite, //Writing to register? e.g. Load word
    output logic                MemWrite,//Writing to memory? e.g. Store word
    output logic     [1:0]      ALUOp      
); 


    always_comb begin
        case (op)
            7'b0110011 : begin //R-type
                        ALUOp = 2'b10;
                        ALUSrc = 2'b00;
                        ResultSrc = 1'b0;
                        RegWrite = 1'b1;
                        MemWrite = 1'b0;
                        ImmSrc = 2'b00; //xx
                        Branch = 2'b00;
                        end
            7'b1100011 : begin //B-type
                        ALUOp =  2'b01;
                        ALUSrc = 2'b00;
                        ResultSrc = 1'b0; //x
                        RegWrite = 1'b0;
                        MemWrite = 1'b0;
                        ImmSrc = 2'b10;
                        Branch = 2'b01;
                        end
            7'b0000011, 7'b0010011 : begin //I-type
                                    ALUOp =  2'b00;
                                    ALUSrc = 2'b01;
                                    ResultSrc = 1'b1;
                                    RegWrite = 1'b1;
                                    MemWrite = 1'b0;
                                    ImmSrc = 2'b00;
                                    Branch = 2'b00;                               
                                    end
            7'b0100011 : begin //S-type
                        ALUOp =  2'b10;
                        ALUSrc = 2'b01;
                        ResultSrc = 1'b0; //x
                        RegWrite = 1'b0;
                        MemWrite = 1'b1;
                        ImmSrc = 2'b01;
                        Branch = 2'b00;               
                        end
            7'b1101111 : begin //JAL
                        ALUOp =  2'b01;
                        ALUSrc = 2'b10;
                        ResultSrc = 1'b0;
                        RegWrite = 1'b1; //To store Return address into rd (PC+4)
                        MemWrite = 1'b0;
                        ImmSrc = 2'b11; //Need Imm20 for jump address
                        Branch = 2'b10;               
                        end
            default : begin
                        ALUOp =  2'b00;
                        ALUSrc = 2'b00;
                        ResultSrc = 1'b0;
                        RegWrite = 1'b0; 
                        MemWrite = 1'b0;
                        ImmSrc = 2'b00; 
                        Branch = 2'b00;               
                        end
        endcase
    end 
endmodule
