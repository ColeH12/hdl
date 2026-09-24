-------------------------------------------------------------------------------
-- Cole Hayes
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );
end top;

architecture beh of top is

component seven_seg is
  port (
    reset             : in  std_logic; 
    bcd           : in  std_logic_vector(3 downto 0);
    seven_seg_out          : out std_logic_vector(6 downto 0)
  );  
end component;  

component generic_adder_beh is
generic (
    bits : integer := 4
);
  port (
    a             : in  std_logic_vector(bits-1 downto 0);
    b             : in  std_logic_vector(bits-1 downto 0);
    cin           : in std_logic;
	sum           : out std_logic_vector(bits-1 downto 0);
	cout		  : out std_logic
  );  
end component; 

component generic_counter is
generic (
    max_count       : integer := 3
);
  port (
    clk             : in  std_logic;
    reset             : in  std_logic;
    output           : out std_logic
  );  
end component;

signal sum_sig : std_logic_vector(3 downto 0);
signal sum : std_logic_vector(3 downto 0);
signal enable : std_logic;

begin

process(clk,reset)
   begin
    if (reset = '1') then
      sum_sig <= "0000";
	elsif (clk'event and clk = '1') then
	  if (enable = '1') then
		sum_sig <= sum;
	  end if;
	end if;
end process;

uut: seven_seg  
  port map(
    reset       => reset,
    bcd          => sum_sig,
    seven_seg_out    => seven_seg_out
  );
  
uut2: generic_counter
	generic map (
	max_count => 50000000
	)
	port map(
	clk => clk,
	reset => reset,
	output => enable
	);
	
uut3 : generic_adder_beh
	generic map (
	bits => 4
	)
	port map(
	a => sum_sig,
	b => "0001",
	cin => '0',
	sum => sum, 
	cout => open
	);
end beh;