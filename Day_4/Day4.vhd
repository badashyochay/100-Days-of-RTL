library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Day4_ALU is
	port(
		A   : in std_logic_vector(7 downto 0);
		B   : in std_logic_vector(7 downto 0);
		SEL : in std_logic_vector(2 downto 0);
		Y	: out std_logic_vector(7 downto 0)
		);
end Day4_ALU;

architecture arc_Day4_ALU of Day4_ALU is
	signal ALU_RESULT_S: std_logic_vector(7 downto 0);
begin
	process (A, B, SEL)	
	begin
		ALU_RESULT_S <= (others => 'X');
		case SEL is
        
            when "000" =>
                ALU_RESULT_S <= std_logic_vector(unsigned(A) + unsigned(B));

            when "001" =>
                ALU_RESULT_S <= std_logic_vector(unsigned(A) - unsigned(B));

            when "010" =>
                ALU_RESULT_S <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B(2 downto 0)))));

            when "011" =>
                ALU_RESULT_S <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(2 downto 0)))));

            when "100" =>
                ALU_RESULT_S <= A and B;

            when "101" =>
                ALU_RESULT_S <= A or B;

            when "110" =>
                ALU_RESULT_S <= A xor B;

            when "111" =>
                if A = B then
                    ALU_RESULT_S <= (0 => '1', others => '0'); -- "00000001"
                else
                    ALU_RESULT_S <= (others => '0'); -- "00000000"
                end if;
			when others =>
                ALU_RESULT_S <= (others => 'X');
        end case;
    end process;
    Y <= ALU_RESULT_S;

end architecture arc_Day4_ALU;
	
