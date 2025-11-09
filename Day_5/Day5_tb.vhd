library ieee;
use ieee.std_logic_1164.all;

entity Day5_tb is
end entity Day5_tb;

architecture arc_Day5_tb of Day5_tb is

    component Day5 is
        port (
            CLK          : in  std_logic;
            RESET        : in  std_logic;
            DATA_IN      : in  std_logic;
            DETECTED_OUT : out std_logic
        );
    end component;

    signal TB_CLK      : std_logic := '0';
    signal TB_RESET    : std_logic;      
    signal TB_DATA_IN  : std_logic;      
    signal TB_DETECTED : std_logic; 

begin

    DUT: Day5
        port map (
            CLK          => TB_CLK,
            RESET        => TB_RESET,
            DATA_IN      => TB_DATA_IN,
            DETECTED_OUT => TB_DETECTED
        );

    TB_CLK <= not TB_CLK after 5 ns;
    
	process
    begin
        
        -- Stage 1: Assert Reset (Active-High)
        TB_RESET   <= '1'; -- Activate reset
        TB_DATA_IN <= '0';
        wait for 15 ns;

        -- Stage 2: Release Reset, start searching
        TB_RESET <= '0'; -- De-assert reset
        wait until rising_edge(TB_CLK);
        
        -- Stage 3: Send the correct sequence "101"
        TB_DATA_IN <= '1';
        wait until rising_edge(TB_CLK);
        
        TB_DATA_IN <= '0';
        wait until rising_edge(TB_CLK);

        TB_DATA_IN <= '1';
        wait until rising_edge(TB_CLK);

        -- Stage 4: Check that the output is a pulse (returns to '0')
        TB_DATA_IN <= '0';
        wait until rising_edge(TB_CLK);

        -- Stage 5: Test a failing sequence ("100")
        TB_DATA_IN <= '1';
        wait until rising_edge(TB_CLK);
        
        TB_DATA_IN <= '0';
        wait until rising_edge(TB_CLK);

        TB_DATA_IN <= '0'; -- Wrong input!
        wait until rising_edge(TB_CLK);

        -- Stage 6: Test a correct sequence again ("101")
		TB_DATA_IN <= '1';
        wait until rising_edge(TB_CLK); -- (State -> GOT_1)
        
        TB_DATA_IN <= '0';
        wait until rising_edge(TB_CLK); -- (State -> GOT_10)

        TB_DATA_IN <= '1';
        wait until rising_edge(TB_CLK);

        wait; 
    end process;

end architecture arc_Day5_tb;