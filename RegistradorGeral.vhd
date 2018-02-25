LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegistradorGeral IS PORT(
    entrada1, entrada2   																				: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	 wsel1, wsel2, rsel1, rsel2 																		: IN 	STD_LOGIC_VECTOR(3 downto 0);
    w1, w2, clk, clr  																					: IN 	STD_LOGIC;
    saida1, saida2   																					: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 wDEBUG																									: IN 	STD_LOGIC;
	 eDebugAX, eDebugBX, eDebugCX, eDebugDX, eDebugSP, eDebugBP, eDebugDI, eDebugSI	: IN 	STD_LOGIC_VECTOR(15 downto 0);
	 sDebugAX, sDebugBX, sDebugCX, sDebugDX, sDebugSP, sDebugBP, sDebugDI, sDebugSI	: OUT STD_LOGIC_VECTOR(15 downto 0)
);
END RegistradorGeral;

ARCHITECTURE description OF RegistradorGeral IS
SIGNAL entradaAH, entradaAL, entradaBH, entradaBL, entradaCH, entradaCL, entradaDH, entradaDL 	: std_logic_vector(7 downto 0);
SIGNAL entradaSP, entradaBP, entradaDI, entradaSI																: std_logic_vector(15 downto 0);
SIGNAL saidaAH, saidaAL, saidaBH, saidaBL, saidaCH, saidaCL, saidaDH, saidaDL 						: std_logic_vector(7 downto 0);
SIGNAL saidaSP, saidaBP, saidaDI, saidaSI																			: std_logic_vector(15 downto 0);
SIGNAL wAH, wAL, wBH, wBL, wCH, wCL, wDH, wDL, wSP, wBP, wDI, wSI											: std_logic;
SIGNAL selAH, selAL, selBH, selBL, selCH, selCL, selDH, selDL, selSP, selBP, selDI, selSI			: std_logic_vector(1 downto 0);
COMPONENT Registrador16
	PORT(
	d  	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
   w  	: IN STD_LOGIC;
   clr 	: IN STD_LOGIC;
   clk 	: IN STD_LOGIC;
   q   	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;
COMPONENT Registrador8 
	PORT(
    d   	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    w  	: IN STD_LOGIC;
    clr 	: IN STD_LOGIC;
    clk 	: IN STD_LOGIC;
    q   	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN

	--AH = 0001
	wAH	<= wDEBUG or ((	w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0)));
	selAH(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0))) OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	selAH(1) <= wDEBUG;
	with selAH select 
		entradaAH <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugAX(15 downto 8) when others;
    AH: Registrador8 port map(entradaAH, wAH, clr, clk, saidaAH);
	 
	--AL = 0000
	wAL	<= wDEBUG or ((	w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND NOT(wsel1(0))) OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND NOT(wsel2(0))));
	selAL(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND NOT(wsel1(0))))OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND NOT(wsel2(0)));
	selAL(1) <= wDEBUG;
	with selAL select 
		entradaAL <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugAX(7 downto 0) when others;
    AL: Registrador8 port map(entradaAL, wAL, clr, clk, saidaAL);
	 
	 --BH = 0011
	 wBH	<= wDEBUG or (( w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND wsel2(0)));
	selBH(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND wsel1(0))) 	OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND wsel2(0));
	selBH(1) <= wDEBUG;
	with selBH select 
		entradaBH <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugBX(15 downto 8) when others;
    BH: Registrador8 port map(entradaBH, wBH, clr, clk, saidaBH);
	 
	 --BL = 0010
	 wBL	<= wDEBUG or (( w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND NOT(wsel1(0))) 	OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND NOT(wsel2(0))));
	selBL(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND NOT(wsel1(0)))) OR (w2 AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND NOT(wsel2(0)));
	selBL(1)	<=	wDEBUG;
	with selBL select 
		entradaBL <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugBX(7 downto 0) when others;
    BL: Registrador8 port map(entradaBL, wBL, clr, clk, saidaBL);
	 
	 --CH = 0101
	 wCH	<= wDEBUG or ((	w1 AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND wsel2(0)));
	selCH(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND wsel1(0))) 	OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND wsel2(0));
	selCH(1) <= wDEBUG;
	with selCH select 
		entradaCH <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugCX(15 downto 8) when others;
    CH: Registrador8 port map(entradaCH, wCH, clr, clk, saidaCH);
	 
	 --CL = 0100
	 wCL	<= wDEBUG or ((	w1 AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND NOT(wsel1(0))) 	OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND NOT(wsel2(0))));
	selCL(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND NOT(wsel2(0)));
	selCL(1) <= wDEBUG;
	with selCL select 
		entradaCL <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugCX(7 downto 0) when others;
    CL: Registrador8 port map(entradaCL, wCL, clr, clk, saidaCL);
	 
	 --DH = 0111
	 wDH	<= wDEBUG or ((	w1 AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND wsel2(0)));
	selDH(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND wsel1(0))) 	OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND wsel2(0));
	selDH(1) <= wDEBUG; 
	with selDH select 
		entradaDH <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugDX(15 downto 8) when others;
    DH: Registrador8 port map(entradaDH, wDH, clr, clk, saidaDH);
	 
	 --DL = 0110
	 wDL	<= wDEBUG or ((	w1 AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND NOT(wsel1(0))) 	OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND NOT(wsel2(0))));
	selDL(0)	<=	(NOT(	w1 AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND NOT(wsel1(0)))) 	OR (w2 AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND NOT(wsel2(0)));
	selDL(1) <= wDEBUG;
	with selDL select 
		entradaDL <= 	entrada1 when "00",
							entrada2 when "01",
							eDebugDX(7 downto 0) when others;
    DL: Registrador8 port map(entradaDL, wDL, clr, clk, saidaDL);
	 
	 --AX = 1000
	 --BX = 1001
	 --CX = 1010
	 --DX = 1011
	 
	 --SP = 1100
	wSP <= wDEBUG or ((w1 AND wsel1(3) AND wsel1(2) AND NOT(wsel1(1)) AND NOT(wsel1(0)))AND (w2 AND wsel2(3) AND wsel2(2) AND NOT(wsel2(1)) AND NOT(wsel2(0))));
	with wDEBUG select 
		entradaSP <= 	entrada2&entrada1 when '0',
							eDebugSP 			when others;
   SP: Registrador16 port map(entradaSP, wSP, clr, clk, saidaSP);
	 
	--BP = 1101
	wBP			<= wDEBUG or ((w1 AND wsel1(3) AND wsel1(2) AND NOT(wsel1(1)) AND wsel1(0)) 		AND (w2 AND wsel2(3) AND wsel2(2) AND NOT(wsel2(1)) AND wsel2(0)));
	with wDEBUG select 
		entradaBP <= 	entrada2&entrada1 when '0',
							eDebugBP 			when others;
   BP: Registrador16 port map(entradaBP, wBP, clr, clk, saidaBP);
	 
	 --SI = 1110
	wSI			<= wDEBUG or (((w1 AND wsel1(3) AND wsel1(2) AND wsel1(1) AND NOT(wsel1(0))) 		AND (w2 AND wsel2(3) AND wsel2(2) AND wsel2(1) AND NOT(wsel2(0)))));
	with wDEBUG select 
		entradaSI <= 	entrada2&entrada1 when '0',
							eDebugSI 			when others;
   SI: Registrador16 port map(entradaSI, wSI, clr, clk, saidaSI);
	 
	 --DI = 1111
	wDI			<= wDEBUG or ((w1 AND wsel1(3) AND wsel1(2) AND wsel1(1) AND wsel1(0)) 			AND (w2 AND wsel2(3) AND wsel2(2) AND wsel2(1) AND wsel2(0)));
	with wDEBUG select 
		entradaDI <= 	entrada2&entrada1 when '0',
							eDebugDI 			when others;
   DI: Registrador16 port map(entradaDI, wDI, clr, clk, saidaDI);
	 
	with rsel1 select 
		saida1 <= 	
					saidaAL when "0000",
					saidaAH when "0001",
					saidaBL when "0010",
					saidaBH when "0011",
					saidaCL when "0100",
					saidaCH when "0101",
					saidaDL when "0110",
					saidaDH when "0111",
					saidaAL when "1000",
					saidaBL when "1001",
					saidaCL when "1010",
					saidaDL when "1011",
					saidaSP(7 downto 0) when "1100",
					saidaBP(7 downto 0) when "1101",
					saidaSI(7 downto 0) when "1110",
					saidaDI(7 downto 0) when "1111";
												
	with rsel2 select 
		saida2 <= 	
					saidaAL when "0000",
					saidaAH when "0001",
					saidaBL when "0010",
					saidaBH when "0011",
					saidaCL when "0100",
					saidaCH when "0101",
					saidaDL when "0110",
					saidaDH when "0111",
					saidaAH when "1000",
					saidaBH when "1001",
					saidaCH when "1010",
					saidaDH when "1011",
					saidaSP(15 downto 8) when "1100",
					saidaBP(15 downto 8) when "1101",
					saidaSI(15 downto 8) when "1110",
					saidaDI(15 downto 8) when "1111";
	
	sDebugAX <= saidaAH&saidaAL;
	sDebugBX <= saidaBH&saidaBL;
	sDebugCX <= saidaCH&saidaDL;
	sDebugDX <= saidaDH&saidaDL;
	sDebugSP <= saidaSP;
	sDebugBP <= saidaBP;
	sDebugSI <= saidaSI;
	sDebugDI <= saidaDI;
	 
END description;