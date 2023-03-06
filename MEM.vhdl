library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM is
    port(
        end_Barr, end_PC : in std_logic_vector(7 downto 0);
        barr_PC, REM_rw, MEM_rw, RDM_rw, clk, cl : in std_logic;
        interface_barramento : inout std_logic_vector(7 downto 0)
    );
end entity;

architecture comuta of MEM is
    
    component reg08bitC is
        port(
            datain  : in std_logic_vector(7 downto 0);
            clk     : in std_logic;
            pr, cl  : in std_logic;        
            write   : in std_logic;
            dataout : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component as_ram is
	    port(
		    addr  : in    std_logic_vector(7 downto 0);
		    data  : inout std_logic_vector(7 downto 0);
		    notrw : in    std_logic;
		    reset : in    std_logic
	    );
    end component;

    signal s_mux2rem, s_rem2mem, s_mem2rdm, s_rdm2barramento : std_logic_vector(7 downto 0) := (others => '0');

begin

    interface_barramento <= s_rdm2barramento when MEM_rw = '0' else (others => 'Z');
    
    s_mem2rdm <= interface_barramento when MEM_rw = '1' else (others => 'Z');

    s_mux2rem <= end_PC when barr_PC = '1' else end_Barr;
    
    u_regREM : reg08bitC port map(s_mux2rem, clk, '1', cl, REM_rw, s_rem2mem);
    
    u_mem : as_ram port map(s_rem2mem, s_mem2rdm, MEM_rw, cl);
    
    u_regRDM : reg08bitC port map(s_mem2rdm, clk, '1', cl, RDM_rw, s_rdm2barramento);
    
 
end architecture;
