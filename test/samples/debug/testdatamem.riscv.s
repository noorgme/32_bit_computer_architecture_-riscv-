addi t1, zero, 0xAB
addi t2, zero, 0xCD
addi t3, zero, 0xEF
addi t4, zero, 0x89
addi s0, zero, 0x20
sb t1, 0(s0)
sb t2, 1(s0)
sb t3, 2(s0)
sb t4, 3(s0)
lw a0, 0(s0)
addi s0, s0, 0x20
sh a0, 2(s0)
sh a0, 0(s0)
lh a0, 2(s0)
lhu a0, 2(s0)
lbu a0, 3(s0)
sb s0, 3(s0)
lw a0, 0(s0) 
