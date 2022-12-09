#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vdatamemory.h"
#include <cmath>

int main (int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);

    Vdatamemory * top = new Vdatamemory;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("datamemory.vcd");

    top->clk = 1;
    top->address = 0;
    top->write_data = 2882400152;
    top->write_enable = 1;
    top->DATAMEMControl = 0;
    int count = 0;
    int clk;
    int i;

    for (i=0; i<100;i++) {
        for (clk=0; clk<2; clk++) {
            tfp->dump(2*i+clk);
            top->clk = !top->clk;
            top->eval();
        }
        top->DATAMEMControl = i/100;
        top->address = count;
        top->write_enable = (i/150)<130 && i%3 == 1;
        if(i%6==0){ 
            count++;
        }
        // if (i == 40) {
        //     top->write_enable = 1;
        //     count = 0;
        // } else if (i == 60) {
        //     top->write_enable = 0;
        //     count = 0;
        // } else if (i == 70) {
        //     top->write_enable = 1;
        //     count = 0;
        // }
        top->eval();
        if (Verilated::gotFinish()) exit(0);
    }
    tfp->close();
    exit(0);
}