#!/bin/bash -e

#relpath=$(find ./test/samples/ -iname $1.riscv.s)

relpath=$1
 
if [[ ! -f "$relpath" ]]
then
    echo "Error: no such file $1, exiting"
    exit 1
fi

rm -rf ./scripts/assemble/.build 2> /dev/null

mkdir ./scripts/assemble/.build

cp "$relpath" ./scripts/assemble/.build/source.s

make -C ./scripts/assemble hexfile

if [[ ! -d "./rtl/generated" ]] 
then
    mkdir ./rtl/generated
fi

cp ./scripts/assemble/.build/source.s.hex ./rtl/generated/instructionmemory.tmp.mem

./scripts/build.sh riscv
