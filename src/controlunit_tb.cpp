#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vcontrolunit.h"
#include <iostream>
#include <assert.h>
#include <cmath>

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
    long int sum;
    Verilated::commandArgs(argc, argv);
    Vcontrolunit * top = new Vcontrolunit;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("controlunit.vcd");

    top->eq = 0;
    top->instr = 0b000;
    top->eval();

    // todo: actually perform tests!
    
    tfp->close(); 
    exit(0);
}
