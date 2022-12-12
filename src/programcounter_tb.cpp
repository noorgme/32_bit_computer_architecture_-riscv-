#include "Vprogramcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <stdlib.h>
#include <iostream>



int main(int argc, char **argv, char **env) {
    int i;
    int clk;
    srand (time(NULL));

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vprogramcounter* top = new Vprogramcounter;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("programcounter.vcd");

    // init sim inputs
    top->clk = 1;
    top->rst = 0;
    top->PCsrc = 0;
    top->ImmOp = 0;

    // run sim for many clock cycles
    for (i=0; i< 10000; i++) {

        // dump vars into vcd file & toggle clock
        for (clk=0; clk<2; clk++) {
            tfp->dump(2*i+clk);
            top->clk = !top->clk;
            top->eval();
        }

        if(i == 5000) {
            top->rst = 1;
        }

        if(i == 1000) {
            top->rst = 0;
        }

        if(i == 1500) {
            top->PCsrc = 1;
        }

        if(i == 2000) {
            top->rst = 1;
        }

        if(i == 2001) {
            top->rst = 0;
            top->ImmOp = 4294967295;
        } else {
            top->ImmOp = rand() % RAND_MAX;
        }
        
        if(i == 2002) {
            top->PCsrc = 0;
        }

        // commenting out to keep build logs clean for now!
        //std::cout << i << " - PC: " << top->pc << std::endl;

        if (Verilated::gotFinish()) exit(0);
    }
}
