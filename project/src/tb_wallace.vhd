library ieee;
use ieee.std_logic_1164.all;

entity tb_wallace is
end tb_wallace;

architecture behavior of tb_wallace is
    component wallace
        port(
            A,B : in std_logic_vector(3 downto 0);
            p : out std_logic_vector(7 downto 0)
        );
    end component;

    signal A_tb : std_logic_vector(3 downto 0):= (others => '0');
    signal B_tb : std_logic_vector(3 downto 0):= (others => '0');
    signal P_tb : std_logic_vector(7 downto 0);

begin
    w: wallace
        port map (
            A => A_tb,
            B => B_tb,
            p => P_tb
        );

proc: process
begin
    A_tb <= "1110"; B_tb <= "1011";
    wait for 10 ns;

    A_tb <= "0111"; B_tb <= "1001";
    wait for 10 ns;

    A_tb <= "1111"; B_tb <= "1111";
    wait for 10 ns;
    wait;
end process;

end behavior;
