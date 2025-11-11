library ieee;
use ieee.std_logic_1164.all;

entity Day6_tb is
end entity Day6_tb;

architecture arc_Day6_tb of Day6_tb is

    component Day6 is
        port (
            CLK     : in  std_logic;
            RESET   : in  std_logic;
            DATA_IN : in  std_logic;
            OUTPUT  : out std_logic_vector(7 downto 0)
        );
    end component;

    signal TB_CLK     : std_logic := '0';
    signal TB_RESET   : std_logic;
    signal TB_DATA_IN : std_logic;
    signal TB_OUTPUT  : std_logic_vector(7 downto 0);

begin

    DUT: Day6
        port map (
            CLK     => TB_CLK,
            RESET   => TB_RESET,
            DATA_IN => TB_DATA_IN,
            OUTPUT  => TB_OUTPUT
        );

    TB_CLK <= not TB_CLK after 5 ns;

    -- Stimulus Process
    process
    begin
        
        -- Stage 1: Assert Reset
        TB_RESET   <= '1';
        TB_DATA_IN <= '0'; -- Irrelevant during reset
        wait for 15 ns;
        -- Expect TB_OUTPUT = "00000000"

        -- Stage 2: Release Reset
        TB_RESET <= '0';
        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00000000"
        
        -- Stage 3: Inject a single '1'
        TB_DATA_IN <= '1';
        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "10000000" (The '1' entered at bit 7)

        -- Stage 4: Inject '0's and watch the '1' travel
        TB_DATA_IN <= '0';
        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "01000000" (The '1' moved to bit 6)

        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00100000" (The '1' moved to bit 5)
        
        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00010000" (Bit 4)
        
        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00001000" (Bit 3)

        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00000100" (Bit 2)

        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00000010" (Bit 1)
        
        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00000001" (Bit 0)
        
        wait until rising_edge(TB_CLK);
        -- Expect TB_OUTPUT = "00000000" (The '1' has "fallen off" the end)

        wait;
    end process;

end architecture arc_Day6_tb;