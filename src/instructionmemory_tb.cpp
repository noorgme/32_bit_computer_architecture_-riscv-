#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vinstructionmemory.h"

#include "lib/testutils.h"

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vinstructionmemory* top = new Vinstructionmemory;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("instructionmemory.vcd");
 
  // initialize simulation inputs
  top->clk_i= 0;
  uint last_out = top->dout_o;
  // run simulation for MAX_SIM_CYC clock cycles
  for (int i=0; i<255; i=i+4) {
    top->addr_i = i;
    top->eval();
    tfp->dump (i*3);
    assert_message(top->dout_o == last_out, "Set addr to %d, before clocking dout_o should still be %d, but was %d", top->addr_i, last_out, top->dout_o);
    top->clk_i = 1;
    top->eval();
    tfp->dump (i*3+1);
    assert_message(top->dout_o != last_out, "Set addr to %d, after clocking dout_o should no longer be %d, but was %d", top->addr_i, last_out, top->dout_o);
    last_out = top->dout_o;
    top->clk_i = 0;
    top->eval ();
    tfp->dump (i*3+2);
  }

  tfp->close(); 
  exit(0);
}