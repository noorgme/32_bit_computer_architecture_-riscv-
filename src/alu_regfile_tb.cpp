#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Valu_regfile.h"
#include <assert.h>

int main(int argc, char **argv, char **env) {
    Verilated::commandArgs(argc, argv);
    Valu_regfile * top = new Valu_regfile;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("alu_regfile.vcd");
    top->clk=0;
    top->aluctrl=0;
    for(int simcycle=1;simcycle<1000;simcycle++){
        for(int i=0;i<2;i++){
            tfp->dump(2*simcycle+i);
            top->clk = !top->clk;
            top->eval();
        }
        if(simcycle==111||simcycle==110){
            top->immop = 1;
        }else{
            top->immop = simcycle;
        }
        top->r[0] = ((simcycle-2)%32)*((simcycle>31)&&(simcycle!=110)&&(simcycle!=111));
        top->alusrc = (simcycle<32)||(simcycle==111)||(simcycle==110);
        top->regwrite = simcycle<32||simcycle>109;
        top->r[1] = (simcycle-1)%32;
        top->r[2] = (simcycle)%32;
        top->eval();
    }
    tfp->close(); 
    exit(0);
}
