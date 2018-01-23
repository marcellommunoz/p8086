LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegistradoresP86 IS PORT(
    entrada1, entrada2   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 wsel1, wsel2, rsel1, rsel2 :IN STD_LOGIC_VECTOR(4 downto 0);
    w1, w2, clk, clr  : IN STD_LOGIC;
    saida1, saida2   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END RegistradoresP86;

ARCHITECTURE description OF RegistradoresP86 IS
SIGNAL entradaAH, entradaAL, entradaBH, entradaBL, entradaCH, entradaCL, entradaDH, entradaDL : std_logic_vector(7 downto 0);
SIGNAL entradaSP, entradaBP, entradaDI, entradaSI, entradaIP, entradaCS, entradaDS, entradaES, entradaSS: std_logic_vector(15 downto 0);
SIGNAL saidaAH, saidaAL, saidaBH, saidaBL, saidaCH, saidaCL, saidaDH, saidaDL : std_logic_vector(7 downto 0);
SIGNAL saidaSP, saidaBP, saidaDI, saidaSI, saidaIP, saidaCS, saidaDS, saidaES, saidaSS: std_logic_vector(15 downto 0);
SIGNAL wAH, wAL, wBH, wBL, wCH, wCL, wDH, wDL, wSP, wBP, wDI, wSI, wIP, wCS, wDS, wES, wSS: std_logic;
SIGNAL selAH, selAL, selBH, selBL, selCH, selCL, selDH, selDL, selSP, selBP, selDI, selSI: std_logic;
COMPONENT Registrador16
	PORT(
	d   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
   w  : IN STD_LOGIC;
   clr : IN STD_LOGIC;
   clk : IN STD_LOGIC;
   q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;
COMPONENT Registrador8 
	PORT(
    d   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    w  : IN STD_LOGIC;
    clr : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN

	--AH = 00001
	wAH	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	selAH	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0))) OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	with selAH select 
		entradaAH <= 	entrada1 when '0',
							entrada2 when '1';
    AH: Registrador8 port map(entradaAH, wAH, clr, clk, saidaAH);
	 
	--AL = 00000
	wAL	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND NOT(wsel1(0))) OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND NOT(wsel2(0)));
	selAL	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND NOT(wsel1(0))))OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND NOT(wsel2(0)));
	with selAL select 
		entradaAL <= 	entrada1 when '0',
							entrada2 when '1';
    AL: Registrador8 port map(entradaAL, wAL, clr, clk, saidaAL);
	 
	 --BH = 00011
	 wBH	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND wsel2(0));
	selBH	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND wsel1(0))) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND wsel2(0));
	with selBH select 
		entradaBH <= 	entrada1 when '0',
							entrada2 when '1';
    BH: Registrador8 port map(entradaBH, wBH, clr, clk, saidaBH);
	 
	 --BL = 00010
	 wBL	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND NOT(wsel1(0))) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND NOT(wsel2(0)));
	selBL	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND wsel1(1) AND NOT(wsel1(0)))) OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND wsel2(1) AND NOT(wsel2(0)));
	with selBL select 
		entradaBL <= 	entrada1 when '0',
							entrada2 when '1';
    BL: Registrador8 port map(entradaBL, wBL, clr, clk, saidaBL);
	 
	 --CH = 00101
	 wCH	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND wsel2(0));
	selCH	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND wsel1(0))) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND wsel2(0));
	with selCH select 
		entradaCH <= 	entrada1 when '0',
							entrada2 when '1';
    CH: Registrador8 port map(entradaCH, wCH, clr, clk, saidaCH);
	 
	 --CL = 00100
	 wCL	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND NOT(wsel1(0))) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND NOT(wsel2(0)));
	selCL	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND NOT(wsel1(1)) AND NOT(wsel1(0)))) OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND NOT(wsel2(1)) AND NOT(wsel2(0)));
	with selCL select 
		entradaCL <= 	entrada1 when '0',
							entrada2 when '1';
    CL: Registrador8 port map(entradaCL, wCL, clr, clk, saidaCL);
	 
	 --DH = 00111
	 wDH	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND wsel1(0)) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND wsel2(0));
	selDH	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND wsel1(0))) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND wsel2(0));
	with selDH select 
		entradaDH <= 	entrada1 when '0',
							entrada2 when '1';
    DH: Registrador8 port map(entradaDH, wDH, clr, clk, saidaDH);
	 
	 --DL = 00110
	 wDL	<= (		w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND NOT(wsel1(0))) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND NOT(wsel2(0)));
	selDL	<=	(NOT(	w1 AND NOT(wsel1(4)) AND NOT(wsel1(3)) AND wsel1(2) AND wsel1(1) AND NOT(wsel1(0)))) 	OR (w2 AND NOT(wsel2(4)) AND NOT(wsel2(3)) AND wsel2(2) AND wsel2(1) AND NOT(wsel2(0)));
	with selDL select 
		entradaDL <= 	entrada1 when '0',
							entrada2 when '1';
    DL: Registrador8 port map(entradaDL, wDL, clr, clk, saidaDL);
	 
	 --AX = 1000
	 --BX = 1001
	 --CX = 1010
	 --DX = 1011
	 
	 --SP = 01100
	wSP			<= (w1 AND NOT(wsel1(4)) AND wsel1(3) AND wsel1(2) AND NOT(wsel1(1)) AND NOT(wsel1(0)))AND (w2 AND NOT(wsel2(4)) AND wsel2(3) AND wsel2(2) AND NOT(wsel2(1)) AND NOT(wsel2(0)));
	entradaSP 	<= 	entrada2&entrada1;				
   SP: Registrador16 port map(entradaSP, wSP, clr, clk, saidaSP);
	 
	--BP = 01101
	wBP			<= (w1 AND NOT(wsel1(4)) AND wsel1(3) AND wsel1(2) AND NOT(wsel1(1)) AND wsel1(0)) 		AND (w2 AND NOT(wsel2(4)) AND wsel2(3) AND wsel2(2) AND NOT(wsel2(1)) AND wsel2(0));
	entradaBP 	<= 	entrada2&entrada1;
   BP: Registrador16 port map(entradaBP, wBP, clr, clk, saidaBP);
	 
	 --SI = 01110
	wSI			<= (w1 AND NOT(wsel1(4)) AND wsel1(3) AND wsel1(2) AND wsel1(1) AND NOT(wsel1(0))) 		AND (w2 AND NOT(wsel2(4)) AND wsel2(3) AND wsel2(2) AND wsel2(1) AND NOT(wsel2(0)));
	entradaSI 	<= 	entrada2&entrada1;						
   SI: Registrador16 port map(entradaSI, wSI, clr, clk, saidaSI);
	 
	 --DI = 01111
	wDI			<= (w1 AND NOT(wsel1(4)) AND wsel1(3) AND wsel1(2) AND wsel1(1) AND wsel1(0)) 			AND (w2 AND NOT(wsel2(4)) AND wsel2(3) AND wsel2(2) AND wsel2(1) AND wsel2(0));
	entradaDI 	<= 	entrada2&entrada1;
   DI: Registrador16 port map(entradaDI, wDI, clr, clk, saidaDI);
	
	--IP = 10000
	wIP	<= (		w1 AND wsel1(4) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND wsel2(4) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	entradaIP <= entrada2&entrada1;
   IP: Registrador16 port map(entradaIP, wIP, clr, clk, saidaIP);
	
	--CS = 10001
	wCS	<= (		w1 AND wsel1(4) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND wsel2(4) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	entradaCS <= entrada2&entrada1;
   CS: Registrador16 port map(entradaCS, wCS, clr, clk, saidaCS);
	
	--DS = 10010
	wDS	<= (		w1 AND wsel1(4) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND wsel2(4) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	entradaDS <= entrada2&entrada1;
   DS: Registrador16 port map(entradaDS, wDS, clr, clk, saidaDS);
	
	--ES = 10011
	wES	<= (		w1 AND wsel1(4) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND wsel2(4) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	entradaES <= entrada2&entrada1;
   ES: Registrador16 port map(entradaES, wES, clr, clk, saidaES);
	
	--SS = 10100
	wSS	<= (		w1 AND wsel1(4) AND NOT(wsel1(3)) AND NOT(wsel1(2)) AND NOT(wsel1(1)) AND wsel1(0)) 	OR (w2 AND wsel2(4) AND NOT(wsel2(3)) AND NOT(wsel2(2)) AND NOT(wsel2(1)) AND wsel2(0));
	entradaSS <= entrada2&entrada1;
   SS: Registrador16 port map(entradaSS, wSS, clr, clk, saidaSS);
	
	with rsel1 select 
		saida1 <= 	
					saidaAL 					when "00000",
					saidaAH 					when "00001",
					saidaBL 					when "00010",
					saidaBH 					when "00011",
					saidaCL 					when "00100",
					saidaCH 					when "00101",
					saidaDL 					when "00110",
					saidaDH 					when "00111",
					saidaAL 					when "01000",
					saidaBL 					when "01001",
					saidaCL 					when "01010",
					saidaDL 					when "01011",
					saidaSP(7 downto 0) 	when "01100",
					saidaBP(7 downto 0) 	when "01101",
					saidaSI(7 downto 0) 	when "01110",
					saidaDI(7 downto 0) 	when "01111",
					saidaIP(7 downto 0) 	when "10000",
					saidaCS(7 downto 0) 	when "10001",
					saidaDS(7 downto 0) 	when "10010",
					saidaES(7 downto 0) 	when "10011",
					saidaSS(7 downto 0) 	when others;
												
	with rsel2 select 
		saida2 <= 	
					saidaAL 					when "00000",
					saidaAH 					when "00001",
					saidaBL 					when "00010",
					saidaBH 					when "00011",
					saidaCL 					when "00100",
					saidaCH 					when "00101",
					saidaDL 					when "00110",
					saidaDH 					when "00111",
					saidaAL 					when "01000",
					saidaBL 					when "01001",
					saidaCL 					when "01010",
					saidaDL 					when "01011",
					saidaSP(15 downto 8)	when "01100",
					saidaBP(15 downto 8) when "01101",
					saidaSI(15 downto 8) when "01110",
					saidaDI(15 downto 8) when "01111",
					saidaIP(15 downto 8) when "10000",
					saidaCS(15 downto 8) when "10001",
					saidaDS(15 downto 8) when "10010",
					saidaES(15 downto 8) when "10011",
					saidaSS(15 downto 8) when others;
	 
END description;