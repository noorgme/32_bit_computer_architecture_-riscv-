start:
addi a0, x0, 0b1111010101
srli a1, a0, 0b110
bne a1, a0, shouldreach

shouldntreach:

shouldreach:
