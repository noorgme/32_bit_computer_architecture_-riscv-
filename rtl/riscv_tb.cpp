#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vriscv.h"
#include <unistd.h>
#include <iostream>

#include "lib/testutils.h"

#define MAX_SIM_CYC 1000000

void draw_lights(Vriscv* top) {
  
  int lights = top->dataOut_o;
  std::cout << std::endl << std::endl << std::endl;

  for (int lindex = 0; lindex<5; lindex++) {
    bool thislight = (lights >> lindex) & 1;
    if (thislight) {
      std::cout << "X";
    } else {
      std::cout << "O";
    };
  }
  std::cout << std::endl;
}

int main(int argc, char **argv, char **env) {

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vriscv* top = new Vriscv;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("riscv.vcd");
 
  uint sleeptime = 0;
  
  if (argc > 1) {
    sleeptime = atoi(argv[1]);
    std::cout << "Loading simulation with cycle time of " << sleeptime << "us..." << std::endl;
  };
  top->clk_i = 0;
  top->rst_i = 0;

  int count = 0;

  top->eval();
  tfp->dump(count++);
  count++;

  top->rst_i = 1;

  top->eval();
  tfp->dump(count);
  count++;

  top->rst_i = 0;
  
  top->eval();
  tfp->dump(count);
  count++;

  while (count < 10000) {
    usleep(sleeptime);
    count++;
    top->clk_i = !top->clk_i;
    top->eval();
    tfp->dump(count);
    if (sleeptime>0) {
      draw_lights(top);
      if (top->dataOut_o == 0) {
        exit(0);
      }
    };
    if (Verilated::gotFinish()) exit(0);
  };

  tfp->close();
  top->final();
  exit(0);
}