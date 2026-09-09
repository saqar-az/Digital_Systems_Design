library ieee;
use ieee.std_logic_1164.all;

entity tb_SR is
end tb_SR;

architecture behavior of tb_SR is
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal M : std_logic := '0'; 
  signal inp : std_logic := '0';
  signal outp : std_logic_vector(3 downto 0);

begin
  uut: entity work.SR
    port map (
      clk => clk,
      rst => rst,
      M => M,
      inp => inp,
      outp => outp
    );

  clk_process: process
  begin
    while true loop
      clk <= '0'; wait for 5 ns;
      clk <= '1'; wait for 5 ns;
    end loop;
  end process;

  stim_proc: process
  begin
    rst <= '1'; wait for 15 ns;
    rst <= '0'; wait for 10 ns;

    M <= '1'; inp <= '1'; wait for 50 ns;
    M <= '0'; inp <= '1'; wait for 50 ns;
    M <= '1'; inp <= '0'; wait for 50 ns;
    M <= '0'; inp <= '0'; wait for 50 ns;

    wait;
  end process;
end behavior;
