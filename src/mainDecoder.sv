module mainDecoder (
   //Inputs
    input logic      [6:0]      op,
    //Outputs
    output logic     [1:0]      Branch,  
    output logic     [2:0]      ImmSrc, //Select Immediate offset done by signextend, differs between I-type and S-type instructions
    output logic                ALUSrc, //ALU recieves SignExt Immediate (1) or RD2 (0)
    output logic     [1:0]      ResultSrc, //Result source from ALU result (Sel0) or Data Memory (Sel1) or (PC+4) (SEL2)
    output logic                RegWrite, //Writing to register? e.g. Load word
    output logic                MemWrite,//Writing to memory? e.g. Store word
    output logic     [1:0]      ALUOp      
); 


    always_comb begin
        case (op)
            7'b0110011 : begin //R-type
                        ALUOp = 2'b10;
                        ALUSrc = 1'b0;
                        ResultSrc = 2'b01;
                        RegWrite = 1'b1;
                        MemWrite = 1'b0;
                        ImmSrc = 3'b000; //xx
                        Branch = 2'b00;
                        end
            7'b1100011 : begin //B-type
                        ALUOp =  2'b01;
                        ALUSrc = 1'b0;
                        ResultSrc = 2'b00; //x
                        RegWrite = 1'b0;
                        MemWrite = 1'b0;
                        ImmSrc = 3'b010;
                        Branch = 2'b01;
                        end
            7'b0010011 : begin //I-type
                        ALUOp =  2'b00;
                        ALUSrc =  1'b1;
                        ResultSrc = 2'b01; //lb
                        RegWrite = 1'b1;
                        MemWrite = 1'b0;
                        ImmSrc = 3'b000;
                        Branch = 2'b00;                               
                        end
            7'b0000011 : begin //load instructions
                        ALUOp =  2'b11;
                        ALUSrc =  1'b1;
                        ResultSrc = 2'b00;
                        RegWrite = 1'b1;
                        MemWrite = 1'b0;
                        ImmSrc = 3'b000;
                        Branch = 2'b00;                               
                        end
            7'b0100011 : begin //Store instructions
                        ALUOp =  2'b11;
                        ALUSrc =  1'b1;
                        ResultSrc = 2'b00; //x
                        RegWrite = 1'b0;
                        MemWrite = 1'b1;
                        ImmSrc = 3'b001;
                        Branch = 2'b00;               
                        end
            7'b1101111 : begin //JAL
                        ALUOp =  2'b00; //dont care 
                        ALUSrc = 1'b1;
                        ResultSrc = 2'b10;
                        RegWrite = 1'b1; //To store Return address into rd (PC+4)
                        MemWrite = 1'b0;
                        ImmSrc = 3'b011; //Need Imm20 for jump address
                        Branch = 2'b10;               
                        end
            7'b0110111 : begin //lui
                        ALUOp =  2'b00;
                        ALUSrc =  1'b0;
                        ResultSrc = 2'b11;
                        RegWrite = 1'b1;
                        MemWrite = 1'b0;
                        ImmSrc = 3'b100;
                        Branch = 2'b00;               
                        end
            7'b1100111 : begin //JALR
                        ALUOp =  2'b11; //set to get ALU to ADD (PC+RS1+IMMOP)
                        ALUSrc = 1'b1;
                        ResultSrc = 2'b10;
                        RegWrite = 1'b1; 
                        MemWrite = 1'b0;
                        ImmSrc = 3'b000; 
                        Branch = 2'b11;
                        end    
            default : begin
                        ALUOp =  2'b00;
                        ALUSrc = 1'b0;
                        ResultSrc = 2'b00;
                        RegWrite = 1'b0; 
                        MemWrite = 1'b0;
                        ImmSrc = 3'b000; 
                        Branch = 2'b00;               
                        end
        endcase
    end 
endmodule
