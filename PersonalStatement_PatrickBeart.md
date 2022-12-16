# Patrick Beart
**Personal Statement**

This project took me from having some limited knowledge of assembly programming and awareness of the process by which a microarchitecture might execute machine code, to being aware of the precise architecture considerations involved in programming (most of) the RISCV-I instruction set. Particularly through debugging, I have gained an awareness of precise implementation details likely to be involved in microarchitecture for all instructions implemented by our CPU.

## Contributions
- Top-level design ```riscv.sv```, responsibility for instruction memory ```instructionmemory.sv``` and design and implementation of pipelining.
- Bug fixes/validating (as did all other group members), easiest to see from commit history but e.g. fixing readmemh incorrectly loading memory by stripping spaces, changing memory to prevent writing to x0...
- All build scripts  in ```./scripts``` (some of those in ```./scripts/assemble``` build on Prof. Cheung's scripts), as well as a script to automatically generate disassembly and format it so that it can be loaded into gtkWave and show instructions as assembly, and assert helper macro in ```/src/lib```.
- Test programs in ```/test/testcases``` and most in ```/test/samples``` which helped spot several bugs.

## Mistakes/would do differently
- It would have been significantly easier and simpler to implement pipelining if we had achieved full separation of concerns between modules from the start (i.e. ensuring each module takes only the inputs it needs and ideally avoid multiple stages of combinatoric logic), as this would have allowed pipelining to simply add clocked delays between each signal as shown on the diagram: I decided that we did not have enough time left to rewrite modules in a separated way so I instead decided that it was preferable to add clocked behaviour to the control unit so it could delay its internal signals

## Design Decisions
Consequential design decisions I made during the project:
- Early on, I decided to create a script (```build.sh```) to automate compiling and testing a module against its testbench: I also began writing testbenches which would raise errors if the design's behaviour was not as expected, and wrote an assert-with-error-message macro (in ```lib```) for the team to use, to make testing easier. This gave us much better visibility into which parts of our designs worked and provided another format to specify the design in (CPP vs SystemVerilog) as a sanity check.
- Building on this, I then wrote an additional ```assemble_test_riscv.sh``` script which uses a modified version of Prof. Cheung's Makefile and script to build and automatically run the provided assembly file, and then wrote a script ```run_cpu_asm_tests.sh``` which iterates over every ```.s``` file in the ```./test/testcases``` directory, assembles and runs it, and then checks that the dumped registers are the same at program finish as they are in the corresponding testcase file: this allowed us to very easily check which features were and weren't implemented correctly, and implement regression testing where we could verify that a change had not broken any instructions.
