
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegisterTemp IS PORT(
    Entrada1, Entrada2 : in std_LOGIC_VECTOR(15 downto 0);
	 clr, w1, w2: IN STD_LOGIC;
    clk : IN STD_LOGIC;
    Saida1, Saida2 , Saida3, Saida4: out std_LOGIC_VECTOR(15 downto 0)
);
END RegisterTemp;

ARCHITECTURE comportamento OF RegisterTemp IS
signal EntradaR1, EntradaR2, EntradaR3, R1,R2,R3: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
component Registrador16 IS PORT(
    d   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    w  : IN STD_LOGIC;
    clr : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end component;

begin

	RegR1 : Registrador16 port map (Entrada1, w1, clr, clk, R1);

	RegR2 : Registrador16 port map (Entrada2, w2, clr, clk, R2);
	
	Saida1 <= R1;

	Saida2 <= R2;
			
	Saida3 <= R1;
				
	Saida4 <= R2;



end comportamento;



