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

  uint last_out = top->data_o;

  // run simulation for MAX_SIM_CYC clock cycles
  for (int i=0; i<255; i = i + 4) {
    top->addr_i = i;
    top->eval();
    last_out = top->data_o;
    tfp->dump (i * 2);

    assert_message(top->data_o == last_out, "Set addr to %d, before eval data_o should still be %d, but was %d", top->addr_i, last_out, top->data_o);

    i = i + 4;
    top->addr_i = i;
    top->eval();

    assert_message(top->data_o != last_out, "Set addr to %d, after eval data_o shouldn't still be %d", top->addr_i, last_out);
    tfp->dump(i * 2 + 1);
  }
  tfp->close(); 
  exit(0);
}