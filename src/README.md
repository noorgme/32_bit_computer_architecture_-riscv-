# Who has done what
## `/src/lib/`
### `testutils.h`
#### Patrick Beart:
Nov 30: created the `assert_message(<equality>, <format string>, <format parameters>...)` macro to allow assertions in our testbench to only show messages if they fail.
## `/src/tb_resources/`
### `generate_magic_rom.py` (and `magic_rom_8x32.mem`)
#### Patrick Beart:
Dec 1: Wrote Python script (which created any .mem files) to generate pseudorandom (magic) .mem files in a non-repeating sequence so memories and ROMs can be tested and don't have to worry as much about coincidentally correct behaviour due to duplicated rom entries.
## `/src/`
### `controlunit.sv` and `controlunit_tb.cpp`
#### Patrick Beart:
Nov 30: Copied control unit I wrote over from Lab 4

#### Ollie Cosgrove:
Dec 12: Spotted bugs with the JAL and JALR instructions so changed `controlunit.sv` to fix the bugs. 
### `instructionmemory.sv` and `instructionmemory_tb.cpp`
#### Patrick Beart:
Dec 1: Wrote instruction memory and a testbench which checks that value changes on clock edge
#### Ollie Cosgrove:
Dec 11: Spoted that there was problems with jump instructions caused by the read on IR being sync and not async.

### `signextend.sv` and `signextend_tb.cpp`
#### Patrick Beart:
Nov 30-Dec 1: Copied sign extension I wrote from lab 4 and added assert_message use

#### Ollie Cosgrove:
Dec 11: Added an extend for LUI.
### `alu.sv` and `alu_tb.cpp`

#### Ollie Cosgrove:
Dec 2: Coppied over the code form LAB 4 <br>
Dec 3: Eddited `alu.sv` to include new functions and comparisons and wrote a testbench to test the ALU every test came back okay. 
### `regfile.sv` and `regfile_tb.cpp` 
#### Ollie Cosgrove:

Dec 2: Coppied over from LAB 4 along with `aluregfile.sv` and `aluregfile_tb.cpp` <br>
Dec 3: Changed `aluregfile_tb.cpp` to have a more solid test using fibonacci numbers as this would test all the functionality.

### `pc.sv` and `programCounter_tb.cpp`
#### Jackson Barlow:
Dec 3: Added single .sv file program counter and test file for it (untested), then updated test file to use correct verilated file
Dec 4: Corrected error in `pc.sv`, where test file expected to use extra output "count" (This is necessary for testing but will be removed for final use)
#### Ollie Cosgrove:
Dec 12: There was a problem with the PC as PC <= nextPC and PCplus4 <= PC + 4 where in a always_ff block this caused problems with executing add instructions as the PC was held for two cycles so changed this and fixed a combonational loop and for JAL the PC <= sext(Immop) when is should equal PC <= PC + sext(Immop).
### `datamemory.sv` and `datamemory_tb.cpp`
#### Jackson Barlow:
Dec 5: Created data memory sheet, with read/write ROM functionality. Input sigs (A = address, WD = write data, WE = write enable, clk), Output sigs (RD = read data). Untested currently, created `datamemory_tb.cpp`

Dec 6: Test data & results for datamemory, test data updated to include write & read test:

#### Ollie Cosgrove:

Dec 7: Changed `datamemory.sv` slightly so the first to bits are ignored and the size of the memory can be set with a parameter as it is not possible to have a data memory of 4Gb.
Dec 9: I overhauled `datamemory.sv` to include lb,lbu,lh,lhu,sb and sh I did to advoid a ridiculously long case statment I used a smaller case statment and bit shifters and added an input of funct3 to work out the output. 

### `riscv.sv` and `riscv_tb.cpp`
#### Noor Elsheikh:
Dec 8: Implemented JAL instruction with the following top-level changes
   - New Immediate format added for ImmSrc=0b11, outputting a 20-bit immediate for Jump target address
   - PCSrc extended to 2 bits
   - ALUControl extended to 4 bits
   - Branch internal control unit signal extended to 2 bits
   - ALUSrc extended to 2 bits
   - Added PC+4 output to Program counter

#### Ollie Cosgrove:
Dec 11: Increased the size of the MUX into WD3 of the `regfile.sv` to make LUI and JAL possible.

### `mainDecoder.sv`, `aluDecoder.sv`, `controlUnit.sv`
#### Noor Elsheikh
Dec 3: Pushed my top-level schematic from initial lab

Dec 4: Created first draft of control unit

Dec 5: Finalised aluDecoder and mainDecoder with respective gtkwave simulations and top-level tests, merged changes to main.
   



