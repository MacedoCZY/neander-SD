library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_INIT is
    port(
        x, y : in std_logic_vector(7 downto 0);
        ULA_op : in std_logic_vector(2 downto 0);
        resultado : out std_logic_vector(7 downto 0);
        nz : out std_logic_vector(1 downto 0)
    );
end entity;

architecture comuta of ULA_INIT is

    component fadder8 is
        port(
            a, b : in std_logic_vector(7 downto 0);
            cin  : in std_logic;
            s    : out std_logic_vector(7 downto 0);
            cout : out std_logic
        );
    end component; 
    
    component detectorNZ is
        port(
            s : in  std_logic_vector(7 downto 0);
            nz : out std_logic_vector(1 downto 0)
        );
    end component; 

    signal sadd, sor, sand, snot, s_resultado : std_logic_vector(7 downto 0) := (others => '0');
    signal scout : std_logic;  -- fio solto
    
begin

    u_adder : fadder8 port map(x, y, '0', sadd, scout);
    
    sor <= x or y;
    
    sand <= x and y;
    
	snot <= not(x);
 
    
    s_resultado <= y when ULA_op = "000" else sadd when ULA_op = "001" else sor when ULA_op = "010" else sand when ULA_op = "011" else snot when ULA_op = "100"; 
    
    resultado <= s_resultado;
    
    u_nzulamidNZ : detectorNZ port map(s_resultado, nz);
    
end architecture;
