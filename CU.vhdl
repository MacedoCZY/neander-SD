library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CU is
    port(
        barr : inout std_logic_vector(7 downto 0);
        clk, cl : in std_logic;
        interface_flags : in std_logic_vector(1 downto 0);
        barr_inc, barr_PC, PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw: out std_logic;
        ULA_op : out std_logic_vector(2 downto 0);
        pc2mem : out std_logic_vector(7 downto 0)
    );
end entity;

architecture comuta of CU is
    component MD is
        port(
            barr_DI : inout std_logic_vector(7 downto 0);
            interface_flags : in std_logic_vector(1 downto 0);
            clk, cl : in std_logic;
            barr_inc, barr_PC, PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw : out std_logic;
            ULA_op : out std_logic_vector(2 downto 0)
        );
    end component;
    
    component PC is
        port(
            barr : inout std_logic_vector(7 downto 0);
            barr_inc, PC_rw, clk ,cl: in std_logic;
            end_out : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal sbarr_inc, sPC_rw : std_logic;
    
    
begin

    barr_inc <= sbarr_inc;
    PC_rw <= sPC_rw;

    u_md : MD port map(barr, interface_flags, clk, cl, sbarr_inc, barr_PC, sPC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, ULA_op);
    
    u_PCcu : PC port map(barr, sbarr_inc, sPC_rw, clk, cl, pc2mem);
    
end architecture;
