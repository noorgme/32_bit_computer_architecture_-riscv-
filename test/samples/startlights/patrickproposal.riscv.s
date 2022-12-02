addi a0, a0, 0b11111000000 # Set a0 to make all bits 1 except bottom 5 bits which = 0, so all lights are off but 
addi x29, x29, 0b11111 # Use x29 to store what the value of a0 will be once the lights have counted up to full
addi a1, x0, 20 # count up cycle count

light_display_loop:
jal ra, subroutine_wait_a1
srli a0, a0, 1
bne a0, x29, light_display_loop

addi a1, x0, 50 # lights off cycle count
jal ra, subroutine_wait_a1
addi a0, x0, 0b0 # turn off lights

stuck:
jal x0, stuck

subroutine_wait_a1:
addi x28, a1, 0
dec_x28:
addi x28, x28, -1
bne x28, x0, dec_x28
jalr x0, ra, 0