#!/bin/bash

# Credit: pykcheung (Prof. Cheung)

set -euo pipefail

pwd

echo "$1"

od -v -An -t x1 "$1.bin" | tr -s '\n' | awk '{$1=$1};1' > "$1.hex"