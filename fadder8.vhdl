library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity fadder8 is
    port(
        a, b : in std_logic_vector(7 downto 0);
        cin  : in std_logic;
        s    : out std_logic_vector(7 downto 0);
        cout : out std_logic
    );
end fadder8;

architecture behavior_tb of fadder8 is
    component fadder1 is
        port(
            a, b : in std_logic;
            cin  : in std_logic;
            s    : out std_logic;
            cout : out std_logic
        );
    end component fadder1;
    
    signal carry : std_logic_vector(7 downto 1);

begin
    f0 : fadder1 port map(a(0), b(0), cin, s(0), carry(1));   
    
    f1 : fadder1 port map(a(1), b(1), carry(1), s(1), carry(2));   
    f2 : fadder1 port map(a(2), b(2), carry(2), s(2), carry(3));
    f3 : fadder1 port map(a(3), b(3), carry(3), s(3), carry(4));
    f4 : fadder1 port map(a(4), b(4), carry(4), s(4), carry(5));   
    f5 : fadder1 port map(a(5), b(5), carry(5), s(5), carry(6));
    f6 : fadder1 port map(a(6), b(6), carry(6), s(6), carry(7));

    f7 : fadder1 port map(a(7), b(7), carry(7), s(7), cout);
    
end architecture behavior_tb;









