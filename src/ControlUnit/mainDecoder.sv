module mainDecoder (
   //Inputs
    input logic      [6:0]      op,
    //Outputs
    output logic                Branch,  
    output logic     [1:0]      ImmSrc, //Select Immediate offset done by signextend, differs between I-type and S-type instructions
    output logic                ALUSrc, //ALU recieves SignExt Immediate (1) or RD2 (0)
    output logic                ResultSrc, //Result source from ALU result (Sel0) or Data Memory (Sel1)
    output logic                RegWrite, //Writing to register? e.g. Load word
    output logic                MemWrite,//Writing to memory? e.g. Store word
    output logic    [1:0]       ALUOp      
); 


always_comb begin
    case (op)
        7'b0110011 : begin //R-type
                    ALUOp = 2'b10;
                    ALUSrc = 0;
                    ResultSrc = 0;
                    RegWrite = 1;
                    MemWrite = 0;
                    ImmSrc = 00; //xx
                    Branch = 0;
                    end
        7'b1100011 : begin //B-type
                    ALUOp =  01;
                    ALUSrc =  0;
                    ResultSrc = 0; //x
                    RegWrite = 0;
                    MemWrite = 0;
                    ImmSrc = 10;
                    Branch = 1;
                    end
        7'b0000011, 7'b0010011 : begin //I-type
                                ALUOp =  00;
                                ALUSrc =  1;
                                ResultSrc = 1;
                                RegWrite = 1;
                                MemWrite = 0;
                                ImmSrc = 00;
                                Branch = 0;                               
                                end
        7'b0100011 : begin //S-type
                    ALUOp =  10;
                    ALUSrc =  1;
                    ResultSrc = 0; //x
                    RegWrite = 0;
                    MemWrite = 1;
                    ImmSrc = 01;
                    Branch = 0;               
                    end
        7'b1101111 : begin //JAL
                    ALUOp =  01;
                    ALUSrc =  0;
                    ResultSrc = ; //x
                    RegWrite = 1; //To store Return address into rd (PC+4)
                    MemWrite = 0;
                    ImmSrc = 11; //Need PC+Imm20 to be calculated for jump address
                    Branch = 1;               
                    end
    endcase





end 
endmodule
