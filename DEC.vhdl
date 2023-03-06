library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DEC is
    port(
        instr : in std_logic_vector(7 downto 0);
        outstr : out std_logic_vector(10 downto 0)
    );
end entity;

architecture comuta of DEC is
    
begin

    -- nop
    outstr(10) <= (not instr(7) and not instr(6) and not instr(5) and not instr(4));
    -- sta
    outstr(9) <= (not instr(7) and not instr(6) and not instr(5) and instr(4));
    -- lda
    outstr(8) <= (not instr(7) and not instr(6) and instr(5) and not instr(4));
    -- add
    outstr(7) <= (not instr(7) and not instr(6) and instr(5) and instr(4));
    -- or 
    outstr(6) <= (not instr(7) and instr(6) and not instr(5) and not instr(4));
    -- and
    outstr(5) <= (not instr(7) and instr(6) and not instr(5) and instr(4));
    -- not
    outstr(4) <= (not instr(7) and instr(6) and instr(5) and not instr(4));
    -- jmp
    outstr(3) <= (instr(7) and not instr(6) and not instr(5) and not instr(4));
    -- jn
    outstr(2) <= (instr(7) and not instr(6) and not instr(5) and instr(4));
    -- jz
    outstr(1) <= (instr(7) and not instr(6) and instr(5) and not instr(4));
    -- hlt
    outstr(0) <= (instr(7) and instr(6) and instr(5) and instr(4));
    
end architecture;
