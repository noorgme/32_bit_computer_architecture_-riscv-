li a0, 0x6000
call func



shouldreach:
li a0, 0x600DB01
alivespiral:
jal a7, alivespiral

func:
li a0, 0xca11ed
addi a0, a0, 0x1
ret


shouldntreach:
li a0, 0xDABADB01
deathspiral:
jal a7, deathspiral