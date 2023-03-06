library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg08bitC is
    port(
        datain  : in std_logic_vector(7 downto 0);
        clk     : in std_logic;
        pr, cl  : in std_logic;        
        write   : in std_logic;
        dataout : out std_logic_vector(7 downto 0)
    );
end entity;

architecture reg of reg08bitC is
    component reg01bitC is
        port(
            datain  : in std_logic;
            clk     : in std_logic;
            pr, cl  : in std_logic;        
            write   : in std_logic;
            dataout : out std_logic
        );
    end component;
begin

    --ur7 : reg01bitC port map(datain(7), clk, pr, cl, write, dataout(7));
    --ur6 : reg01bitC port map(datain(6), clk, pr, cl, write, dataout(6));
    --ur5 : reg01bitC port map(datain(5), clk, pr, cl, write, dataout(5));
    -- ...
    --ur0 : reg01bitC port map(datain(0), clk, pr, cl, write, dataout(0));
    gr: for i in 7 downto 0 generate
	    ur : reg01bitC port map(datain(i), clk, pr, cl, write, dataout(i));
    end generate gr;
end architecture;









