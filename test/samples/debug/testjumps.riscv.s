start:
addi a1, x0, 0b100 # 1
addi a1, a1, 0b1 # 2
bne a1, a0, shouldreach # 3

shouldntreach:
#li a0, 0XBADBEEF1
addi a0, x0, 0xBA # 4
jal x0, shouldntreach # 5

shouldreach:
#li a0, 0XBEEFFEED
addi a0, x0, 0x60 # 6

addi a2, x0, 0b101 # 7

bne a2,a2, shouldreachagain # 8

shouldntreachagain:
#li a0, 0XBADBEEF2
addi a0, x0, 0xB2 # 9
jal x0, shouldntreachagain # 10

shouldreachagain:
#li a0, 0XF00DBEEF
addi a0, x0, 0xAC # 11
jal x0, shouldreachagain # 12