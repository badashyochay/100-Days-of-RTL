library ieee;
use ieee.std_logic_1164.all;
-- Note: numeric_std is NOT needed here, we are only assigning values.

entity Day4_ALU_tb is
end entity Day4_ALU_tb;

architecture arc_Day4_ALU_tb of Day4_ALU_tb is

    component Day4_ALU is
        port (
            A   : in  std_logic_vector(7 downto 0);
            B   : in  std_logic_vector(7 downto 0);
            SEL : in  std_logic_vector(2 downto 0);
            Y   : out std_logic_vector(7 downto 0)
        );
    end component;

    signal TB_A   : std_logic_vector(7 downto 0) := (others => '0');
    signal TB_B   : std_logic_vector(7 downto 0) := (others => '0');
    signal TB_SEL : std_logic_vector(2 downto 0) := (others => '0');
    signal TB_Y   : std_logic_vector(7 downto 0); -- The final output

begin

    DUT: Day4_ALU
        port map (
            A   => TB_A,
            B   => TB_B,
            SEL => TB_SEL,
            Y   => TB_Y
        );

    -- Stimulus Process
    process
    begin
        TB_A <= x"10"; -- 16
        TB_B <= x"02"; -- 2
        
        -- Test 0: ADD ("000")
        TB_SEL <= "000";
        wait for 10 ns;

        -- Test 1: SUB ("001")
        TB_SEL <= "001";
        wait for 10 ns;

        -- Test 2: SLL ("010")
        TB_SEL <= "010";
        wait for 10 ns;

        -- Test 3: LSR ("011")
        TB_SEL <= "011";
        wait for 10 ns;

        -- Test 4: AND ("100")
        TB_SEL <= "100";
        wait for 10 ns;

        -- Test 5: OR ("101")
        TB_SEL <= "101";
        wait for 10 ns;

        -- Test 6: XOR ("110")
        TB_SEL <= "110";
        wait for 10 ns;

        -- Test 7: EQL ("111")
        TB_SEL <= "111";
        wait for 10 ns;

        -- Test 8: EQL (Second check)
        TB_B <= x"10"; -- Now A = 16, B = 16
        wait for 10 ns;
        -- Expect Y = (16 == 16) => "00000001" (x"01")

        wait;
    end process;

end architecture arc_Day4_ALU_tb;