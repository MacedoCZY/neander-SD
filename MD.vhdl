library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MD is
    port(
        barr_DI : in std_logic_vector(7 downto 0);
        interface_flags : in std_logic_vector(1 downto 0);
        clk, cl : in std_logic;
        barr_inc, barr_PC, PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw : out std_logic;
        ULA_op : out std_logic_vector(2 downto 0)
    );
end entity;

architecture comuta of MD is

    component reg08bitC is
        port(
            datain  : in std_logic_vector(7 downto 0);
            clk     : in std_logic;
            pr, cl  : in std_logic;        
            write   : in std_logic;
            dataout : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component DEC is
        port(
            instr : in std_logic_vector(7 downto 0);
            outstr : out std_logic_vector(10 downto 0)
        );
    end component;

    component CU_INIT is
        port(
            clk, cl : in std_logic;
            interface_flags : in std_logic_vector(1 downto 0);
            dex2uc : in std_logic_vector(10 downto 0);
            barramento_controle : out std_logic_vector(10 downto 0)
        ); 
    end component;
    
    signal s_dec2cu, scuinit : std_logic_vector(10 downto 0) := (others => '0');
    signal s_reg2dec : std_logic_vector(7 downto 0) := (others => '0');
    signal sRI_rw : std_logic;
    
    
begin

    u_reg8MD : reg08bitC port map(barr_DI, clk, '1', cl, sRI_rw, s_reg2dec);
    
    u_decod : DEC port map(s_reg2dec, s_dec2cu);
    
    u_cuinit : CU_INIT port map(clk, cl, interface_flags, s_dec2cu, scuinit);

    barr_inc  <= scuinit(10);
    barr_PC   <= scuinit(9);
    ULA_op    <= scuinit(8 downto 6);
    PC_rw     <= scuinit(5);
    AC_rw     <= scuinit(4);
    MEM_rw    <= scuinit(3);
    REM_rw    <= scuinit(2);
    RDM_rw    <= scuinit(1);
    sRI_rw    <= scuinit(0);
    

end architecture;
