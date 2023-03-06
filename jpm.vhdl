library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity JMP is
    port(
        ciclo : in std_logic_vector(2 downto 0);
        barr_inc, barr_PC : out std_logic; 
        ULA_op : out std_logic_vector(2 downto 0);
        PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
    );
end entity;

architecture comuta of JMP is
    
begin

    barr_inc <= not(ciclo(2) and  not ciclo(1) and ciclo(0));
    barr_PC  <= '1';
    ULA_op   <= "000";
    PC_rw    <= (not ciclo(2) and not ciclo(1) and ciclo(0)) or (ciclo(2) and not ciclo(1) and ciclo(0));
    AC_rw    <= '0';
    MEM_rw   <= '0';
    REM_rw   <= (not ciclo(2) and not ciclo(1) and not ciclo(0)) or (not ciclo(2) and ciclo(1) and ciclo(0));
    RDM_rw   <= (not ciclo(2) and not ciclo(1) and ciclo(0)) or (ciclo(2) and not ciclo(1) and not ciclo(0));
    RI_rw    <=  not ciclo(2) and ciclo(1) and not ciclo(0);
    
end architecture;
