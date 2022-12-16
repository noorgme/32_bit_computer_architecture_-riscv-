#!/bin/bash


errors=""

for asmfile in $(find ./test/testcases -name '*.s')
do
    if [[ $asmfile =~ (.*\/.*)\.s ]];
    then
        memfile=${BASH_REMATCH[1]}
        memfile="$memfile.mem"
        

        ./scripts/assemble_test_riscv.sh $asmfile
        if cmp -s ./rtl/generated/registerdump.tmp.mem $memfile 
        then
        echo "Assembly testcase $asmfile passed!"
        echo
        else
        echo "Assembly testcase $asmfile failed, register state differences at end:"
        errors="${errors}Assembly testcase $asmfile failed!\n"
        diff -Naur $memfile ./rtl/generated/registerdump.tmp.mem
        fi
         
    fi
done

if [ ! -z "$errors" ]
then
    echo ""
    echo "##### Errors encountered when testing assembly execution: #####"
    echo -e "$errors"
else
    echo -e "\nNo errors encountered testing assembly execution."
fi