-------------------------------------------------------------------------------
-- Generic 4-bit Add/Subtract Unit
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_add_sub is 
  port (
    a      : in  std_logic_vector(3 downto 0);
    b      : in  std_logic_vector(3 downto 0);
    flag   : in  std_logic; -- '0' = Add, '1' = Subtract
    result : out std_logic_vector(3 downto 0)
  );
end generic_add_sub;

architecture beh of generic_add_sub is
begin 
  process(a, b, flag)
  begin
    if flag = '0' then
      result <= std_logic_vector(unsigned(a) + unsigned(b));
    else
      result <= std_logic_vector(unsigned(a) - unsigned(b));
    end if;
  end process;
end beh;