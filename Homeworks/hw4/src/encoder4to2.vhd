library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder4to2 is
    port(
        A : in STD_LOGIC_VECTOR(3 downto 0);
        Y : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;

architecture design of encoder4to2 is
    component or2
        port(
            a, b : in STD_LOGIC;
            y : out STD_LOGIC
        );
    end component;

begin
    o1: or2 port map(a => A(1), b => A(3), y => Y(0));
    o2: or2 port map(a => A(2), b => A(3), y => Y(1));
end architecture;
