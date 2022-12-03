#!/bin/bash -e

# Assumes Ubuntu. If you don't use Ubuntu, I'm sure you're capable of following the instructions here https://github.com/riscv-collab/riscv-gnu-toolchain :)

echo "Installing risc-v gnu toolchain, fetching may take several hours on even slightly slow internet."
read -r -p "Installing the toolchain requires over 5GB of space, are you sure you want to continue? [y/N] " response
if [[ $response == "y" || $response == "Y" ]]
then
    sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev

    git clone https://github.com/riscv/riscv-gnu-toolchain
    cd riscv-gnu-toolchain

    ./configure --prefix=/opt/riscv --enable-multilib --enable-shared

    echo "To avoid extremely slow git fetches with no progress shown, will now clone gcc, glibc, binutils 'manually'"
    git clone https://gcc.gnu.org/git/gcc.git
    git clone https://sourceware.org/git/glibc.git
    git clone https://sourceware.org/git/binutils-gdb.git
    mv binutils-gdb/ binutils/

    make linux CXXFLAGS='-fPIC'
else
    echo "Aborting install..."
    exit 0
fi

echo "Done!"