
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BIURegisters IS PORT(
	--entrada de 16 bits nos registradores de memoria.
    Entrada1, Entrada2 															: IN STD_LOGIC_VECTOR(15 downto 0);
	 --wsel seleciona qual registrador escrever. ControleSaida seleciona qual registrador vai sair em qual saida.
    wsel1, wsel2, ControleSaida1, ControleSaida2, ControleSaida3	: IN STD_LOGIC_vector(2 downto 0);
	 --clock, clear assincrono e sinais de escrita.
    clk,clr, w1, w2																: IN STD_LOGIC;
	 --tres saidas de 16 bits
    Saida1, Saida2 , Saida3													: OUT STD_LOGIC_VECTOR(15 downto 0)
);
END BIURegisters;

ARCHITECTURE comportamento OF BIURegisters IS
	signal CS, DS, SS, ES, IP, Internal1, Internal2, Internal3 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal EntradaCS, EntradaDS, EntradaSS, EntradaES, EntradaIP, EntradaInternal1, EntradaInternal2, EntradaInternal3: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal WCS, WDS, WSS, WES, WIP, WInternal1, WInternal2, WInternal3: STD_LOGIC;
	signal selCS, selDS , selSS , selES , selIP , selInternal1 , selInternal2 , selInternal3 : std_LOGIC;
component Registrador16 IS PORT(
    d   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    w  : IN STD_LOGIC;
    clr : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end component;

begin
	selCS <= (NOT(w1 AND (not wsel1(2)) and NOT(wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND (not wsel2(2)) and NOT(wsel2(1)) AND NOT(wsel2(0)));
   with selCS select 
        EntradaCS <=   entrada1 when '0',
                       entrada2 when '1';
							  
	WCS <= (w1 and (not wsel1(2)) and (not Wsel1(1)) and (not Wsel1(0))) or (w2 and (not wsel2(2)) and (not Wsel2(1)) and (not Wsel2(0)));
	RegCS : Registrador16 port map (EntradaCS, WCS, clr, clk, CS);
	--000
	
	selDS <= (NOT(w1 AND (not wsel1(2)) and NOT(wsel1(1)) AND wsel1(0))) OR (w2 AND (not wsel2(2)) and NOT(wsel2(1)) AND wsel2(0));
   with selDS select 
        EntradaDS <=    entrada1 when '0',
                       entrada2 when '1';
							  
	WDS <= (w1 and (not wsel1(2)) and (not wsel1(1)) and wsel1(0)) or (w2 and (not wsel2(2)) and (not wsel2(1)) and wsel2(0));
	RegDS : Registrador16 port map (EntradaDS, WDS, clr, clk, DS);
	
	--001
	selSS <= (NOT(w1 AND (not wsel1(2)) and (wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND (not wsel2(2)) and (wsel2(1)) AND NOT(wsel2(0)));
   with selSS select 
        EntradaSS <=     entrada1 when '0',
                       entrada2 when '1';
	WSS <= (w1 and (not wsel1(2)) and Wsel1(1) and(not Wsel1(0))) or (w2 and (not wsel2(2)) and Wsel2(1) and(not Wsel2(0)));
	RegSS : Registrador16 port map (EntradaSS, WSS, clr, clk, SS);
	--010
	selES <= (NOT(w1 AND (not wsel1(2)) and (wsel1(1)) AND (wsel1(0)))) OR (w2 AND (not wsel2(2)) and (wsel2(1)) AND (wsel2(0)));
   with selES select 
        EntradaES <=   entrada1 when '0',
                       entrada2 when '1';
	WES<= (w1 and (not wsel1(2)) and Wsel1(1) and Wsel1(0))or (w2 and (not wsel2(2)) and Wsel2(1) and Wsel2(0));
	RegES : Registrador16 port map (EntradaES, WES, clr, clk, ES);
	--011
	selIP <= (NOT(w1 AND ( wsel1(2)) and not (wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND ( wsel2(2)) and not(wsel2(1)) AND NOT(wsel2(0)));
   with selIP select 
        EntradaIP <=     entrada1 when '0',
                       entrada2 when '1';
	WIP<=  (w1 and wsel1(2) and (not Wsel1(1)) and (not Wsel1(0))) or(w2 and wsel2(2) and (not Wsel2(1)) and (not Wsel2(0)));
	RegIP : Registrador16 port map (EntradaIP, WIP, clr, clk, IP);
	
	--100
	
	selInternal1 <= (NOT(w1 AND ( wsel1(2)) and not (wsel1(1)) AND (wsel1(0)))) OR (w2 AND ( wsel2(2)) and not(wsel2(1)) AND (wsel2(0)));
   with selInternal1 select 
        EntradaInternal1 <=     entrada1 when '0',
                       entrada2 when '1';
	WInternal1<=  (w1 and wsel1(2) and (not Wsel1(1)) and Wsel1(0)) or (w2 and wsel2(2) and (not Wsel2(1)) and Wsel2(0));
	RegInternal1 : Registrador16 port map (EntradaInternal1, WInternal1, clr, clk, Internal1);
	--101
	
	selInternal2 <= (NOT(w1 AND wsel1(2) and wsel1(1) AND not (wsel1(0)))) OR (w2 AND wsel2(2) and wsel2(1) AND not(wsel2(0)));
   with selInternal2 select 
        EntradaInternal2 <=   entrada1 when '0',
										entrada2 when '1';
	WInternal2<=  (w1 and wsel1(2) and Wsel1(1) and (not Wsel1(0))) or (w2 and wsel2(2) and Wsel2(1) and (not Wsel2(0)));
	RegInternal2 : Registrador16 port map (EntradaInternal2, WInternal2, clr, clk, Internal2);
	-- 110
	
	selInternal3 <= (NOT(w1 AND ( wsel1(2)) and (wsel1(1)) AND (wsel1(0)))) OR (w2 AND ( wsel2(2)) and (wsel2(1)) AND (wsel2(0)));
   with selInternal3 select 
        EntradaInternal3 <=     entrada1 when '0',
                       entrada2 when '1';
	WInternal3<=  (w1 and wsel1(2) and Wsel1(1) and Wsel1(0))or(w2 and wsel2(2) and Wsel2(1) and Wsel2(0));
	RegInternal3 : Registrador16 port map (EntradaInternal3, WInternal3, clr, clk, Internal3);
	--111
	
	with controleSaida1 select
		Saida1 <= CS when "000",
				DS when "001",
				SS when "010",
				ES when "011",
				IP when "100",
				Internal1 when "101",
				Internal2 when "110",
				Internal3 when "111";
		
	with controleSaida2 select
		Saida2 <= CS when "000",
			DS when "001",
			SS when "010",
			ES when "011",
			IP when "100",
			Internal1 when "101",
			Internal2 when "110",
			Internal3 when "111";
			
	with controleSaida3 select
		Saida3 <= CS when "000",
			DS when "001",
			SS when "010",
			ES when "011",
			IP when "100",
			Internal1 when "101",
			Internal2 when "110",
			Internal3 when "111";

end comportamento;