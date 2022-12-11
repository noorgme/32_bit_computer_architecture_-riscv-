#!/bin/bash -e

for asmfile in $(find ./test/testcases -name '*.s')
do
    if [[ $asmfile =~ (.*\/.*)\.s ]];
    then
        memfile=${BASH_REMATCH[1]}
        memfile="$memfile.mem"
        

        ./scripts/assemble_test_riscv.sh $asmfile
        if cmp -s ./src/generated/registerdump.tmp.mem $memfile 
        then
        echo "Assembly testcase $asmfile passed!"
        echo
        else
        echo "Assembly testcase $asmfile failed, register state differences at end:"
        diff -Naur $memfile ./src/generated/registerdump.tmp.mem
        fi
         
    fi
done