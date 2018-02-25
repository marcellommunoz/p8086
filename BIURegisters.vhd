
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BIURegisters IS PORT(
    Entrada1, Entrada2 , EDebugCS, EDebugDS, EDebugSS, EDebugES, EDebugIP, EDebugInternal1, EDebugInternal2, EDebugInternal3: in std_LOGIC_VECTOR(15 downto 0);
    wsel1, wsel2, ControleSaida1, ControleSaida2, ControleSaida3: IN STD_LOGIC_vector(2 downto 0);
    clr, w1, w2, WriteDebug: IN STD_LOGIC;
    clk : IN STD_LOGIC;
    S1, S2 , S3, SDebugCS, SDebugDS, SDebugSS, SDebugES, SDebugIP, SDebugInternal1, SDebugInternal2, SDebugInternal3: out std_LOGIC_VECTOR(15 downto 0)
);
END BIURegisters;

ARCHITECTURE comportamento OF BIURegisters IS
	signal CS, DS, SS, ES, IP, Internal1, Internal2, Internal3 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal EntradaCS, EntradaDS, EntradaSS, EntradaES, EntradaIP, EntradaInternal1, EntradaInternal2, EntradaInternal3: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal WCS, WDS, WSS, WES, WIP, WInternal1, WInternal2, WInternal3: std_LOGIC;
	signal WcsOrWAll, WdsOrWAll, WssOrWAll, WesOrWAll, WipOrWAll, Winternal1OrWAll, Winternal2OrWAll, Winternal3OrWAll: std_LOGIC;
	signal selCS, selDS , selSS , selES , selIP , selInternal1 , selInternal2 , selInternal3 : std_LOGIC_vector(1 downto 0);
	
component Registrador16 IS PORT(
    d   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    w  : IN STD_LOGIC;
    clr : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end component;

begin
	selCS(0) <= (NOT(w1 AND (not wsel1(2)) and NOT(wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND (not wsel2(2)) and NOT(wsel2(1)) AND NOT(wsel2(0)));
	selCS(1) <= WriteDebug;
   with selCS select 
        EntradaCS <=   entrada1 when "00",
                       entrada2 when "01",
							  EDebugCS when others;
							  
	WCS <= (w1 and (not wsel1(2)) and (not Wsel1(1)) and (not Wsel1(0))) or (w2 and (not wsel2(2)) and (not Wsel2(1)) and (not Wsel2(0)));
	WcsOrWAll <= WCS or  WriteDebug;
	RegCS : Registrador16 port map (EntradaCS, WcsOrWAll, clr, clk, CS);
	--000
	
	selDS(0) <= (NOT(w1 AND (not wsel1(2)) and NOT(wsel1(1)) AND wsel1(0))) OR (w2 AND (not wsel2(2)) and NOT(wsel2(1)) AND wsel2(0));
	selDS(1) <= WriteDebug;
   with selDS select 
        EntradaDS <=   entrada1 when "00",
                       entrada2 when "01",
							  EDebugDS when others;
							  
	WDS <= (w1 and (not wsel1(2)) and (not wsel1(1)) and wsel1(0)) or (w2 and (not wsel2(2)) and (not wsel2(1)) and wsel2(0));
	WdsOrWAll <= WDS or  WriteDebug;
	RegDS : Registrador16 port map (EntradaDS, WdsOrWAll, clr, clk, DS);
	
	--001
	selSS(0) <= (NOT(w1 AND (not wsel1(2)) and (wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND (not wsel2(2)) and (wsel2(1)) AND NOT(wsel2(0)));
	selSS(1) <= WriteDebug;
   with selSS select 
        EntradaSS <=   entrada1 when "00",
                       entrada2 when "01",
							  EDebugSS when others;
							  
	WSS <= (w1 and (not wsel1(2)) and Wsel1(1) and(not Wsel1(0))) or (w2 and (not wsel2(2)) and Wsel2(1) and(not Wsel2(0)));
	WssOrWAll <= WSS or  WriteDebug;
	RegSS : Registrador16 port map (EntradaSS, WssOrWAll, clr, clk, SS);
	--010
	
	selES(0) <= (NOT(w1 AND (not wsel1(2)) and (wsel1(1)) AND (wsel1(0)))) OR (w2 AND (not wsel2(2)) and (wsel2(1)) AND (wsel2(0)));
	selES(1) <= WriteDebug;
   with selES select 
        EntradaES <=   entrada1 when "00",
                       entrada2 when "01",
							  EDebugES when others;
							  
	WES<= (w1 and (not wsel1(2)) and Wsel1(1) and Wsel1(0))or (w2 and (not wsel2(2)) and Wsel2(1) and Wsel2(0));
	WesOrWAll <= WES or  WriteDebug;
	RegES : Registrador16 port map (EntradaES, WesOrWAll, clr, clk, ES);
	
	--011
	selIP(0) <= (NOT(w1 AND ( wsel1(2)) and not (wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND ( wsel2(2)) and not(wsel2(1)) AND NOT(wsel2(0)));
	selIP(1) <= WriteDebug;
   with selIP select 
        EntradaIP <=   entrada1 when "00",
                       entrada2 when "01",
							  EDebugIP when others;
							  
	WIP<=  (w1 and wsel1(2) and (not Wsel1(1)) and (not Wsel1(0))) or(w2 and wsel2(2) and (not Wsel2(1)) and (not Wsel2(0)));
	WipOrWAll <= WIP or  WriteDebug;
	RegIP : Registrador16 port map (EntradaIP, WipOrWAll, clr, clk, IP);
	--100
	
	selInternal1(0) <= (NOT(w1 AND ( wsel1(2)) and not (wsel1(1)) AND (wsel1(0)))) OR (w2 AND ( wsel2(2)) and not(wsel2(1)) AND (wsel2(0)));
	selInternal1(1) <= WriteDebug;
   with selInternal1 select 
        EntradaInternal1 <=   entrada1 when "00",
										entrada2 when "01",
										EDebugInternal1 when others;
										
	WInternal1<=  (w1 and wsel1(2) and (not Wsel1(1)) and Wsel1(0)) or (w2 and wsel2(2) and (not Wsel2(1)) and Wsel2(0));
	WInternal1OrWAll <= WInternal1 or  WriteDebug;
	RegInternal1 : Registrador16 port map (EntradaInternal1, WInternal1orWAll, clr, clk, Internal1);
	--101
	
	selInternal2(0) <= (NOT(w1 AND wsel1(2) and wsel1(1) AND not (wsel1(0)))) OR (w2 AND wsel2(2) and wsel2(1) AND not(wsel2(0)));
	selInternal2(1) <= WriteDebug;
   with selInternal2 select 
        EntradaInternal2 <=   entrada1 when "00",
										entrada2 when "01",
										EDebugInternal2 when others;
	WInternal2<=  (w1 and wsel1(2) and Wsel1(1) and (not Wsel1(0))) or (w2 and wsel2(2) and Wsel2(1) and (not Wsel2(0)));
	WInternal2OrWAll <= WInternal2 or  WriteDebug;
	RegInternal2 : Registrador16 port map (EntradaInternal2, WInternal2OrWAll, clr, clk, Internal2);
	-- 110
	
	selInternal3(0) <= (NOT(w1 AND ( wsel1(2)) and (wsel1(1)) AND (wsel1(0)))) OR (w2 AND ( wsel2(2)) and (wsel2(1)) AND (wsel2(0)));
	selInternal3(1) <= WriteDebug;
   with selInternal3 select 
        EntradaInternal3 <=   entrada1 when "00",
										entrada2 when "01",
										EDebugInternal3 when others;
										
	WInternal3<=  (w1 and wsel1(2) and Wsel1(1) and Wsel1(0))or(w2 and wsel2(2) and Wsel2(1) and Wsel2(0));
	WInternal3OrWAll <= WInternal3 or  WriteDebug;
	RegInternal3 : Registrador16 port map (EntradaInternal3, WInternal3orWAll, clr, clk, Internal3);
	--111
	
	with controleSaida1 select
		S1 <= CS when "000",
				DS when "001",
				SS when "010",
				ES when "011",
				IP when "100",
				Internal1 when "101",
				Internal2 when "110",
				Internal3 when "111";
		
	with controleSaida2 select
		S2 <= CS when "000",
				DS when "001",
				SS when "010",
				ES when "011",
				IP when "100",
				Internal1 when "101",
				Internal2 when "110",
				Internal3 when "111";
			
	with controleSaida3 select
		S3 <= CS when "000",
				DS when "001",
				SS when "010",
				ES when "011",
				IP when "100",
				Internal1 when "101",
				Internal2 when "110",
				Internal3 when "111";
	
	SDebugCS <= CS;
	SDebugDS <= DS;
	SDebugSS <= SS;
	SDebugES <= ES;
	SDebugIP <= IP;
	SDebugInternal1 <= Internal1;
	SDebugInternal2 <= Internal2;
	SDebugInternal3 <= Internal3;
	

end comportamento;