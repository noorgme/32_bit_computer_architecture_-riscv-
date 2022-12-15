li a0, 0x60
jal x0, shouldreach

shouldntreach:
li a0, 0xABADB01
deathspiral:
jal x0, deathspiral

shouldreach:
li a0, 0x600DB01
alivespiral:
jal x0, alivespiral
