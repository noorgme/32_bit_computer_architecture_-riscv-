# Ollie Cosgrove

## Mistakes and learning:
I made lots of mistakes along the way of inefficient data manipulation, wasting lots of code, time and brain power. if I was to somthing like this again I would spend more time researching into different functions and data types. I have come a long way with my understanding of system verilog, and I have a more detailed understanding of the RISV32I microarchitecture.

## Contribution, Challenges and design decisons:

##### If too long read section on `cache.sv`

### Making `alu.sv`, `regfile.sv` and related testbenches
I copied over my ALU and Regfile these needed little changing I added some more functionality to ALU for readability I used enumeration and created there associated, for the tests I varied inputs in the upper limits and compared the output to expected values as this Is where I foresaw the most errors coming from.
I added some error checking to the alu testbench for srl and sll as there where some problems with it.

commit 8414a10cb26054be90d1389110ba2ea4eae8237c
commit 93d05305d496d8812d99d7231dfaee655f1ab86a
commit 439111ef06cb491ab934a4d199ea61ced59dce42
### Changing `datamemory.sv` and `datacontroller.sv`
I added, a parameter to limit the size of memory and remove the first two bits of address, to `datamemory.sv`. And changed the test bench.
Added the byte and halve instructions, for this I worked out how much the data needed to be shifted by to get the wanted data in the first byte or halve. For write I swap the data for data_in then shifted it back. Then write to memory. For the reading and writing I do the same shift but output the first half or byte, I wrote some assembly to check this all worked checking the waveform.

commit 86e12890a27c223a097ac1506256aedcb71135f1
commit ea404681357108db1ff81441e495f8d11c33cb86

### Adding LUI
For LUI I needed to add a new case to `signextend.sv` and some logic in the riscv and decoder sheets to decide what the input to the register are.

commit ea404681357108db1ff81441e495f8d11c33cb86

### Making `memoryunit.sv` and related changes
As a precursor to making `cache.sv` I split up the data memory into two sub modules the memory and a module to add byte addressability. I edited `datacontroller.sv` so instead of shifting, I do bit rotations this saved some lines of code this was done as I was trying to find a way to implement caching. `datamemory.sv` was made loadable.

commit 0ed00e229b6d08d166cb4c56c632fb15be51c344
### Creating `olliesproposal.riscv.s`
I implemented my own F1 code however there where errors initially, the challenge was finding a good way of creating the output, to do this I had a counter that counts up to 8, then 1 is shifted left by this, the result is equivalent to 2^count then I subtract one from this to create the desired output. There is also a delay subroutine which counts down from a given number to add delay.

commit a7d1de47eeda9754d6f88a2ecc116d98e655d188
commit 92c32f95d0128074c758a3fa59b8dd4ff8d190a6

### Making `cache.sv ` and related changes

For my design, I wanted block size and cache size to be parameters, and I wanted a design for spatial locality and chose a write through cache for simplicity. Initially I started on the problem of sending blocks of undefined size from `datamemory.sv` to `cache.sv`, I came up with the idea to use a for loop to build the blocks to be sent. For the cache I had two major problems writing and reading to memory and writing and reading cache. While reading https://www.chipverify.com/systemverilog/ I realized that 2’D packed arrays would be the way to go about this. I would also need a write and read enable to tell if the input address is meaningful, as to not fetch unnecessary data from the data memory, I created a hit flag which would check the V flag was 1 and the tag matched the address, If so then the data in cache is used, if not the address is sent to the data memory and the receved data is used and stored in cache. For processing the blocks I made two sub modules one for writing (`blockwrite.sv`) and one for reading (`blockread.sv`).
I encountered a problem where the data supplied to the data memory from the cache was wrong at the positive edge of the clock, to get around this I made `datamemory.sv` write on the negative edge of the clock.
Later on I got rid of `blockread.sv`, the `blockwrite.sv` was useful though so that was kept
Using the 2'D packed arrays approach I simplified `datacontroller.sv` from the bit rotators. 
To get rid of the for loop as I saw it as suboptimal `datamemory.sv` was changed to storing blocks, and used the blockwrite module for writing to it. For reading data correctly from files I manipulate the data in, from the files, so it gets translated properly.

commit 778232c3ce2d9a132ae6e5718f2bde762cc484de
commit 5ea351476ddf0a0fe2bf9c0ca295565a72ee2886
commit 5f3ac5f255e51ec1539e96a8a9f9fbb66c7115db
commit 1016244715695996351f7f159e0fa920bc8ae43f
commit 79b6c4100b935ba13ca05d63ecdc1c59d4b8af31



