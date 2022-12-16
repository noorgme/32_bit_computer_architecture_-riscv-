# Scripts
## `build.sh`

### Usage:
`./scripts/build.sh <module_name1> <module_name2> ...`

For each provided `<module_name>`, verilates the file `rtl/<module_name>.sv`, then compiles and runs it against the testbench file `rtl/<module_name>_tb.cpp`. If `<module_name>` is `all` then recursively searches `rtl` for `.sv` files and verilates and tests them.

### Examples:
`./scripts/build.sh signextend controlunit` will verilate `rtl/signextend.sv` and `rtl/controlunit.sv` and test them against `rtl/signextend_tb.cpp` and `rtl/controlunit_tb.cpp` respectively.

`./scripts/build.sh all` will run and testbench all `.sv` files in the `rtl` folder.

## `assemble_test_riscv.sh`
### Usage:
`./scripts/assemble_test_riscv.sh <path_to_assembly_file> [argument]`

Assembles the assembly file at the path given and executes it on the processor, using the riscv_tb.cpp testbench. Passes `argument` if provided when the executable is run, useful for passing a time per cycle to the testbench. Also disassembles the resulting machien code, and uses it to produce a mapping file `disasm_filter.txt` which can be loaded into gtkWave to view 

### Examples:

`./scripts/run_cpu_asm_tests.sh` ./test/samples/debug/testjumps.riscv.s` assembles and runs `testjumps.riscv.s` 

`./scripts/assemble_test_riscv.sh ./test/samples/starlights/patrickproposal.riscv.s 10` assembles and runs `patrickproposal.riscv.s` then executes the generated binary with the argument `10` which causes it to set a clock delay time of 10us.

## `run_cpu_asm_tests.sh`
### Usage:
`./scripts/run_cpu_asm_tests.sh`

Runs every assembly program in `./test/testcases`, then compares the final register state with the corresponding `.mem` file in the `testcases` directory, e.g. when running `./test/testcases/addi.riscv.s` it runs the program, then compares the register state with the one found in `./test/testcases/addi.riscv.mem` and if it does not match, outputs a warning after other tests finish.

