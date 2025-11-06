library ieee;
use ieee.std_logic_1164.all;

entity Day2_TB is
end entity;

architecture arc_Day2_TB of Day2_TB is
	component Day2_dff_sync
		port(
		CLK   : in std_logic;
		RESET : in std_logic;
		D     : in std_logic_vector(7 downto 0);
		Q     : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component Day2_dff_async
		port(
		CLK   : in std_logic;
		RESET : in std_logic;
		D     : in std_logic_vector(7 downto 0);
		Q     : out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal TB_CLK   : std_logic := '0'; -- Shared Clock
    signal TB_RESET : std_logic;      -- Shared Reset
    signal TB_D     : std_logic_vector(7 downto 0); -- Shared Data
	-- Separate outputs to see the difference
    signal TB_Q_async : std_logic_vector(7 downto 0); -- Output of Async DFF
    signal TB_Q_sync  : std_logic_vector(7 downto 0); -- Output of Sync DFF
begin
	DUT_Async: day2_dff_async
        port map (
            CLK   => TB_CLK,
            RESET => TB_RESET,
            D     => TB_D,
            Q     => TB_Q_async -- Connect to its unique output signal
        );
		
	DUT_Sync: day2_dff_sync
        port map (
            CLK   => TB_CLK,
            RESET => TB_RESET,
            D     => TB_D,
            Q     => TB_Q_sync  -- Connect to its unique output signal
        );
	TB_CLK <= not(TB_CLK) after 5 ns;

    TB_D <= x"AA" after 0 ns,
            x"BB" after 12 ns; 

    TB_RESET <= '0' after 0 ns,   
               '1' after 17 ns,   
               '0' after 30 ns;   
end arc_Day2_TB;