mkdir test/assemble/build

cp "$1" test/assemble/build/source.s

make -C test/assemble hexfile

cp test/assemble/build/source.s.hex src/tb_resources/programmemory.mem

./build.sh riscv