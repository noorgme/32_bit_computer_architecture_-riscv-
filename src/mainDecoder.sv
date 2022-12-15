module mainDecoder (
   //Inputs
    input logic      [6:0]      op_i,
    //Outputs
    output logic     [1:0]      branch_o,  
    output logic     [2:0]      immSrc_o, //Select Immediate offset done by signextend, differs between I-type and S-type instructions
    output logic                aluSrc_o, //ALU recieves SignExt Immediate (1) or RD2 (0)
    output logic     [1:0]      resultSrc_o, //Result source from ALU result (Sel0) or Data Memory (Sel1) or (PC+4) (SEL2)
    output logic                regWrite_o, //Writing to register? e.g. Load word
    output logic                memWrite_o,//Writing to memory? e.g. Store word
    output logic     [1:0]      aluOp_o      
); 
    always_comb 
    begin
        case (op)
            7'b0110011 : 
            begin //R-type
                        aluOp_o = 2'b10;
                        aluSrc_o = 1'b0;
                        resultSrc_o = 2'b01;
                        regWrite_o = 1'b1;
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b000; //xx
                        branch_o = 2'b00;
            end
            7'b1100011 : 
            begin //B-type
                        aluOp_o =  2'b01;
                        aluSrc_o = 1'b0;
                        resultSrc_o = 2'b00; //x
                        regWrite_o = 1'b0;
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b010;
                        branch_o = 2'b01;
            end
            7'b0010011 : 
            begin //I-type
                        aluOp_o =  2'b00;
                        aluSrc_o =  1'b1;
                        resultSrc_o = 2'b01; //lb
                        regWrite_o = 1'b1;
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b000;
                        branch_o = 2'b00;                               
            end
            7'b0000011 : 
            begin //load instructions
                        aluOp_o =  2'b11;
                        aluSrc_o =  1'b1;
                        resultSrc_o = 2'b00;
                        regWrite_o = 1'b1;
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b000;
                        branch_o = 2'b00;                               
            end
            7'b0100011 : 
            begin //Store instructions
                        aluOp_o =  2'b11;
                        aluSrc_o =  1'b1;
                        resultSrc_o = 2'b00; //x
                        regWrite_o = 1'b0;
                        memWrite_o = 1'b1;
                        immSrc_o = 3'b001;
                        branch_o = 2'b00;               
            end
            7'b1101111 : 
            begin //JAL
                        aluOp_o =  2'b00; //dont care 
                        aluSrc_o = 1'b1;
                        resultSrc_o = 2'b10;
                        regWrite_o = 1'b1; //To store Return address into rd (PC+4)
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b011; //Need Imm20 for jump address
                        branch_o = 2'b10;               
            end
            7'b0110111 : 
            begin //lui
                        aluOp_o =  2'b00;
                        aluSrc_o =  1'b0;
                        resultSrc_o = 2'b11;
                        regWrite_o = 1'b1;
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b100;
                        branch_o = 2'b00;               
            end
            7'b1100111 : 
            begin //JALR
                        aluOp_o =  2'b11; //set to get ALU to ADD (PC+RS1+IMMOP)
                        aluSrc_o = 1'b1;
                        resultSrc_o = 2'b10;
                        regWrite_o = 1'b1; 
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b000; 
                        branch_o = 2'b11;
            end    
            default : 
            begin
                        aluOp_o =  2'b00;
                        aluSrc_o = 1'b0;
                        resultSrc_o = 2'b00;
                        regWrite_o = 1'b0; 
                        memWrite_o = 1'b0;
                        immSrc_o = 3'b000; 
                        branch_0 = 2'b00;               
            end
        endcase
    end 
endmodule
