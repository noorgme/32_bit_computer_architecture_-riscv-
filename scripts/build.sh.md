# How to use `build.sh`

`./build.sh <module_name> <module_name> ...`

For each provided <module_name>, verilates the file `rtl/<module_name>.sv`, then compiles and runs it against the testbench file `rtl/<module_name>_tb.cpp`. If `<module_name>` is `all` then recursively searches `rtl` for `.sv` files and verilates and tests them.

e.g. `./build.sh signextend controlunit` will verilate `rtl/signextend.sv` and `rtl/controlunit.sv` and test them against `rtl/signextend_tb.cpp` and `rtl/controlunit_tb.cpp` respectively. 