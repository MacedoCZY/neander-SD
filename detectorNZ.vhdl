library ieee;
use ieee.std_logic_1164.all;

entity detectorNZ is
    port(
        s : in  std_logic_vector(7 downto 0);
        nz : out std_logic_vector(1 downto 0)
    );
end entity;

architecture comuta of detectorNZ is
begin
    
    nz(1) <= s(7);
    
    nz(0) <= not(s(7) or s(6) or s(5) or s(4) or s(3) or s(2) or s(1) or s(0));

end architecture;  
