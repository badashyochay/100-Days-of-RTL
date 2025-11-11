library ieee;
use ieee.std_logic_1164.all;

entity Day6 is
	port(
		CLK     : in std_logic;
		RESET   : in std_logic;
		DATA_IN : in std_logic;
		OUTPUT  : out std_logic_vector(7 downto 0)
		);
end entity Day6;

architecture arc_Day6 of Day6 is
	signal SHIFT_REGISTAR_S : std_logic_vector(7 downto 0);
begin
	process (CLK,RESET)
	begin
		if RESET = '1' then
			SHIFT_REGISTAR_S <= (others => '0');
		elsif rising_edge(CLK) then
			SHIFT_REGISTAR_S <= DATA_IN & SHIFT_REGISTAR_S(7 downto 1);
		end if;
	end process;
	OUTPUT <= SHIFT_REGISTAR_S;
end architecture arc_Day6;