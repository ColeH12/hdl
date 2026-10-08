-------------------------------------------------------------------------------
--Cole Hayes
-- Active-Low 7-Segment Decoder
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity seven_seg is 
  port (
    input  : in  std_logic_vector(3 downto 0);
    output : out std_logic_vector(6 downto 0)
  );
end seven_seg;

architecture beh of seven_seg is
begin 
  process(input)
  begin
    case input is
      -- Bit order: g f e d c b a
      when "0000" => output <= "1000000"; -- 0
      when "0001" => output <= "1111001"; -- 1
      when "0010" => output <= "0100100"; -- 2
      when "0011" => output <= "0110000"; -- 3
      when "0100" => output <= "0011001"; -- 4
      when "0101" => output <= "0010010"; -- 5
      when "0110" => output <= "0000010"; -- 6
      when "0111" => output <= "1111000"; -- 7
      when "1000" => output <= "0000000"; -- 8
      when "1001" => output <= "0010000"; -- 9
      when "1010" => output <= "0001000"; -- A
      when "1011" => output <= "0000011"; -- b
      when "1100" => output <= "1000110"; -- C
      when "1101" => output <= "0100001"; -- d
      when "1110" => output <= "0000110"; -- E
      when "1111" => output <= "0001110"; -- F
      when others => output <= "1111111"; -- Off
    end case;
  end process;
end beh;