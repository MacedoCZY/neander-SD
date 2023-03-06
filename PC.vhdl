library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        barr : in std_logic_vector(7 downto 0);
        barr_inc, PC_rw, clk ,cl: in std_logic;
        end_out : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comuta of PC is

    component fadder8 is
        port(
            a, b : in std_logic_vector(7 downto 0);
            cin  : in std_logic;
            s    : out std_logic_vector(7 downto 0);
            cout : out std_logic
        );
    end component;

    component reg08bitC is
        port(
            datain  : in std_logic_vector(7 downto 0);
            clk     : in std_logic;
            pr, cl  : in std_logic;        
            write   : in std_logic;
            dataout : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal sadd, s_PCatual,s_mux2pc : std_logic_vector(7 downto 0) := (others => '0');
    signal scout : std_logic; -- para o fio não ficar solto
    
begin

    u_adderPC : fadder8 port map("00000001", s_PCatual, '0', sadd, scout);
    
    s_mux2pc <= sadd when barr_inc = '1' else barr;
    
    u_reg8PC : reg08bitC port map(s_mux2pc, clk, '1', cl, PC_rw, s_PCatual);
    
    end_out <= s_PCatual;

end architecture;
