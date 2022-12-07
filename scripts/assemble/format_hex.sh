#!/bin/bash

# Credit: pykcheung (Prof. Cheung)

set -euo pipefail

pwd

echo "$1"

#od -v -An -t x1 "$1.bin" | tr -d "\n" | tr -d " " | awk '{$1=$1};1' > "$1.hex"

od -v -An -t x1 "$1.bin" | tr -s '\n' | awk '{$1=$1};1' > "$1_od.hex"

# reverse .bin byte order, then hexdump, then reverse lines so only bytes within lines are reversed (fix endianness)
< "$1.bin" xxd -p -c1 | tac | xxd -p -r | hexdump -ve '4/1 "%.2x" "\n"' | tac > "$1.hex"