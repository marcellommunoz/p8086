
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegisterTemp IS PORT(
    Entrada1, Entrada2 : in std_LOGIC_VECTOR(15 downto 0);
    wsel1, wsel2, ControleSaida1, ControleSaida2, ControleSaida3, ControleSaida4: IN STD_LOGIC_vector(1 downto 0);
    clr, w1, w2: IN STD_LOGIC;
    clk : IN STD_LOGIC;
    S1, S2 , S3, S4: out std_LOGIC_VECTOR(15 downto 0)
);
END RegisterTemp;

ARCHITECTURE comportamento OF RegisterTemp IS

signal EntradaR1, EntradaR2, EntradaR3, R1,R2,R3: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal selR1, selR2, selR3, WR1,WR2,WR3 : std_LOGIC;
	
component Registrador16 IS PORT(
    d   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    w  : IN STD_LOGIC;
    clr : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end component;

begin
	--00
	selR1 <= (NOT(w1 AND (not wsel1(1)) and NOT(wsel1(0)))) OR (w2 AND (not wsel2(1)) and NOT(wsel2(0)));
   with selR1 select 
        EntradaR1 <=   entrada1 when '0',
                       entrada2 when '1';
							  
	WR1 <= ((w1 AND (not wsel1(1)) and NOT(wsel1(0))) OR (w2 AND (not wsel2(1)) and NOT(wsel2(0))));
	RegR1 : Registrador16 port map (EntradaR1, WR1, clr, clk, R1);

	--01	
	--selR2 <= not(w1 AND (not wsel1(1)) and (wsel1(0))) OR (w2 AND ((not wsel2(1)) and (wsel2(0))));
	selR2 <= (not w1 AND (not wsel1(1)) and (wsel1(0))) OR (w2 AND ((not wsel2(1)) and (wsel2(0))));
   with selR2 select 
        EntradaR2 <=   entrada1 when '0',
                       entrada2 when '1';
							  
	WR2 <= ((w1 AND (not wsel1(1)) and NOT(wsel1(0))) OR (w2 AND (not wsel2(1)) and (wsel2(0))));
	RegR2 : Registrador16 port map (EntradaR2, WR2, clr, clk, R2);
	
	--10
	selR3 <= (NOT(w1 AND (not wsel1(1)) and NOT(wsel1(0)))) OR (w2 AND  wsel2(1) and NOT(wsel2(0)));
   with selR3 select 
        EntradaR3 <=   entrada1 when '0',
                       entrada2 when '1';
							  
	WR3 <= ((w1 AND (not wsel1(1)) and NOT(wsel1(0))) OR (w2 AND  wsel2(1) and NOT(wsel2(0))));
	RegR3 : Registrador16 port map (EntradaR3, WR3, clr, clk, R3);
	
	
	with controleSaida1 select
		S1 <= R1 when "00",
				R2 when "01",
				R3 when "10",
				"0000000000000000" when "11";

		
	with controleSaida2 select
		S2 <= R1 when "00",
				R2 when "01",
				R3 when "10",
				"0000000000000000" when "11";
			
	with controleSaida3 select
		S3 <=  R1 when "00",
				R2 when "01",
				R3 when "10",
				"0000000000000000" when "11";
				
	
	with controleSaida4 select
		S4 <=  R1 when "00",
				R2 when "01",
				R3 when "10",
				"0000000000000000" when "11";
			



end comportamento;



