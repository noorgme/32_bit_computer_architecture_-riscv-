#!/bin/bash -e

function test_module {
    
    module_name=$1
    echo "::: Testing module ${module_name} :::"
    rm -f ./src/${module_name}.vcd
    # run Verilator to translate Verilog into C++, including C++ testbench
    set -x
    verilator -Wall --cc --trace ./src/${module_name}.sv -I./src --exe ./src/${module_name}_tb.cpp

    # build C++ project via make automatically generated by Verilator
    # hide stdout because it makes it really hard to see what's going on, doesn't hide stderr
    make -j -C ./obj_dir/ -f V${module_name}.mk V${module_name} 1> /dev/null
    # run executable simulation file
    ./obj_dir/V${module_name}
    # run set +x without showing it in console. note: this zeroes exit status but we exit on
    # non-zero status (exit on any error) so doesn't affect this script

    
    { set +x; } 2>/dev/null
    echo "::: No errors testing ${module_name} :::"
    echo

    
}


# cleanup
rm -rf ./obj_dir

mkdir -p ./obj_dir

if [ $1 = "all" ];
then
    # find all .sv files and capture their module name (bit before .sv and after any directory names)
    for entry in $(find ./src -name '*.sv')
    do
        if [[ $entry =~ .*/(.*)\.sv ]];
        then
            module_name=${BASH_REMATCH[1]}
        fi
        test_module $module_name
    done
else
    # test against all command line arguments
    for var in "$@"
        do test_module $var
    done
fi

