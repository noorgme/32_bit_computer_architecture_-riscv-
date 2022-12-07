#!/bin/bash

# Credit: pykcheung (Prof. Cheung)

set -euo pipefail

pwd

echo "$1"

#od -v -An -t x1 "$1.bin" | tr -d "\n" | tr -d " " | awk '{$1=$1};1' > "$1.hex"

hexdump -ve '4/1 "%.2x" "\n"' "$1.bin" > "$1.hex"