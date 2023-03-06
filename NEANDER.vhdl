library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NEANDER is
    port(
        clk, cl : in std_logic
    );
end entity;

architecture comuta of NEANDER is

    component ULA_MID is
        port(
            barramento : inout std_logic_vector(7 downto 0);
            ULA_op : in std_logic_vector(2 downto 0);
            AC_rw, MEM_rw, clk, cl : in std_logic;
            interface_flags : out std_logic_vector(1 downto 0)
        );
    end component;
    
    component MEM is
        port(
            end_Barr, end_PC : in std_logic_vector(7 downto 0);
            barr_PC, REM_rw, MEM_rw, RDM_rw, clk, cl : in std_logic;
            interface_barramento : inout std_logic_vector(7 downto 0)
        );
    end component;
    
    component CU is
        port(
            barr : inout std_logic_vector(7 downto 0);
            clk, cl : in std_logic;
            interface_flags : in std_logic_vector(1 downto 0);
            barr_inc, barr_PC, PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw: out std_logic;
            ULA_op : out std_logic_vector(2 downto 0);
            pc2mem : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal s_interfacebarr : std_logic_vector(7 downto 0) := (others => '0');
    signal s_interface_flags : std_logic_vector(1 downto 0) := (others => '0');
    signal sbarr_inc, sbarr_PC, sPC_rw, sAC_rw, sMEM_rw, sREM_rw, sRDM_rw : std_logic;
    signal sULA_op : std_logic_vector(2 downto 0) := (others => '0'); 
    signal spc2mem : std_logic_vector(7 downto 0) := (others => '0'); 

begin

    u_MEM : MEM port map(s_interfacebarr, spc2mem, sbarr_PC, sREM_rw, sMEM_rw, sRDM_rw, clk, cl, s_interfacebarr); 

    u_ULA : ULA_MID port map(s_interfacebarr, sULA_op, sAC_rw, sMEM_rw, clk, cl, s_interface_flags);
    
    u_CU : CU port map(s_interfacebarr, clk, cl, s_interface_flags, sbarr_inc, sbarr_PC, sPC_rw, sAC_rw, sMEM_rw, sREM_rw, sRDM_rw, sULA_op, spc2mem);

end architecture;
