# Day 1: 2-to-1 MUX Verification

This document details the successful verification of the 8-bit 2-to-1 multiplexer designed in `day1_mux.vhd`. The simulation was executed using the testbench `day1_mux_tb.vhd`, and the resulting waveform (`day1_waveform.png`) confirms the component's correct logical behavior.

![Simulation Waveform for Day 1 MUX](Day1_waveform.png)

## Simulation Analysis

The testbench was designed to validate the two primary functions of a multiplexer: correctly routing input `A` when the selector is '0' and correctly routing input `B` when the selector is '1'.

**Initial State (0 ns - 10 ns):**
The simulation begins by setting the selector (`TB_SEL`) to **'0'**. Input `TB_A` is given the value `x"AA"` (10101010), while `TB_B` is given `x"55"` (01010101). As expected, the output `TB_Y` immediately reflects the value of `TB_A`, stabilizing at `x"AA"`. This confirms the '0' select path is functional.

**First Test (10 ns - 20 ns):**
At the 10 ns mark, the selector `TB_SEL` is toggled to **'1'**. The inputs `TB_A` and `TB_B` remain unchanged. In immediate response, the output `TB_Y` switches from `x"AA"` to `x"55"`, correctly tracking the value of input `TB_B`. This validates the '1' select path.

**Second Test (20 ns - 30 ns):**
To ensure the component reacts to changes on the data inputs (and isn't "stuck"), the inputs are updated at 20 ns while `TB_SEL` is still held at **'1'**. `TB_A` changes to `x"FF"` and `TB_B` changes to `x"00"`. The output `TB_Y` properly follows the selected input (`TB_B`) and transitions to `x"00"`.

**Final Test (30 ns onwards):**
Finally, at 30 ns, the selector `TB_SEL` is switched back to **'0'**. The output `TB_Y` responds instantly, switching from `x"00"` (the value of `B`) to `x"FF"` (the current value of `A`).

**Conclusion:**
The waveform clearly demonstrates that the multiplexer operates exactly as specified. The output `TB_Y` consistently and correctly follows the input (`A` or `B`) designated by the `TB_SEL` signal, proving the design is robust and logically sound.
