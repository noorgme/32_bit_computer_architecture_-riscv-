.text
.equ base_pdf, 0x100
.equ base_data, 0x10000
.equ max_count, 200
main:
    JAL     ra, init
    JAL     ra, build
forever: 
    JAL     ra, display
    J       forever

init:
    LI      a1, 0xff                #loopcount a1 = 255
_loop1:
    ADDI    a1, a1, -1            #decrement a1 - changed from addi a1, zero, -1 as that doesn't decrement it 
    SB      zero, base_pdf(a1)      #mem[base_pdf+a1] = 0
    BNE     a1, zero, _loop1         #repeat if a1 != 0
    RET                              #return to main

build:
    LI      a1, base_data
    LI      a2, 0
    LI      a3, base_pdf
    LI      a4, max_count
_loop2:
    ADD     a5, a1, a2
    LBU     t0, 0(a5)
    ADD     a6, t0, a3
    LBU     t1, 0(a6)
    ADDI    t1, t1, 1
    SB      t1, 0(a6)
    ADDI    a2, a2, 1
    BNE     t1, a4, _loop2
    RET

display:
    LI      a1, 0
    LI      a2, 255
_loop3:
    LBU     a0, base_pdf(a1)
    ADDI    a1, a1, 1
    BNE     a1, a2, _loop3
    RET

