#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vinstructionmemory.h"

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
  int i;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vinstructionmemory* top = new Vinstructionmemory;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("instructionmemory.vcd");
 
  // initialize simulation inputs
  top->clk_i= 1;
  // run simulation for MAX_SIM_CYC clock cycles
  for (i=0; i<MAX_SIM_CYC; i++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*i+tick);
      top->clk_i = !top->clk_i;
      top->eval ();
    }
  }

  tfp->close(); 
  exit(0);
}