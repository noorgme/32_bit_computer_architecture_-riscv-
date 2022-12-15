li a0, 0x60
jal a1, shouldreach

shouldntreach:
li a0, 0xABADB01
deathspiral:
jal a1, deathspiral

shouldreach:
li a0, 0x600DB01
alivespiral:
jal a1, alivespiral
# if alivespiral is at pc=0x28, a1 should be set to pc address of unreachablespiral, i.e. 0x2c
unreachablespiral:
jal x4, unreachablespiral