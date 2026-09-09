library ieee;
use ieee.std_logic_1164.all;

entity wall is
  port(
    A,B : in std_logic_vector(3 downto 0);
    p : out std_logic_vector(7 downto 0)
  );
end wall;

architecture design of wall is
  type andout   is array (0 to 15) of std_logic;
  type sum_array   is array (0 to 6) of std_logic;
  type carry_array is array (0 to 10) of std_logic;

  signal and_out : andout;
  signal s : sum_array;
  signal c : carry_array;

  component FA
    port(
      a,b,cin : in std_logic;
      sum : out std_logic;
      cout : out std_logic
    );
  end component;

  component HA
    port(
      a,b : in std_logic;
      sum : out std_logic;
      cout : out std_logic
    );
  end component;

begin
  and_out(0)  <= A(0) and B(0);
  and_out(1)  <= A(1) and B(0);
  and_out(2)  <= A(0) and B(1);
  and_out(3)  <= A(0) and B(2);
  and_out(4)  <= A(1) and B(1);
  and_out(5)  <= A(2) and B(0);  
  and_out(6)  <= A(0) and B(3);
  and_out(7)  <= A(1) and B(2);
  and_out(8)  <= A(2) and B(1);
  and_out(9)  <= A(3) and B(0);
  and_out(10) <= A(1) and B(3);
  and_out(11) <= A(2) and B(2);
  and_out(12) <= A(3) and B(1);
  and_out(13) <= A(2) and B(3);
  and_out(14) <= A(3) and B(2);
  and_out(15) <= A(3) and B(3);

  -- 1st row
  HA0: HA port map(a => and_out(1), b => and_out(2), sum => p(1), cout => c(0));
  HA1: HA port map(a => and_out(3), b => and_out(4), sum => s(0), cout => c(1));
  HA2: HA port map(a => and_out(6), b => and_out(7), sum => s(1), cout => c(2));
  FA0: FA port map(a => and_out(10), b => and_out(11), cin => c(2), sum => s(2), cout => c(3));
  FA1: FA port map(a => and_out(13), b => and_out(14), cin => c(3), sum => s(3), cout => c(4));

  -- 2nd row
  FA2: FA port map(a => s(0), b => and_out(5), cin => c(0), sum => p(2), cout => c(5));
  FA3: FA port map(a => s(1), b => and_out(8), cin => c(1), sum => s(4), cout => c(6));
  FA4: FA port map(a => s(2), b => and_out(12), cin => c(6), sum => s(5), cout => c(7));
  FA5: FA port map(a => s(3), b => c(7), cin => c(10), sum => p(5), cout => c(8)); 
  
  -- 3rd row
  FA6: FA port map(a => s(4), b => and_out(9), cin => c(5), sum => p(3), cout => c(9));
  HA3: HA port map(a => c(9), b => s(5), sum => p(4), cout => c(10));
  FA7: FA port map(a => c(8), b => and_out(15), cin => c(4), sum => p(6), cout => p(7)); 
    
  p(0) <= and_out(0);
end design;
