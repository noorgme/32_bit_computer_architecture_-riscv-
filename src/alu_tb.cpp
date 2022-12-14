#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Valu.h"
#include "lib/testutils.h"
#include <cmath>
#include <iostream>

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
    long int sum,ltmpi,ltmpj,ltmp;
    int tmpi,tmpj;
    Verilated::commandArgs(argc, argv);
    Valu * top = new Valu;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("alu.vcd");
    top->op1 = 0;
    top->op2 = 0;
    int time =0;
    int len = 32;
    int run = 8;
    bool equiv;
    for(int i=0;i<pow(2,run);i++){
        for(int j=0;j<pow(2,run);j++){
            top->op1=i*pow(2,len-run);
            top->op2=j*pow(2,len-run);
            top->ctrl=0;  
            //add
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i+j)*pow(2,len-run);
            if(sum>=pow(2,32)){
                sum = sum - pow(2,32);
            }
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
            //equivalent
            if(top->zero){  
                assert_message(top->op1 == top->op2, "op1 =%d op2 =%d they should be the same, mode %d", top->op1,top->op2,top->ctrl);
            }
            else{
                assert_message(top->op1 != top->op2, "op1 =%d op2 =%d they should be the different, mode %d", top->op1,top->op2,top->ctrl);
            }
            //sub
            top->ctrl=1;  
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i-j)*pow(2,len-run);
            if(sum < 0){
                sum = sum + pow(2,32);
            }             
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
            //not equivalent
            if(top->zero){
                assert_message(top->op1 != top->op2, "op1 =%d op2 =%d they should be different, mode %d", top->op1, top->op2, top->ctrl);
            } else {
                assert_message(top->op1 == top->op2, "op1 =%d op2 =%d they should be the same, mode %d", top->op1, top->op2, top->ctrl);
            }
            //and
            top->ctrl=2;
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i&j)*pow(2,len-run);
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
            //unsinged greater than or equal to
            assert_message(top->zero == (i>=j), "the aluout=%d, should have been %d, mode %d, i = %d, j =%d", top->zero,i<j,top->ctrl,i,j);
            //or
            top->ctrl=3;  
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i|j)*pow(2,len-run);
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
            // signed less than
            if(i >= pow(2,run-1)){
                tmpi = i - pow(2,run);
            }else{  
                tmpi = i;
            }
            if(j >= pow(2,run-1)){
                tmpj = j - pow(2,run);
            }else{  
                tmpj = j;
            }
            assert_message(top->zero == (tmpi<tmpj), "the aluout=%d, should have been %d, mode %d, i = %d, j =%d", top->zero,tmpi<tmpj,top->ctrl,tmpi,tmpj);
            //slt
            top->ctrl=5;  
            time=time+2;
            top->eval();
            tfp->dump(time);
            if(i<j){
                sum = i;
            }else{
                sum = j;
            }
            sum = sum*pow(2,len-run);
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
            //unsigned less than
            assert_message(top->zero == (i<j), "the aluout=%d, should have been %d, mode %d, i = %d, j =%d", top->zero,i<j,top->ctrl,i,j);
            //sll
            top->op1 = i;
            top->op2 = j;
            ltmpi = i;
            ltmpj = j;
            sum = ltmpi<<ltmpj;
            ltmp = (pow(2,32)-1);
            sum = sum & ltmp;
            if(j>32) sum = 0;
            top->ctrl = 6;
            time = time + 2;
            top->eval();
            equiv = sum == top->aluout;
            //if(i==1) std::cout<<sum<<" == "<<top->aluout<<" = "<<equiv<<"  "<<ltmpi<<" "<<ltmpj<<"\n";
            tfp->dump(time);
            assert_message(equiv == 1, "the aluout=%d, should have been %ld, mode %d, i=%d, j=%d", top->aluout,sum,top->ctrl,i,j);
            // singed greater than or equal to
            top->op1=i*pow(2,len-run);
            top->op2=j*pow(2,len-run);
            top->eval();
            if(i >= pow(2,run-1)){
                tmpi = i - pow(2,run);
            }else{  
                tmpi = i;
            }
            if(j >= pow(2,run-1)){
                tmpj = j - pow(2,run);
            }else{  
                tmpj = j;
            }
            assert_message(top->zero == (tmpi>=tmpj), "the aluout=%d, should have been %d, mode %d, i = %d, j =%d", top->zero,tmpi>=tmpj,top->ctrl,tmpi,tmpj);
            //srl
            top->ctrl = 7;
            top->op1 = i*pow(2,len-run);
            top->op2 = j;
            ltmpi = i*pow(2,len-run);
            sum = ltmpi>>ltmpj;
            if (j>32) sum = 0;
            time = time + 2;
            top->eval();
            tfp->dump(time);
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d, i=%d, j=%d", top->aluout,sum,top->ctrl,i,j);
            //sra
            top->ctrl = 8;
            top->op1 = i*pow(2,len-run);
            top->op2 = j;
            ltmpi = i*pow(2,len-run);
            sum = ltmpi>>ltmpj;
            if (j>32) sum = 0;
            time = time + 2;
            top->eval();
            tfp->dump(time);
            assert_message(top->aluout == (sum), "the aluout=%d, should have been %d, mode %d, i=%d, j=%d", top->aluout,i>>j,top->ctrl,i,j);
        }
    }
    // tfp->close(); 
    exit(0);
}
