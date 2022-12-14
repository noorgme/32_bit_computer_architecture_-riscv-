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
lhu a0, 2(s0)
lh a0, 0(s0)
lb a0, 2(s0)
lbu a0, 1(s0)