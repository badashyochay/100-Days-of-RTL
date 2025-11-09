# Day 4: 8-bit, 8-Function ALU

The goal for Day 4 was to design and verify a core processing component: an 8-bit, 8-function Arithmetic Logic Unit (ALU). This is a purely combinational component that takes two 8-bit data inputs (`A` and `B`) and a 3-bit opcode (`SEL`) and instantly produces a result.

The simulation waveform below confirms that all 8 operations were implemented correctly.

![Simulation Waveform for Day 4 ALU](Day4_Waveform.png)

## Simulation Analysis

The testbench (`day4_tb.vhd`) was designed to step through all 8 operations, one by one, to validate the output (`TB_Y`). For most of the test, the inputs were held constant:
* `TB_A = x"10"` (decimal 16)
* `TB_B = x"02"` (decimal 2)

The `TB_SEL` opcode was changed every 10 ns to trigger a new calculation.

---

### Verification of Operations

* **`0-10ns` (SEL="000"): ADD**
    * **Expected:** `16 + 2 = 18` (which is `x"12"`)
    * **Result (`TB_Y`):** `"00010010"` (`x"12"`)
    * **Status:** ✅ **Correct.**

* **`10-20ns` (SEL="001"): SUB**
    * **Expected:** `16 - 2 = 14` (which is `x"0E"`)
    * **Result (`TB_Y`):** `"00001110"` (`x"0E"`)
    * **Status:** ✅ **Correct.**

* **`20-30ns` (SEL="010"): SLL (Shift Left)**
    * **Expected:** `A << B(2:0)` -> `16 << 2` -> `64` (which is `x"40"`)
    * **Result (`TB_Y`):** `"01000000"` (`x"40"`)
    * **Status:** ✅ **Correct.**

* **`30-40ns` (SEL="011"): LSR (Shift Right)**
    * **Expected:** `A >> B(2:0)` -> `16 >> 2` -> `4` (which is `x"04"`)
    * **Result (`TB_Y`):** `"00000100"` (`x"04"`)
    * **Status:** ✅ **Correct.**

* **`40-50ns` (SEL="100"): AND**
    * **Expected:**
