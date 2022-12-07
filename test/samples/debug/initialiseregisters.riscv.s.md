# initialiseregisters.riscv.s
## Program explanation

### `addi a0, x0, 0b01010101`

Type: Immediate (I-type)

Imm: `12'b000001010101`

rs1: x0 (`5'b00000`)

funct3: `3'b000`

rd: a0 = x10 (`5'b01010`)

Opcode: `7'b0010011`

Combined: `000001010101 00000 000 001010 0000011`

`32'b000001010101000000000010100000011`
= `32'h0AA00503`


`as` generates `1305503d`



= 000100110000 01010 101 000000 111101

Reversed:
= 3d500513

= 001111010101 00000 000 01010 0010011


This is correct, so we know we need to reverse hex groups.


= 00010011000001010101000000111101








addi a1, x0, 0b00110011
