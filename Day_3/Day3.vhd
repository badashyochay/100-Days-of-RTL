library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Day3_acc is
	port(
		CLK  : in std_logic;
		RESET: in std_logic;
		DATA_IN: in std_logic_vector(3 downto 0);
		RESULT_OUT: out std_logic_vector(3 downto 0)
		);
end Day3_acc;

architecture arc_Day3_acc of Day3_acc is
	signal result: std_logic_vector(3 downto 0);
begin
	process (CLK,RESET)
	begin
		if (RESET = '1') then
			result <= (others => '0');
		elsif rising_edge(CLK) then
			result <= std_logic_vector( unsigned(result) + unsigned(DATA_IN));
		end if;
	end process;
RESULT_OUT <= result;
end architecture arc_Day3_acc;
