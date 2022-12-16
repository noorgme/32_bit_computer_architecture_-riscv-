# Jackson Barlow

## Personal Statement

At the start of this project, I had a limited understanding of system-verilog & the risc-v architecture. Over the development of this project, I had less individual units & instead developed a widespread understanding of many of the individual units of the architecture that others had worked on. Some of the places where I felt I really learnt more was on my implementation of extra instructions & features to different units. This forced me to have a working knowledge of each component & all the components these worked with. This means I know have an in depth understanding of the intricacies of the Decode, ALU & Program Counter units.

## Contributions

- Program counter design & testing `programcounter.sv`, `programcounter_tb.cpp` general design of program counter driving the rest of the CPU, validation of this design & improvements to readability/understanding so it would be easy to extend later on
- Data memory creation for RAM use in CPU `datamemory.sv` which was very standard & not too interesting
- Addition of extra instructions `alu.sv`, `alu_tb.cpp`, `aluDecoder.sv`, `controlUnit.sv`, `riscv.sv` involved changing width of aluControl signal to include added instructions & implementation with branch instructions etc. 
- Bug fixes/validation of others pull requests & general tesbench creation/use
- General cleanup of code for obvious inputs & outputs

## Mistakes

- The most obvious mistake to me is the fact that we did not stick to a particular coding style at the beginning of the project. This meant that as the project went on, different units became very messy & hard to decipher as well as inconsistent with each other. This led to a large job at the end of the project for me where I had to clean up all the code which could have been avoided.
- Some aspects I worked on in the feature-add-srli branch should have ben implemented quicker, since a lot of changes had to be made over time, since things in main changed in the .sv files I was working on.
- General commenting & improvement in robustness of my code needed tweaking throughout the project, commits should have been tested more before pushing
- Mistake with some program counter components by merging them into the same sheet when they should have been left external for pipelining

## Design Decisions

- Chose different decoder outputs to aid with instructions.
- Chose input/output schema for the project
