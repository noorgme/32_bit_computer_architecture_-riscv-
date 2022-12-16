

main:
addi a0, a0, 0b1111100000 # Set a0 to make all bits 1 except bottom 6 bits which = 0, so all lights are off but we can change the lights by simply shifting right
addi x29, x29, 0b11111 # Use x29 to store what the value of a0 will be once the lights have counted up to full (i.e. all lights are 1)
addi a1, x0, 100 # count up cycle count

light_display_loop:
jal ra, subroutine_wait_a1
srli a0, a0, 1
bne a0, x29, light_display_loop

addi a1, x0, 200 # lights off cycle count
jal ra, subroutine_wait_a1
addi a0, x0, 0b0 # turn off lights

end:
jal x0, end

subroutine_wait_a1:
addi x28, a1, 0
dec_x28:
addi x28, x28, -1
bne x28, x0, dec_x28
jalr x0, ra, 0