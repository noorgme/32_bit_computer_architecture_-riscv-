# iac-riscv-cw-2
**Coursework for group 2, members Ollie Cosgrove, Patrick Beart, Noor Elsheikh and Jackson Barlow**

Evidence of program execution in [test](/test)

# Achieved:
## Verified completion of the single-cycle non-pipelined CPU in branch [main](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-2/tree/main)

## Pipelined CPU (no hazard detection) in branch [pipelining](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-2/tree/pipelining)

## CPU with memory cache and pipelining (no hazard detection) in branch [Cache](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-2/tree/Cache)

# Group Statement:

We have worked in collaboration over this project to develop a pipelined risc-v processor with cache memory that has been tested & verified to be working on the vbuddy [evidence of pipelining & cache](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-2/blob/f5a57a1a6a05de47d16070f08fb19691d319d37b/WhatsApp%20Video%202022-12-16%20at%2018.02.36.mp4). 
Together with this, we have created psuedo random number generation to control the delay time. Both these extra features work with this & we have a [final f1 program](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-2/blob/dc8953c36fe4941b822470e6c950334d051ba71c/test/samples/startlights/patrickprng.riscv.s). 
We feel that the project as a whole went well & we had a mostly working cpu from early on, making use of branches to add extra features without breaking main. 
Further [evidence](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-2/blob/4c0a8b197b3083ae039e424b2793e2dd9bf84c22/test/readme.md) for these can be seen in the 
[commit history](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-2/commits/main).


### Contributions:
Ollie: Register file, reformatting data memory for integration with caching, instruction memory, register file, caching

Noor: Control unit and subnmodules, decoder, help on other modules

Jackson: Data memory, program counter, vbuddy integration, some alu & instruction implementation, contributions on decoders

Patrick: Top level, sign extension, pipelining, all build scripts and most test programs
