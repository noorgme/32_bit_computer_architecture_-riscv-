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
### `instructionmemory.sv` and `instructionmemory_tb.cpp`
#### Patrick Beart:
Dec 1: Wrote instruction memory and a testbench which checks that value changes on clock edge

### `signextend.sv` and `signextend_tb.cpp`
#### Patrick Beart:
Nov 30-Dec 1: Copied sign extension I wrote from lab 4 and added assert_message use
