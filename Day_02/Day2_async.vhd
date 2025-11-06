library ieee;
use ieee.std_logic_1164.all;

entity Day2_dff_async is
	port(
		CLK   : in std_logic;
		RESET : in std_logic;
		D     : in std_logic_vector(7 downto 0);
		Q     : out std_logic_vector(7 downto 0)
		);
end Day2_dff_async;

architecture arc_Day2_dff_async of Day2_dff_async is
begin
	process(CLK,RESET)
	begin
		if (RESET = '1') then
			Q <= (others => '0');
		elsif rising_edge(CLK) then
			Q <= D;
		end if;
	end process;
end arc_Day2_dff_async;
		