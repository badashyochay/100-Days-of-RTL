library ieee;
use ieee.std_logic_1164.all;

entity Day2_dff_sync is
	port(
		CLK   : in std_logic;
		RESET : in std_logic;
		D     : in std_logic_vector(7 downto 0);
		Q     : out std_logic_vector(7 downto 0)
		);
end Day2_dff_sync;

architecture arc_Day2_dff_sync of Day2_dff_sync is
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if (RESET = '1') then
				Q <= (others => '0');
			else
				Q <= D;
			end if;
		end if;
	end process;
end arc_Day2_dff_sync;
		
