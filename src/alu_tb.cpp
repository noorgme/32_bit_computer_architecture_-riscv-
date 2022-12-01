#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Valu.h"
#include <assert.h>
#include <cmath>

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
    long int sum;
    Verilated::commandArgs(argc, argv);
    Valu * top = new Valu;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("alu.vcd");
    top->ctrl = 0;
    top->op[0] = 0;
    top->op[1] = 0;
    int time =1;
    int len = 32;
    int run = 8;
    for(int i=0;i<pow(2,run);i++){
        for(int j=0;j<pow(2,run);j++){
            time++;
            tfp->dump(time);
            top->op[0]=i*pow(2,len-run);
            top->op[1]=j*pow(2,len-run);
            top->eval();
            sum = (i+j)*pow(2,len-run);
            if(sum>=pow(2,32)-1){
                sum = sum - pow(2,32);
            }
            assert(sum == top->aluout);
            if(top->eq){
                assert(top->op[0] == top->op[1]);
            }
        }
    }
    tfp->close(); 
    exit(0);
}
