library ieee;
use ieee.std_logic_1164.all;

entity Day3_tb is
end entity Day3_tb;

architecture arc_Day3_tb of Day3_tb is
    component Day3_acc is
        port (
            CLK        : in  std_logic;
            RESET      : in  std_logic;
            DATA_IN    : in  std_logic_vector(3 downto 0);
            RESULT_OUT : out std_logic_vector(3 downto 0)
        );
    end component;

    signal TB_CLK     : std_logic := '0';
    signal TB_RESET   : std_logic;      
    signal TB_DATA_IN : std_logic_vector(3 downto 0); 
    signal TB_RESULT  : std_logic_vector(3 downto 0); 

begin

    DUT: component Day3_acc
        port map (
            CLK        => TB_CLK,
            RESET      => TB_RESET,
            DATA_IN    => TB_DATA_IN,
            RESULT_OUT => TB_RESULT
        );
		
	TB_CLK <= not(TB_CLK) after 5 ns;

    TB_RESET <= '1', 
				'0' after 15 ns;

    TB_DATA_IN <= (others => 'X') after 0 ns,   
                  "0001"          after 15 ns,   
                  "0011"          after 45 ns,   
                  "1010"          after 55 ns;   

end architecture arc_Day3_tb;