main:
    addi a0, x0, 0b0
    addi a3, x0, 0b11111111
    addi a4, x0, 30 #delay

display_lights:
    jal ra, subroutine_add_light
    bne a0, a3, display_lights

addi a1, x0, 78
addi a2, x0, 0b0

count_down:
    addi a2, a2, 0b1
    bne a2, a1, count_down

addi a0, x0, 0b0

end:
    jal x0, end

subroutine_add_light:
    addi a5, x0, 0
    time_out:
        addi a5, a5, 1
        bne a5, a4, time_out
    sll a0, a0, 0b1
    addi a0, a0, 0b1
    ret