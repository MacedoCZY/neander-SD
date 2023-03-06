library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_NEANDER is
end entity;

architecture ulinha of tb_NEANDER is
    constant cicloClock : time := 20 ns;

    component NEANDER is
        port(
            clk, cl : in std_logic
        );
    end component;
    
    signal scl : std_logic := '1';
    signal sclk : std_logic := '0';
    
begin
    sclk <= not(sclk) after cicloClock / 2;

    u_NEANDER : NEANDER port map(sclk, scl);
    
       
    tb : process
    begin

        scl <= '0';
        wait for cicloClock;
        scl <= '1';

        wait;
    end process;

end architecture;
