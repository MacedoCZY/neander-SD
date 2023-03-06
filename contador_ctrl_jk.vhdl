library ieee;
use ieee.std_logic_1164.all; 

entity ctrljk is
    port(
        ea   : in  std_logic_vector(2 downto 0);
        j, k : out std_logic_vector(2 downto 0)
    );
end entity;

architecture controle of ctrljk is

begin


    -- j2 k2
    j(2) <= ea(1) and ea(0);
    k(2) <= ea(1) and ea(0);

    -- j1 k1
    j(1) <= ea(0);
    k(1) <= ea(0);
    
    -- j0 k0
    j(0) <= '1';
    k(0) <= '1';

end architecture;
