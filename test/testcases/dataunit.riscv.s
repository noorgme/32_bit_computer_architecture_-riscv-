addi t1, zero, 0xAB
addi t2, zero, 0xCD 
addi t3, zero, 0xEF 
addi t4, zero, 0x89 
add s0, zero, 0x20 
sb t1, 3(s0)
sb t4, 0(s0)
sb t2, 2(s0)
sb t3, 1(s0)
lw a0, 0(s0)
addi s0, s0, 0x20
li a1, 0x5678

li a2, 0x1234

sh a1, 0(s0)
sh a2, 2(s0)
sh a1, 0(s0)
lw a0, 0(s0)
add s0, s0, s0
li a2, -0x112234 #0xFFEEDDCC

sw a2, 0(s0)
lhu a3, 2(s0)
lh a4, 0(s0)
lb a5, 2(s0)
lbu a6, 1(s0)
addi t1, zero, -0x1
addi s1, zero, 0x420
lw s1, 0(s1)
addi s0, zero, 0x20
lw a7, 0(s0)
li t2, -0x11111112

li t3, -0x22222223

li t4, -0x33333334

addi s0, zero, 0x20
sw t1, 0(s0)
sw t3, 8(s0)
sw t2, 4(s0)
sw t4, 12(s0)
lw s3, 0(s0)
lw s4, 4(s0)
lw s5, 8(s0)
lw s6, 12(s0)