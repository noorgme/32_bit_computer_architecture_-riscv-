# How to use `build.sh`

`./build.sh <module_name> <module_name> ...`

For each provided <module_name>, verilates the file `src/<module_name>.sv`, then compiles and runs it against the testbench file `src/<module_name>_tb.cpp`. If `<module_name>` is `all` then recursively searches `src` for `.sv` files and verilates and tests them.

e.g. `./build.sh signextend controlunit` will verilate `src/signextend.sv` and `src/controlunit.sv` and test them against `src/signextend_tb.cpp` and `src/controlunit_tb.cpp` respectively. 