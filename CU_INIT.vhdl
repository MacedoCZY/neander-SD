library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CU_INIT is
    port(
        clk, cl : in std_logic;
        interface_flags : in std_logic_vector(1 downto 0);
        dex2uc : in std_logic_vector(10 downto 0);
        barramento_controle : out std_logic_vector(10 downto 0)
    ); 
end entity;

architecture comuta of CU_INIT is
 
    component contador is
        port(
            clk, rst, cl : in std_logic;
            v            : out std_logic_vector(2 downto 0)
        );
    end component;
    
    component NOP is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component STA is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component LDA is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component ADD is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component oOR is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component aAND is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component nNOT is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component JMP is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component JNZ is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
    component HLT is
        port(
            ciclo : in std_logic_vector(2 downto 0);
            barr_inc, barr_PC : out std_logic; 
            ULA_op : out std_logic_vector(2 downto 0);
            PC_rw, AC_rw, MEM_rw, REM_rw, RDM_rw, RI_rw : out std_logic
        );
    end component;
    
   signal scount2op : std_logic_vector(2 downto 0) := (others => '0'); 
   
   signal snop, ssta, slda, sadd, sor, sand, snot, sjmp, sjnz, shlt : std_logic_vector(10 downto 0) := (others => '0');
   
   signal sjnescolha, sjzescolha, smuxespec : std_logic_vector(10 downto 0) := (others => '0');
    
begin

    u_contador : contador port map(clk, cl, '1', scount2op);
    
    u_nop : NOP port map(scount2op, snop(10), snop(9), snop(8 downto 6), snop(5), snop(4), snop(3), snop(2), snop(1), snop(0));
    
    u_sta : STA port map(scount2op, ssta(10), ssta(9), ssta(8 downto 6), ssta(5), ssta(4), ssta(3), ssta(2), ssta(1), ssta(0));
    
    u_lda : LDA port map(scount2op, slda(10), slda(9), slda(8 downto 6), slda(5), slda(4), slda(3), slda(2), slda(1), slda(0));
    
    u_add : ADD port map(scount2op, sadd(10), sadd(9), sadd(8 downto 6), sadd(5), sadd(4), sadd(3), sadd(2), sadd(1), sadd(0));
    
    u_or : oOR port map(scount2op, sor(10), sor(9), sor(8 downto 6), sor(5), sor(4), sor(3), sor(2), sor(1), sor(0));
    
    u_and : aAND port map(scount2op, sand(10), sand(9), sand(8 downto 6), sand(5), sand(4), sand(3), sand(2), sand(1), sand(0));
    
    u_not : nNOT port map(scount2op, snot(10), snot(9), snot(8 downto 6), snot(5), snot(4), snot(3), snot(2), snot(1), snot(0));
    
    u_jmp : JMP port map(scount2op, sjmp(10), sjmp(9), sjmp(8 downto 6), sjmp(5), sjmp(4), sjmp(3), sjmp(2), sjmp(1), sjmp(0));
    
    u_jnz : JNZ port map(scount2op, sjnz(10), sjnz(9), sjnz(8 downto 6), sjnz(5), sjnz(4), sjnz(3), sjnz(2), sjnz(1), sjnz(0));
    
    u_hlt : HLT port map(scount2op, shlt(10), shlt(9), shlt(8 downto 6), shlt(5), shlt(4), shlt(3), shlt(2), shlt(1), shlt(0));
    
    sjnescolha <= sjmp when interface_flags(1) = '1' else sjnz when interface_flags(1) = '0';
    
    sjzescolha <= sjmp when interface_flags(0) = '1' else sjnz when interface_flags(0) = '0';
    
    smuxespec <= snop when dex2uc(10) = '1' else
                 ssta when dex2uc(9)  = '1' else
                 slda when dex2uc(8)  = '1' else
                 sadd when dex2uc(7)  = '1' else 
                  sor when dex2uc(6)  = '1' else
                 sand when dex2uc(5)  = '1' else
                 snot when dex2uc(4)  = '1' else
                 sjmp when dex2uc(3)  = '1' else
           sjnescolha when dex2uc(2)  = '1' else
           sjzescolha when dex2uc(1)  = '1' else
                 shlt when dex2uc(0)  = '1' else (others => 'Z');
    
    barramento_controle <= smuxespec;
    
end architecture;
