-------------------------------------------------------------------------------
--Cole Hayes
-- Top-Level Hardware Add / Subtract Design
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity add_sub is 
  port (
    clk        : in  std_logic;
    reset      : in  std_logic;
    a          : in  std_logic_vector(2 downto 0);
    b          : in  std_logic_vector(2 downto 0);
    add_btn    : in  std_logic;
    sub_btn    : in  std_logic;
    a_bcd      : out std_logic_vector(6 downto 0);
    b_bcd      : out std_logic_vector(6 downto 0);
    result_bcd : out std_logic_vector(6 downto 0)
  );
end add_sub;

architecture struct of add_sub is

  component synchronizer_3bit is 
    port (
      clk      : in  std_logic;
      reset    : in  std_logic;
      async_in : in  std_logic_vector(2 downto 0);
      sync_out : out std_logic_vector(2 downto 0)
    );
  end component;

  component rising_edge_synchronizer is 
    port (
      clk   : in  std_logic;
      reset : in  std_logic;
      input : in  std_logic;
      edge  : out std_logic
    );
  end component;
  
  component generic_add_sub is
    port (
      a      : in  std_logic_vector(3 downto 0);
      b      : in  std_logic_vector(3 downto 0);
      flag   : in  std_logic;
      result : out std_logic_vector(3 downto 0)
    );
  end component;

  component seven_seg is
    port (
      input  : in  std_logic_vector(3 downto 0);
      output : out std_logic_vector(6 downto 0)
    );
  end component;

  signal a_sync, b_sync : std_logic_vector(2 downto 0);
  signal a_pad, b_pad   : std_logic_vector(3 downto 0);
  signal add_en, sub_en : std_logic;
  signal flag           : std_logic;
  signal result         : std_logic_vector(3 downto 0);

begin 

  -- Zero-pad 3-bit synchronized inputs to 4 bits
  a_pad <= '0' & a_sync;
  b_pad <= '0' & b_sync;

  -- Input Synchronizers
  sync_a : synchronizer_3bit port map(
    clk => clk, reset => reset, async_in => a, sync_out => a_sync
  );
  
  sync_b : synchronizer_3bit port map(
    clk => clk, reset => reset, async_in => b, sync_out => b_sync
  );

  -- Button Edge Detectors
  edge_add : rising_edge_synchronizer port map(
    clk => clk, reset => reset, input => not add_btn, edge => add_en
  );
  
  edge_sub : rising_edge_synchronizer port map(
    clk => clk, reset => reset, input => not sub_btn, edge => sub_en
  );

  -- Operation Mode Flag Flip-Flop
  process(clk, reset)
  begin
    if reset = '1' then
      flag <= '0';
    elsif rising_edge(clk) then
      if add_en = '1' then
        flag <= '0';
      elsif sub_en = '1' then
        flag <= '1';
      end if;
    end if;
  end process;

  -- Math Execution
  math_unit : generic_add_sub port map(
    a => a_pad, b => b_pad, flag => flag, result => result
  );

  -- Display Encoders
  seg_a : seven_seg port map(
    input => a_pad, output => a_bcd
  );
  
  seg_b : seven_seg port map(
    input => b_pad, output => b_bcd
  );
  
  seg_result : seven_seg port map(
    input => result, output => result_bcd
  );

end struct;