-------------------------------------------------------------------------------
-- Cole Hayes
-- blink led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity seven_seg is
  port (
    reset             : in  std_logic; 
    bcd           : in  std_logic;
    seven_seg_out         : out std_logic
  );  
end blink;  

architecture beh of seven_seg  is

begin
process(reset,bcd)
  begin
    if (reset = '1') then 
      seven_seg_out <= "0000001";
    else 
      case bcd is
	    when "0000" =>
	      seven_seg_out <= "1000000";
	    when "0001" =>
	      seven_seg_out <= "1000000";
	    when "0010" =>
	      seven_seg_out <= "1000000";
	    when "0011" =>
	      seven_seg_out <= "1000000";
		when "0100" =>
	      seven_seg_out <= "1000000";
		when "0101" =>
	      seven_seg_out <= "1000000";
		when "0110" =>
	      seven_seg_out <= "1000000";
		when "0111" =>
	      seven_seg_out <= "1000000";
		when "1000" =>
	      seven_seg_out <= "1000000";
		when "1001" =>
	      seven_seg_out <= "1000000";
		when others =>
	      seven_seg_out <= "1000000";
		end case;
    end if;
  end process;
end beh;