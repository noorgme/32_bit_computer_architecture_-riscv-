# Evidence of F1 light program running:

Can be recreated by running `./scripts/assemble_test_riscv.sh test/startlights.riscv.s` from top level directory.

## Before pressing button to set flag:
<img src="https://user-images.githubusercontent.com/8270128/208181679-59282c15-cf3e-4b35-83e1-c7016ac09107.png" height=400>

## Shortly after pressing button, register is loaded with cycle count until button press:
<img src="https://user-images.githubusercontent.com/8270128/208181731-91819a2b-eb34-439f-986c-313f0596942a.png" height=400>

## Countdown begins, lights count up on display
<img src="https://user-images.githubusercontent.com/8270128/208181749-05f9a645-3477-47a0-a73c-7b931116d55d.png" height=400>

## After all lights have been turned on, program waits for delay time calculated pseudorandomly from cycle count until button press
<img src="https://user-images.githubusercontent.com/8270128/208181755-d5a33895-9d86-4164-b8de-be2c4749b0c0.png" height=400>
