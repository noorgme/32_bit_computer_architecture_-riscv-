#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vdatamemory.h"
#include <cmath>

int main (int argc, char **argv, char **env) {

    Verilated::commandArgs(argc, argv);
    Vdatamemory* top = new Vdatamemory;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    top->trace (tfp, 99);
    tfp->open ("datamemory.vcd");

    top->clk_i = 1;
    top->address_i = 0;
    top->writeData_i = 2882400152;
    top->writeEnable_i = 1;

    int count = 0;
    int clk;
    int i;

    for (i=0; i<100; i++) {
        for (clk=0; clk<2; clk++) {
            tfp->dump(2 * i + clk);
            top->clk_i = !top->clk_i;
            top->eval();
        }

        top->address_i = count;
        top->writeEnable_i = (i / 150) < 130 && i % 3 == 1;

        if(i % 6 == 0){ 
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