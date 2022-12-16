
main:
li a0, 0b1111111100000000 # Set a0 to make all bits 1 except bottom 8 bits which = 0, so all lights are off but we can change the lights by simply shifting right
addi x29, x29, 0b11111111 # Use x29 to store what the value of a0 will be once the lights have counted up to full (i.e. all lights are 1)
addi a2, x0, 0

# a0: light output
# a1: parameter to subroutine_wait_a1, number of cycles to wait
# tp: interrupt source
# a2: cycles before button pressed used for PRNG


wait_start:
addi a2, a2, 1
beq tp, x0, wait_start

chop_up:
slli a2, a2, 29 # chop off all but bottom 3 bits of delay timer, now a2 has max value of 15
srli a2, a2, 29

addi a1, x0, 10 # count up cycle count


count_lights_down:
call subroutine_wait_a1
srli a0, a0, 1 # shift lights over
bne a0, x29, count_lights_down # repeat

final_lightsout_random_wait:
addi a1, a2, 4 # copy a2 into a1 and add 4 for a lower bound
jal ra, subroutine_wait_a1 # wait for lights off
addi a0, x0, 0b0 # turn off lights

end:
jal x0, end

subroutine_wait_a1:
addi x28, a1, 0
addi x28, x28, 0
# multiply param by 2
dec_x28:
addi x28, x28, -1
bne x28, x0, dec_x28
ret