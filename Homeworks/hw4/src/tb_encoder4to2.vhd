library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_encoder4to2 is
end entity;

architecture code of tb_encoder4to2 is
    component encoder4to2
        port(
            A : in STD_LOGIC_VECTOR(3 downto 0);
            Y : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal A : STD_LOGIC_VECTOR(3 downto 0);
    signal Y : STD_LOGIC_VECTOR(1 downto 0);

begin
    en: encoder4to2 port map(A => A, Y => Y);

    proc: process
    begin
        A <= "0001"; wait for 10 ns;
        A <= "0010"; wait for 10 ns;
        A <= "0100"; wait for 10 ns;
        A <= "1000"; wait for 10 ns;
        wait;
    end process;
end architecture;
