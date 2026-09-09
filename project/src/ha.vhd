library ieee;
use ieee.std_logic_1164.all;

entity HA is
  port(
    a,b : in std_logic;
    sum : out std_logic;
    cout : out std_logic
  );
end HA;

architecture half_adder of HA is
begin
  sum <= a xor b;
  cout <= a and b;
end half_adder;

