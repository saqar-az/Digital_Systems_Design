library ieee;
use ieee.std_logic_1164.all;

entity SR is
  port (
    clk : in std_logic;
    rst : in std_logic;
    M : in std_logic; 
    inp : in std_logic;
    outp : out std_logic_vector(3 downto 0)
  );
end SR;

architecture structural of SR is
  component DFF
    port (
      d : in std_logic;
      clk : in std_logic;
      rst : in std_logic;
      q : out std_logic
    );
  end component;

  signal q_int : std_logic_vector(3 downto 0);
  signal d_in  : std_logic_vector(3 downto 0);
begin
  d_in(0) <= inp when M='0' else q_int(1); 
  d_in(1) <= q_int(0) when M='0' else q_int(2);
  d_in(2) <= q_int(1) when M='0' else q_int(3);
  d_in(3) <= q_int(2) when M='0' else inp;

  DFF0: DFF port map(d => d_in(0), clk => clk, rst => rst, q => q_int(0));
  DFF1: DFF port map(d => d_in(1), clk => clk, rst => rst, q => q_int(1));
  DFF2: DFF port map(d => d_in(2), clk => clk, rst => rst, q => q_int(2));
  DFF3: DFF port map(d => d_in(3), clk => clk, rst => rst, q => q_int(3));

  outp <= q_int;
end structural;
