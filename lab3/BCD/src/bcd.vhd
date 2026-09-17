library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity bcd_counter is
    Port ( clock   : in  STD_LOGIC;
           reset   : in  STD_LOGIC;
           count_o : out STD_LOGIC_VECTOR (3 downto 0));
end bcd_counter;

architecture Behavioral of bcd_counter is
    signal temp_count : unsigned(3 downto 0) := "0000";
begin
    process(clock, reset)
    begin
        if reset = '1' then
            temp_count <= "0000";
        elsif rising_edge(clock) then
            if temp_count >= "1010" then 
                temp_count <= "0000";   
            else
                temp_count <= temp_count + 1; 
            end if;
        end if;
    end process;

    count_o <= std_logic_vector(temp_count);
end Behavioral;
