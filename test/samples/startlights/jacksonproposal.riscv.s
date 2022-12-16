subroutine_add_light:
sll a0, a0, 0b1
addi a0, a0, 0b1

main:
addi a0, x0, 0b0
addi a3, x0, 0b11111111
addi a4, x0, 15 #delay

display_lights:
jal ra, subroutine_add_light
bne a0, x29, display_lights

addi a1, x0, 78
addi a2, x0, 0b0

count_down:
addi a2, a2, 0b1
bne a2, a1, count_down

addi a0, x0, 0b0

end:
jal x0, end