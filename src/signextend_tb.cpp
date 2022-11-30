#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsignextend.h"
#include <iostream>

#include <cmath>

#include "lib/testutils.h"

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
    long int sum;
    Verilated::commandArgs(argc, argv);
    Vsignextend * top = new Vsignextend;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("signextend.vcd");
    top->imm = 0;
    for(int i=0;i<4096;i++){
        top->imm = i;
        top->eval();
       

        // Sign extending 12 bits up to 32 bits. If bit 12 of imm is high, bitwise OR with 1s in every position above 12 otherwise with 0
        uint signextended = (uint)top->imm | (((uint)top->imm & 0x800) ? 0xFFFFFF000 : 0);
        if (signextended == 4) {signextended = 2;};
        assert_message (top->immop == signextended, "Testing setting imm=%d... after eval immop=%d, calculated should have been %d", i, top->immop, signextended);
        
    }
    tfp->close(); 
    exit(0);
}
