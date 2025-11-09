library ieee;
use ieee.std_logic_1164.all;

entity Day5 is
	port(
		CLK          : in  std_logic;
        RESET        : in  std_logic; 
        DATA_IN      : in  std_logic; 
        DETECTED_OUT : out std_logic
    );
end entity Day5;

architecture arc_Day5 of Day5 is

    type t_state is (
        IDLE,    
        GOT_1,   
        GOT_10  
    );
    
    signal STATE_S        : t_state;
    signal DETECTED_OUT_S : std_logic;

begin
    process (CLK, RESET)
    begin
       
        if RESET = '1' then
            STATE_S  <= IDLE; 
            DETECTED_OUT_S <= '0';  
       
        elsif rising_edge(CLK) then
            DETECTED_OUT_S <= '0';
            case STATE_S is
                when IDLE =>
                    if DATA_IN = '1' then
                        STATE_S <= GOT_1;
                    else
                        STATE_S <= IDLE;
                    end if;

                when GOT_1 =>
                    if DATA_IN = '0' then
						STATE_S <= GOT_10;
                    elsif DATA_IN = '1' then
                        STATE_S <= GOT_1; 
                    else
                        STATE_S <= IDLE;
                    end if;

                when GOT_10 =>
                    if DATA_IN = '1' then
                        DETECTED_OUT_S <= '1';
                        STATE_S  <= IDLE; 
                    else 
                        STATE_S <= IDLE;
                    end if;
                    
                when others =>
                    STATE_S <= IDLE;
            end case;
        end if;
    end process;

    DETECTED_OUT <= DETECTED_OUT_S;
end architecture arc_Day5;