# Day 2: Asynchronous vs. Synchronous Reset DFF

The objective for Day 2 was to design, verify, and compare two fundamental "flavours" of a D-Type Flip-Flop (DFF): one with an **asynchronous reset** and one with a **synchronous reset**.

The testbench (`day2_tb.vhd`) instantiates both DFFs and feeds them the exact same Clock, Reset, and Data signals. The simulation waveform below clearly illustrates the critical difference in their behavior.

![Simulation Waveform for Day 2](Day2_waveform.png)

## Simulation Analysis

The test was specifically designed to create a scenario where the reset signal asserts *between* clock edges, highlighting the core difference between the two components.

* **Signals:**
    * `TB_Q_async`: The output of the Asynchronous DFF.
    * `TB_Q_sync`: The output of the Synchronous DFF.
    * `TB_RESET`: The shared reset signal (Active-High: '1' = Reset).

**Phase 1: (0ns - 17ns) - Normal Operation**

* **Events:** The simulation begins with `TB_RESET` low ('0', inactive). Both DFFs receive a `rising_edge(TB_CLK)` at 5ns (loading `x"AA"`) and again at 15ns (loading `x"BB"`).
* **Observation:** During this phase, both `TB_Q_async` and `TB_Q_sync` behave identically. They correctly sample the `TB_D` input on every rising clock edge. This confirms both are functioning as standard DFFs when not in reset.

**Phase 2: (17ns) - The Critical Test: Asynchronous Reset Assertion**

* **Event:** At 17ns, exactly between the clock edges of 15ns and 25ns, the `TB_RESET` signal asserts (goes high to '1').
* **Observation (The Key Difference):**
    * `TB_Q_async` responds **immediately**. Because its reset is asynchronous, it does not wait for the clock. The output is instantly forced to `x"00"`.
    * `TB_Q_sync` **ignores the reset completely**. Its logic is only evaluated on a clock edge, so it continues to hold its last valid value, `x"BB"`.

**Phase 3: (25ns) - The Clock Edge During Reset**

* **Event:** The next `rising_edge(TB_CLK)` arrives at 25ns. `TB_RESET` is still held high ('1').
* **Observation:**
    * `TB_Q_async` is already in a reset state and remains at `x"00"`.
    * `TB_Q_sync` **now** evaluates its inputs. It sees the rising clock edge and *also* sees that `TB_RESET` is active. Its logic (`if RESET = '1' then...`) is triggered, and its output is now forced to `x"00"`.

**Phase 4: (30ns onwards) - Reset Release**

* **Event:** At 30ns, `TB_RESET` de-asserts (goes low to '0'). At 35ns, the next clock edge arrives.
* **Observation:** With the reset released, both DFFs return to normal operation. On the 35ns clock edge, they both sample the `TB_D` input (which is still `x"BB"`) and output `x"BB"`.

### Conclusion

This simulation perfectly demonstrates the fundamental difference: an **asynchronous reset** is a high-priority, immediate override that is independent of the clock. A **synchronous reset** is part of the standard logic, is only evaluated on an active clock edge, and ensures that all state changes in the system happen in lock-step with the clock.
