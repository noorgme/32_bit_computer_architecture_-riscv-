#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vregfile.h"
#include <assert.h>

int main(int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);
    Vregfile * top = new Vregfile;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("regfile.vcd");
    top->clk = 0;
    top->we3 = 0;
    top->a1 = top->a2= top->a3 = top->wd3 = 0;
    for(int simcycle=1;simcycle<100;simcycle++){
        for(int i=0;i<2;i++){
            tfp->dump(2*simcycle+i);
            top->clk = !top->clk;
            top->eval();
        }
        top->a3 = simcycle%32;
        top->wd3 = simcycle*2 + 1;
        top->a1 = simcycle%32 + simcycle%2;
        top->a2 = (simcycle-2)%32;
        top->we3 = simcycle<32;
        top->eval();
    }
    tfp->close(); 
    exit(0);
}
