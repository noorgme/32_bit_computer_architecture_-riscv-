addi a0, x0, 0b0000
# a0 = 0
xori a0, a0, 0b1111
# a0 = 0b1111 = 0xf
addi a1, x0, 0b0101
# a1 = 0b0101 = 0x5
xori a4, a1, 0b1111
# a4 = a1 XOR 0b1111
# a4 = 0b1010 = 0xa
