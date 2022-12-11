#!/bin/bash -e

./scripts/build.sh all

./scripts/run_cpu_asm_tests.sh

echo "Everything seems to work!"