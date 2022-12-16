#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Valu.h"
#include "lib/testutils.h"
#include <cmath>
#include <iostream>

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
    long int sum, ltmpi, ltmpj, ltmp;
    int tmpi, tmpj;
    bool equiv;

    Verilated::commandArgs(argc, argv);
    Valu* top = new Valu;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    top->trace (tfp, 99);
    tfp->open ("alu.vcd");
    top->op1_i = 0;
    top->op2_i = 0;

    int time = 0;
    int len = 32;
    int run = 8;

    for(int i = 0; i < pow(2, run); i++){
        for(int j = 0; j < pow(2, run); j++){

            top->op1_i = i * pow(2, len-run);
            top->op2_i = j * pow(2, len-run);
            top->ctrl_i = 0;  

            //add

            time = time + 2;
            top->eval();
            tfp->dump(time);
            sum = (i + j) * pow(2, len-run);

            if(sum >= pow(2, 32)) {
                sum = sum - pow(2, 32);
            }

            assert_message(top->alu_o == sum, "the alu_o=%d, should have been %ld, mode %d", top->alu_o, sum, top->ctrl_i);

            //equivalent

            if(top->zero_o) {  
                assert_message(top->op1_i == top->op2_i, "op1_i =%d op2_i =%d they should be the same, mode %d", top->op1_i, top->op2_i, top->ctrl_i);
            } else {
                assert_message(top->op1_i != top->op2_i, "op1_i =%d op2_i =%d they should be the different, mode %d", top->op1_i, top->op2_i, top->ctrl_i);
            }

            //sub

            top->ctrl_i = 1;  
            time = time + 2;
            top->eval();
            tfp->dump(time);
            sum = (i - j) * pow(2, len-run);

            if(sum < 0) {
                sum = sum + pow(2, 32);
            }           

            assert_message(top->alu_o == sum, "the alu_o=%d, should have been %ld, mode %d", top->alu_o, sum, top->ctrl_i);

            //not equivalent

            if(top->zero_o) {
                assert_message(top->op1_i != top->op2_i, "op1_i =%d op2_i =%d they should be different, mode %d", top->op1_i, top->op2_i, top->ctrl_i);
            } else {
                assert_message(top->op1_i == top->op2_i, "op1_i =%d op2_i =%d they should be the same, mode %d", top->op1_i, top->op2_i, top->ctrl_i);
            }

            //and

            top->ctrl_i = 2;
            time = time + 2;
            top->eval();
            tfp->dump(time);
            sum = (i & j) * pow(2, len-run);

            assert_message(top->alu_o == sum, "the alu_o=%d, should have been %ld, mode %d", top->alu_o, sum, top->ctrl_i);

            //unsigned greater than or equal to

            assert_message(top->zero_o == (i >= j), "the alu_o=%d, should have been %d, mode %d, i = %d, j =%d", top->zero_o, i < j, top->ctrl_i, i, j);

            //or

            top->ctrl_i = 3;  
            time = time + 2;
            top->eval();
            tfp->dump(time);
            sum = (i | j) * pow(2, len-run);

            assert_message(top->alu_o == sum, "the alu_o=%d, should have been %ld, mode %d", top->alu_o, sum, top->ctrl_i);

            // signed less than

            if(i >= pow(2, run-1)) {
                tmpi = i - pow(2, run);
            } else {  
                tmpi = i;
            }

            if(j >= pow(2, run-1)) {
                tmpj = j - pow(2, run);
            } else {  
                tmpj = j;
            }

            assert_message(top->zero_o == (tmpi < tmpj), "the alu_o=%d, should have been %d, mode %d, i = %d, j =%d", top->zero_o, tmpi < tmpj, top->ctrl_i, tmpi, tmpj);
            
            //slt

            top->ctrl_i = 5;  
            time = time + 2;
            top->eval();
            tfp->dump(time);

            if(i < j) {
                sum = i;
            } else {
                sum = j;
            }

            sum = sum * pow(2, len-run);

            assert_message(top->alu_o == sum, "the alu_o=%d, should have been %ld, mode %d", top->alu_o, sum, top->ctrl_i);

            //unsigned less than

            assert_message(top->zero_o == (i < j), "the alu_o=%d, should have been %d, mode %d, i = %d, j =%d", top->zero_o, i < j, top->ctrl_i, i, j);

            //sll

            top->op1_i = i;
            top->op2_i = j;
            ltmpi = i;
            ltmpj = j;
            sum = ltmpi << ltmpj;
            ltmp = (pow(2, 32) - 1);
            sum = sum & ltmp;

            if(j > 32) sum = 0;

            top->ctrl_i = 6;
            time = time + 2;
            top->eval();
            equiv = (sum == top->alu_o);
            tfp->dump(time);

            //if(i == 1) std::cout << sum << " == " << top->alu_o << " = " << equiv << "  " << ltmpi << " " << ltmpj << "\n";

            assert_message(equiv == 1, "the alu_o=%d, should have been %ld, mode %d, i=%d, j=%d", top->alu_o, sum, top->ctrl_i, i, j);

            // signed greater than or equal to

            top->op1_i = i * pow(2, len-run);
            top->op2_i = j * pow(2, len-run);
            top->eval();

            if(i >= pow(2, run-1)) {
                tmpi = i - pow(2, run);
            } else {  
                tmpi = i;
            }

            if(j >= pow(2, run-1)) {
                tmpj = j - pow(2, run);
            } else {  
                tmpj = j;
            }

            assert_message(top->zero_o == (tmpi >= tmpj), "the alu_o=%d, should have been %d, mode %d, i = %d, j =%d", top->zero_o, tmpi >= tmpj, top->ctrl_i, tmpi, tmpj);

            //srl

            top->ctrl_i = 7;
            top->op1_i = i * pow(2, len-run);
            top->op2_i = j;
            ltmpi = i * pow(2, len-run);
            sum = ltmpi >> ltmpj;

            if (j>32) sum = 0;

            time = time + 2;
            top->eval();
            tfp->dump(time);

            assert_message(top->alu_o == sum, "the alu_o=%d, should have been %ld, mode %d, i=%d, j=%d", top->alu_o, sum, top->ctrl_i, i, j);

            //sra

            top->ctrl_i = 8;
            top->op1_i = i * pow(2, len-run);
            top->op2_i = j;
            ltmpi = i * pow(2, len-run);
            sum = ltmpi >> ltmpj;

            if (j>32) sum = 0;

            time = time + 2;
            top->eval();
            tfp->dump(time);
            
            assert_message(top->alu_o == (sum), "the alu_o=%d, should have been %d, mode %d, i=%d, j=%d", top->alu_o, i >> j, top->ctrl_i, i, j);
        }
    }
    // tfp->close(); 
    exit(0);
}
