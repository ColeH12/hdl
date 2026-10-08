-------------------------------------------------------------------------------
-- Testbench for top level add_sub
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_sub_tb is
end add_sub_tb;

architecture tb of add_sub_tb is

  -- Component Declaration matching top level add_sub
  component add_sub is 
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
  end component;

  -- Testbench Signals
  signal clk        : std_logic := '0';
  signal reset      : std_logic := '0';
  signal a          : std_logic_vector(2 downto 0) := "000";
  signal b          : std_logic_vector(2 downto 0) := "000";
  signal add_btn    : std_logic := '0';
  signal sub_btn    : std_logic := '0';
  signal a_bcd      : std_logic_vector(6 downto 0);
  signal b_bcd      : std_logic_vector(6 downto 0);
  signal result_bcd : std_logic_vector(6 downto 0);

  constant clk_period : time := 20 ns; -- 50 MHz clock

begin

  -- Unit Under Test (UUT)
  uut: add_sub port map (
    clk        => clk,
    reset      => reset,
    a          => a,
    b          => b,
    add_btn    => add_btn,
    sub_btn    => sub_btn,
    a_bcd      => a_bcd,
    b_bcd      => b_bcd,
    result_bcd => result_bcd
  );

  -- 50 MHz Clock Generator
  clk_process : process
  begin
    clk <= '0';
    wait for clk_period / 2;
    clk <= '1';
    wait for clk_period / 2;
  end process;

  -- Stimulus Process to Match Lab Waveform
  stim_proc: process
  begin
    -- Initial Reset
    reset <= '1';
    wait for 40 ns;
    reset <= '0';
    wait for 40 ns;

    -- 1. Addition Mode Test:
    -- Cycle inputs 'a' from 0 to 7 while b = 0, then sweeping both to 7
    for i in 0 to 7 loop
      a <= std_logic_vector(to_unsigned(i, 3));
      b <= std_logic_vector(to_unsigned(i, 3));
      wait for 100 ns;
    end loop;

    -- Pulse Add Button
    add_btn <= '1';
    wait for 60 ns;
    add_btn <= '0';
    wait for 140 ns;

    -- 2. Subtraction Mode Test:
    -- Pulse Sub Button to enter Subtraction mode
    sub_btn <= '1';
    wait for 60 ns;
    sub_btn <= '0';
    wait for 140 ns;

    -- Cycle inputs 'a' and 'b' again from 0 to 7 in Subtract mode
    for i in 0 to 7 loop
      a <= std_logic_vector(to_unsigned(i, 3));
      b <= std_logic_vector(to_unsigned(i, 3));
      wait for 100 ns;
    end loop;

    wait;
  end process;

end tb;