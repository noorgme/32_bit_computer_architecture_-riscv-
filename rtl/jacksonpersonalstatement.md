# Personal Statement

## Program Counter `programcounter.sv`, `programcounter_tb.cpp`

### Commit: 3639eb3485f9425106e42035789dea17e5b08c2b

Created a PC counter that incremented by 4 every cycle, or reset to 0 on rst high, or pc + imm for jumps, on the positive edge of each clock

### Commit: e86bbefceb05fe490c8c06c07958e2e628c21ef8

Created a PC test that checked all the different input/output signals were performing the correct function. Set rst high/low, tested jumps with random immOp

### Commit: da54e17e530b45f658adbeac9634002f5a478654

Renamed PC counter

### Commit: 2f7e6efd612171e9d6c972be14d55ae2d7d30080

Repaired PC with better formatting, intermediate count signal for easier testing

### Commit: 7dbafae4ceb6e86fd271dfb0537c7875b8b537a6

Changed PC to change on negative edge of clock, so it always has the next value ready for the start of each cycle

## Data Memory `datamemory.sv`, `datamemory_tb.cpp`

### Commit: ce456069a898201d8214f4a81c50d28c5fc4cae8

Created data memory unit that reads out corresponding value when WE is high

### Commit: dcbc484c6bf524d19fd55041fed726c345abfe11

Created not working testbench for datamemory

### Commit: 986c4809606fe4c696bd302e8e4250dd44d2752e

Made a mistake by not making inputs & outputs very clear so changed the names for these to make the code more legible. Also changed order of lines in `datamemory.sv`, though this will not change the order of operations, since all use blocking assignment anyway. Fixed testbench error where .vcd file wasn't generating correctly since never closed, as well as starting clk high instead of low in assignment.

Tested the Data here: 

|RAM Location|DataStored|DataRead (next cycle)|
| --- | --- | --- |
|1|1CB|1CB|
|2|1CA|1CA|
|...|...|...|
|12|1BA|1BA|
|13|1B9|1B9|

We then continue to read this again with write enable = 1, and if the output from memory is still the value before it is changed, then the datamemory component is working correctly

|RAM Location|DataRead (next cycle)|
| --- | --- |
|1|1CB|
|2|1CA|
|...|...|
|12|1BA|
|13|1B9|

Here, we can see that everything is working as expected & `datamemory.sv` is correct

### Commit: 2765d2be4af4b76dc62b583e9a9b5e24202b60e2

Added all the feature-data-memory stuff to main & merged in.

## ALU `alu.sv`, `aluDecoder.sv`, `controlUnit.sv`, `riscv.sv`, `alu_tb.cpp`

### Commit: 21f8437d8d3f3843dd2b373693a0e6359c7c1638

Added untested SRL feature to ALU, using unused ALUCtrl & extra case statement

### Commit: eee10c85fb50e0ef78d1eef608c788f11bddb67d

Merged in new main changes & added SLL & SRA functionality as well as converting ALUCtrl to 4 bits for the extra instructions necessary.

### Commit: b6e4c428ca56bac99926f3925af7f91a63e935d0

Merged in changes from main to add JALR functionality, so that my instructions dont conflict with others

### Commit: e1c16f46bfc24163898eb8fd6acc374ff559e7de

Added XOR functionality to ALU as well as zero flag condition

### Commit: ecfff2b1d8eebd6262e328351eeb97fa2b71b796

Merged main into ALU & changed features/bit codes of the ALU to allow for Branch instructions

### Commit: e16181e508c458cede670d4cfa8e5541bd35ce93

Updated alu_tb.cpp to include tests for new instructions, as well as fixing old tests, some still not working