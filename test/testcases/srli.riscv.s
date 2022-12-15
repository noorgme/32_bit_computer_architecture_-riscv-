addi a0, x0, 0b100
srli a0, a0, 2
# a0 should now = 0b1 = 0x1
addi a1, x0, 0b10010000
srli a1, a1, 3
# a1 should now = 0b10010 = 0x12
