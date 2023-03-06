library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_MID is
    port(
        barramento : inout std_logic_vector(7 downto 0);
        ULA_op : in std_logic_vector(2 downto 0);
        AC_rw, MEM_rw, clk, cl : in std_logic;
        interface_flags : out std_logic_vector(1 downto 0)
    );
end entity;

architecture comuta of ULA_MID is

    component ULA_INIT is
        port(
            x, y : in std_logic_vector(7 downto 0);
            ULA_op : in std_logic_vector(2 downto 0);
            resultado : out std_logic_vector(7 downto 0);
            nz : out std_logic_vector(1 downto 0)
        );
    end component;
    
    component reg08bitC is
        port(
            datain  : in std_logic_vector(7 downto 0);
            clk     : in std_logic;
            pr, cl  : in std_logic;        
            write   : in std_logic;
            dataout : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component reg02bitC is
        port(
            datain   : in std_logic_vector(1 downto 0);
            clk      : in std_logic;
            pr, cl   : in std_logic;
            write    : in std_logic;
            dataout  : out std_logic_vector(1 downto 0)
        );
    end component;
    
    signal s_ac2ula, s_ula2ac : std_logic_vector(7 downto 0) := (others => '0');
    signal s_ac2flag : std_logic_vector(1 downto 0) := (others => '0'); 
    signal s_interface_flags : std_logic_vector(1 downto 0) := (others => '0'); 
    
begin

    u_ulaINIT : ULA_INIT port map(s_ac2ula, barramento, ULA_op, s_ula2ac, s_ac2flag);
    
    barramento <= s_ac2ula when MEM_rw = '1' else (others => 'Z');
    
    u_regAC : reg08bitC port map(s_ula2ac, clk, '1', cl, AC_rw, s_ac2ula);
    
    u_flags : reg02bitC port map(s_ac2flag,  clk, '1', cl, AC_rw, s_interface_flags);
    
    interface_flags <= s_interface_flags;

end architecture;
