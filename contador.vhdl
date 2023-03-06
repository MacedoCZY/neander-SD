library ieee;
use ieee.std_logic_1164.all;

entity contador is
    port(
        clk, rst, cl : in std_logic;
        v            : out std_logic_vector(2 downto 0)
    );
end entity;

architecture contar of contador is

    component ffjk is  
        port(
            j, k   : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

    component ctrljk is
        port(
            ea   : in  std_logic_vector(2 downto 0);
            j, k : out std_logic_vector(2 downto 0)
        );
    end component;

    signal sv : std_logic_vector(2 downto 0) := (others => '0');
    signal sj, sk : std_logic_vector(2 downto 0) := (others => '0');
    signal spr, scl : std_logic_vector(2 downto 0) := (others => '0');

begin
    v <= sv;

    gerador : for i in 0 to 2 generate
        ff : ffjk port map(sj(i), sk(i), clk, '1', cl, sv(i));        
    end generate gerador;

    uctrljk : ctrljk port map(sv, sj, sk);


end architecture;
