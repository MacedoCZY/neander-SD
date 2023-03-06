library ieee;
use ieee.std_logic_1164.all;

entity reg01bitC is
    port(
        datain  : in std_logic;
        clk     : in std_logic;
        pr, cl  : in std_logic;        
        write   : in std_logic;
        dataout : out std_logic
    );
end entity;

architecture reg of reg01bitC is

    component ffd is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

    signal tempin, tempout, nqdump : std_logic;

begin

    -- instancia do ffd
    ur : ffd port map(tempin, clk, pr, cl, tempout, nqdump);

    -- saída principal
    dataout <= tempout;

    -- multiplex 2x1
    tempin <= datain when write='1' else tempout;

end architecture;








