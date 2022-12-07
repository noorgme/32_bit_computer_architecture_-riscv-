start:
addi a1, x0, 0b100
addi a1, a1, 0b1
bne a1, a0, shouldreach

shouldntreach:
li a0, 0XBADBEEF1

jal x0, shouldntreach

shouldreach:
li a0, 0XBEEFFEED

addi a2, x0, 0b101

bne a2,a2, shouldreachagain

shouldntreachagain:
li a0, 0XBADBEEF2
jal x0, shouldntreachagain

shouldreachagain:
li a0, 0XF00DBEEF
jal x0, shouldreachagain
