#include "ValuDecoder.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <stdlib.h>
#include <iostream>

int main(int argc, char **argv, char **env) {
    
    int opfn;

    Verilated::commandArgs(argc, argv);
    ValuDecoder* top = new ValuDecoder;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    top->trace (tfp, 99);
    tfp->open ("aluDecoder.vcd");

    // init sim inputs

    top->op5_i = 0b0;
    top->funct3_i = 0b000;
    top->funct7_5_i = 0b0;
    top->aluOp_i = 0b00;

    for (int i = 0; i < 20; i++){
        tfp->dump(i);
        opfn = top->op5_i << 1 | top->funct7_5_i;

        if (i <= 1 && i >= 0) {
            top->aluOp_i = top->aluOp_i + 0b1;
        } else if (top->aluOp_i == 0b10) {   

            if (top->funct3_i == 0b000) {  

                switch(opfn) {
                    case (0b00) : 
                        top->funct7_5_i = 0b1;
                        break;   
                    case (0b01) :
                        top->op5_i = 0b1;
                        top->funct7_5_i = 0b0;
                        break;
                    case (0b10) :
                        top->funct7_5_i = 0b1;
                        break;
                    case (0b11) :   
                        top->funct3_i = 0b010;
                        top->op5_i = 0b0;
                        top->funct7_5_i = 0b0;
                        break;
                    default : 
                        top->op5_i = top->op5_i;
                        top->funct7_5_i = top->funct7_5_i;
                        break;
                    }

            } else if (top->funct3_i == 0b010) {
                top->funct3_i = 0b110;
            } else if (top->funct3_i == 0b110) {
                top->funct3_i = 0b111;
            }
        }
        top->eval();
    }
    tfp->close();
    if ((Verilated::gotFinish()) /*|| (vbdGetkey()=='q')*/ ) 
        exit(0); 
}
