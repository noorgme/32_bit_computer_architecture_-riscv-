#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsignextend.h"
#include <iostream>

#include <cmath>

#include "lib/testutils.h"

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
    long int sum;

    Verilated::commandArgs(argc, argv);
    Vsignextend * top = new Vsignextend;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    top->trace (tfp, 99);
    tfp->open ("signextend.vcd");

    top->toExtend_i = 0;
    top->immSrc_i = 0; // straightforward sign extension

    for(int i = 0; i < 4096; i++){
        // shift into the 31:20 region offset by bottom opcode bits
        top->toExtend_i = i << 13;
        top->eval();
       

        // Sign extending 12 bits up to 32 bits. If bit 12 of imm is high, bitwise OR with 1s in every position above 12 otherwise with 0
        uint signExtended = i | ((i & 0x800) ? 0xFFFFFF000 : 0);
        assert_message (top->immOp_o == signExtended, "With immsrc=%d: testing setting imm=%d... after eval immop=%d, calculated should have been %d",top->immSrc_i, i, top->immOp_o, signExtended);
        
    };

    top->immSrc_i = 1; // S-type (31:25 then 11:7) sign extension

    for(int i = 0; i < 4096; i++){
        // mask upper 7 bits and shift into the 31:25 region, then mask lower 5 bits and shift into the 11:7 region  (offset by bottom opcode bits)
        top->toExtend_i = ((i & 0xfe0) << 13) | ((i & 0x1f) << 0);
        top->eval();
       
        // Sign extending 12 bits up to 32 bits. If bit 12 of imm is high, bitwise OR with 1s in every position above 12 otherwise with 0
        uint signExtended = i | ((i & 0x800) ? 0xFFFFFF000 : 0);
        assert_message (top->immOp_o == signExtended, "With immsrc=%d: testing setting imm=%d... after eval immop=%d, calculated should have been %d", top->immSrc_i, i, top->immOp_o, signExtended);
        
    }

    top->immSrc_i = 2; // B-type (31 signextended, then 7 then 30:25 then 11:8 then a 0 digit) sign extension
    for(int i=0;i<8192;i+=2){
        // 
        top->toExtend_i = ((i & (0x1 << 12)) << 12 ) | ((i & (0x1 << 11)) >> 11) | ((i & 0x7e0) << 13) | ((i & 0x1e));
        top->eval();
       
        // Sign extending 12 bits up to 32 bits. If bit 12 of imm is high, bitwise OR with 1s in every position above 12 otherwise with 0
        long unsigned int signExtended = i | ((i & 0x1000) ? 0xFFFFF000 : 0);
        assert_message (top->immOp_o == signExtended, "With immsrc=%d: testing setting i=%d,imm=%d... after eval immop=%u, calculated should have been %lu", top->immSrc_i, i, top->toExtend_i, top->immOp_o, signExtended);
        
    }
    tfp->close(); 
    exit(0);
}
