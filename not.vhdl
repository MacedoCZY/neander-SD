library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nNOT is
    port(
        ciclo : in std_logic_vector(2 downto 0);
        barr_inc, barr_PC : out std_logic; 
        ULA_op : out std_logic_vector(2 downto 0);
        PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
    );
end entity;

architecture comuta of nNOT is
    
begin

    barr_inc <= '1';
    barr_PC  <= '1';
    ULA_op   <= "100";
    PC_rw    <= not ciclo(2) and not ciclo(1) and ciclo(0);
    AC_rw    <= ciclo(2) and ciclo(1) and ciclo(0);
    MEM_rw   <= '0';
    REM_rw   <= not ciclo(2) and not ciclo(1) and not ciclo(0);
    RDM_rw   <= not ciclo(2) and not ciclo(1) and ciclo(0);
    RI_rw    <= not ciclo(2) and ciclo(1) and not ciclo(0);
    
end architecture;
