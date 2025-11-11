# Day 6: 8-Bit Shift Register (SIPO)

The objective for Day 6 was to design and verify a fundamental component for data movement: an 8-bit Serial-In, Parallel-Out (SIPO) Shift Register. This sequential component takes a single bit of data at a time (`DATA_IN`) and shifts it one position down the register on every clock cycle. The `Parallel_Out` port allows us to see all 8 bits stored inside the register at once.

The simulation waveform below perfectly demonstrates this "traveling" data.

![Simulation Waveform for Day 6 Shift Register](Day6_Waveform.png)

## Simulation Analysis

The testbench was designed to test three key functions: the active-high reset, the injection of a single data bit, and the progressive shift of that bit through all 8 positions.

* **Signals:**
    * `TB_RESET`: The active-high reset.
    * `TB_DATA_IN`: The 1-bit serial data being fed into the register.
    * `TB_OUTPUT`: The 8-bit parallel output showing the register's full contents.

**1. Reset (0ns - 15ns)**
* **Event:** The simulation begins with `TB_RESET` asserted high ('1').
* **Observation:** `TB_OUTPUT` is held at "00000000".
* **Conclusion:** ✅ The reset correctly clears
