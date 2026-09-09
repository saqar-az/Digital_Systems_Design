library ieee;
use ieee.std_logic_1164.all;

entity FA is
  port(
    a,b,cin : in std_logic;
    sum : out std_logic;
    cout : out std_logic
  );
end FA;

architecture full_adder of FA is
begin
  sum <= a xor b xor cin;
  cout <= (a and b) or (b and cin) or (a and cin);
end full_adder;
