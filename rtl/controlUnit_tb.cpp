#include "VcontrolUnit.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <stdlib.h>
#include <iostream>



int main(int argc, char **argv, char **env) {

    Verilated::commandArgs(argc, argv);
    VcontrolUnit* top = new VcontrolUnit;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    top->trace (tfp, 99);
    tfp->open ("controlUnit.vcd");
    
    //init zero input

    top->zero_i = 0b0;

    for (int i = 0; i < 20; i++) {
        switch(i) {
            //R-Type Tests
            case(0): //ADD
                top->op_i = 0b0110011;
                top->funct3_i = 0b000;
                top->funct7_5_i = 0b0;
                break;
            case(1): //SUB
                top->funct7_5_i = 0b1;
                top->op_i = 0b0110011;                 
                break;  
            case(2): //LEFT SHIFT LOGICAL
                top->op_i = 0b0110011;
                top->funct3_i = 0b001;
                top->funct7_5_i = 0b0;  
                break;
            case(3): //XOR
                top->op_i = 0b0110011;
                top->funct3_i = 0b100;
                top->funct7_5_i = 0b0;   
                break;
            case(4): //SHIFT RIGHT ARITHMETIC
                top->op_i = 0b0110011;
                top->funct3_i = 0b101;
                top->funct7_5_i = 0b1; 
                break;

            //B-Type tests

            case(5): //BEQ
                top->op_i = 0b1100011;
                top->funct3_i = 0b000;
                top->zero_i = 0b1;
                break;  
            case(6): //BNE
                top->op_i = 0b1100011;
                top->funct3_i = 0b001;
                top->zero_i = 0b1; 
                break;

            //I-type and S-type

            case(7): //LW
                top->op_i = 0b0000011;
                top->funct3_i = 0b010;
                top->zero_i = 0b0; 
                break;
            case(8): //SW
                top->op_i = 0b0100011;
                top->funct3_i = 0b010;
                top->zero_i = 0b0; 
                break;

            //Jump Test

            case(9): //JAL
                top->op_i = 0b1101111;
                top->zero_i = 0b1;
                break;

            default: top->op_i = 0;
        }
        top->eval();
        tfp->dump(i);
    }
    tfp->close();
    if ((Verilated::gotFinish()) /*|| (vbdGetkey()=='q')*/ ) 
        exit(0);    
}
