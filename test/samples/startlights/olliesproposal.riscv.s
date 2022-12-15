addi s1, zero, 0x1 #place holder for 1
addi s8, zero, 0x9 #place holder for 9
main:
    addi a0, zero, 0x0 #restarts counter
    addi t2, zero, 0x0 #counter for lights
lights:
    addi t6, zero, 0xF #set delay can be changed
    jal ra, delay
    jal ra, output
    beq t2, s8, off
    jal lights
output:
    add t2, t2, s1 #adds 1 to t2
    sll t0, s1, t2 # 1 is shifted by t2 and stored in t0
    sub a0, t0, s1 # -1 from this and it is the output
    ret
delay:  
    sub t6, t6, s1 # counts down from the chosen delay
    bne t6, zero, delay
    ret
off:
    add a0, zero, zero #turnlights off
end:
    jal end

# will add random once the inputs are determined
    
    

    

    