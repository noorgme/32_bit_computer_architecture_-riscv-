#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Valu.h"
#include "lib/testutils.h"
#include <cmath>

#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
    long int sum;
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
    for(int i=0;i<pow(2,run);i++){
        for(int j=0;j<pow(2,run);j++){
            top->op1=i*pow(2,len-run);
            top->op2=j*pow(2,len-run);
            top->ctrl=0;  //add
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i+j)*pow(2,len-run);
            if(sum>=pow(2,32)-1){
                sum = sum - pow(2,32);
            }
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
            if(top->zero){  //equivelent
                assert_message(top->op1 == top->op2, "op1 =%d op2 =%d they should be the same, mode %d", top->op1,top->op2,top->ctrl);
            }
            else{
                assert_message(top->op1 != top->op2, "op1 =%d op2 =%d they should be the different, mode %d", top->op1,top->op2,top->ctrl);
            }
            top->ctrl=1;  //sub
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i-j)*pow(2,len-run);
            if(sum < 0){
                sum = sum + pow(2,32);
            }             
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
                            // singed greater than or equal to
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
            assert_message(top->zero == (tmpi>=tmpj), "the aluout=%d, should have been %d, mode %d, i = %d, j =%d", top->zero,tmpi<tmpj,top->ctrl,tmpi,tmpj);
            top->ctrl=2;  //and
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i&j)*pow(2,len-run);
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
                            // unsinged greater than or equal to
            assert_message(top->zero == (i>=j), "the aluout=%d, should have been %d, mode %d, i = %d, j =%d", top->zero,i<j,top->ctrl,i,j);
            top->ctrl=3;  //or
            time=time+2;
            top->eval();
            tfp->dump(time);
            sum = (i|j)*pow(2,len-run);
            assert_message(top->aluout == sum, "the aluout=%d, should have been %ld, mode %d", top->aluout,sum,top->ctrl);
                            // singed less than
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
            top->ctrl=5;  //slt
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
        }
    }
    // tfp->close(); 
    exit(0);
}
