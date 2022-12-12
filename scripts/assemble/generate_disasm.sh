#!/bin/bash -e

riscv64-unknown-elf-objdump --disassemble-all --target=binary \
-Mno-aliases --wide --disassemble-zeroes \
--architecture=riscv:rv32 ./.build/source.s.bin > ./.build/source.disasm
out=""
while read line
do
    # if [[ $line =~ "([0-9a-fA-F]{8})( *)(.*)" ]]
    if [[ $line =~ ([0-9a-fA-F]{8})( *)(.*) ]]
    then
        hex=${BASH_REMATCH[1]}
        instr=${BASH_REMATCH[3]}
        addr=${BASH_REMATCH}
        tout="${hex} ${instr}"
        tout=`echo $tout | tr -ds \' \'`
        out+="$tout"
        out+=$'\n'
    fi
done < ./.build/source.disasm 

echo "$out" > ../../disasm_filter.txt