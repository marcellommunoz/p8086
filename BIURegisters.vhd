
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BIURegisters IS PORT(
	--entrada de 16 bits nos registradores de memoria.
    entradaADB, entradaMemoria 															: IN STD_LOGIC_VECTOR(15 downto 0);
	 --wsel seleciona qual registrador escrever. ControleSaida seleciona qual registrador vai sair em qual saida.
    wselADB, wselMem																			: IN std_logic_vector(2 downto 0);
	 ControlesaidaADB																			: IN std_logic_vector(1 downto 0);
	 ControleLogicalAddress																	: IN STD_LOGIC_vector(3 downto 0);
	 --clock, clear assincrono e sinais de escrita.
    clk,clr, wADB, wMem																		: IN STD_LOGIC;
	 --tres saidas de 16 bits
    SegmentBase, Offset , saidaADB														: OUT STD_LOGIC_VECTOR(15 downto 0)
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
	selCS <= (NOT(wADB AND (not wselADB(2)) and NOT(wselADB(1)) AND NOT(wselADB(0)))) OR (wMem AND (not wselMem(2)) and NOT(wselMem(1)) AND NOT(wselMem(0)));
   with selCS select 
        EntradaCS <=   entradaADB when '0',
                       entradaMemoria when '1';
							  
	WCS <= (wADB and (not wselADB(2)) and (not wselADB(1)) and (not wselADB(0))) or (wMem and (not wselMem(2)) and (not wselMem(1)) and (not wselMem(0)));
	RegCS : Registrador16 port map (EntradaCS, WCS, clr, clk, CS);
	--000
	
	selDS <= (NOT(wADB AND (not wselADB(2)) and NOT(wselADB(1)) AND wselADB(0))) OR (wMem AND (not wselMem(2)) and NOT(wselMem(1)) AND wselMem(0));
   with selDS select 
        EntradaDS <=    entradaADB when '0',
                       entradaMemoria when '1';
							  
	WDS <= (wADB and (not wselADB(2)) and (not wselADB(1)) and wselADB(0)) or (wMem and (not wselMem(2)) and (not wselMem(1)) and wselMem(0));
	RegDS : Registrador16 port map (EntradaDS, WDS, clr, clk, DS);
	
	--001
	selSS <= (NOT(wADB AND (not wselADB(2)) and (wselADB(1)) AND NOT(wselADB(0)))) OR (wMem AND (not wselMem(2)) and (wselMem(1)) AND NOT(wselMem(0)));
   with selSS select 
        EntradaSS <=     entradaADB when '0',
                       entradaMemoria when '1';
	WSS <= (wADB and (not wselADB(2)) and wselADB(1) and(not wselADB(0))) or (wMem and (not wselMem(2)) and wselMem(1) and(not wselMem(0)));
	RegSS : Registrador16 port map (EntradaSS, WSS, clr, clk, SS);
	--010
	selES <= (NOT(wADB AND (not wselADB(2)) and (wselADB(1)) AND (wselADB(0)))) OR (wMem AND (not wselMem(2)) and (wselMem(1)) AND (wselMem(0)));
   with selES select 
        EntradaES <=   entradaADB when '0',
                       entradaMemoria when '1';
	WES<= (wADB and (not wselADB(2)) and wselADB(1) and wselADB(0))or (wMem and (not wselMem(2)) and wselMem(1) and wselMem(0));
	RegES : Registrador16 port map (EntradaES, WES, clr, clk, ES);
	--011
	selIP <= (NOT(wADB AND ( wselADB(2)) and not (wselADB(1)) AND NOT(wselADB(0)))) OR (wMem AND ( wselMem(2)) and not(wselMem(1)) AND NOT(wselMem(0)));
   with selIP select 
        EntradaIP <=     entradaADB when '0',
                       entradaMemoria when '1';
	WIP<=  (wADB and wselADB(2) and (not wselADB(1)) and (not wselADB(0))) or(wMem and wselMem(2) and (not wselMem(1)) and (not wselMem(0)));
	RegIP : Registrador16 port map (EntradaIP, WIP, clr, clk, IP);
	
	--100
	
	selInternal1 <= (NOT(wADB AND ( wselADB(2)) and not (wselADB(1)) AND (wselADB(0)))) OR (wMem AND ( wselMem(2)) and not(wselMem(1)) AND (wselMem(0)));
   with selInternal1 select 
        EntradaInternal1 <=     entradaADB when '0',
                       entradaMemoria when '1';
	WInternal1<=  (wADB and wselADB(2) and (not wselADB(1)) and wselADB(0)) or (wMem and wselMem(2) and (not wselMem(1)) and wselMem(0));
	RegInternal1 : Registrador16 port map (EntradaInternal1, WInternal1, clr, clk, Internal1);
	--101
	
	selInternal2 <= (NOT(wADB AND wselADB(2) and wselADB(1) AND not (wselADB(0)))) OR (wMem AND wselMem(2) and wselMem(1) AND not(wselMem(0)));
   with selInternal2 select 
        EntradaInternal2 <=   entradaADB when '0',
										entradaMemoria when '1';
	WInternal2<=  (wADB and wselADB(2) and wselADB(1) and (not wselADB(0))) or (wMem and wselMem(2) and wselMem(1) and (not wselMem(0)));
	RegInternal2 : Registrador16 port map (EntradaInternal2, WInternal2, clr, clk, Internal2);
	-- 110
	
	selInternal3 <= (NOT(wADB AND ( wselADB(2)) and (wselADB(1)) AND (wselADB(0)))) OR (wMem AND ( wselMem(2)) and (wselMem(1)) AND (wselMem(0)));
   with selInternal3 select 
        EntradaInternal3 <=     entradaADB when '0',
                       entradaMemoria when '1';
	WInternal3<=  (wADB and wselADB(2) and wselADB(1) and wselADB(0))or(wMem and wselMem(2) and wselMem(1) and wselMem(0));
	RegInternal3 : Registrador16 port map (EntradaInternal3, WInternal3, clr, clk, Internal3);
	--111
	
	with ControleLogicalAddress select
		SegmentBase <= 
							--NULL
							Internal3 when "0000",
							--Instruction Fetch
							CS when "0001",
							--Stack Operation
							SS when "0010",
							--String Destination
							ES when "0011",
							--Variable Default: DS 
							DS when "0100",
							--Variable Alternate: CS
							CS when "0101",
							--Variable Alternate: ES
							ES when "0110",
							--Variable Alternate: SS
							SS when "0111",
							--String Source Default: DS 
							DS when "1000",
							--String Source Alternate: CS
							CS when "1001",
							--String Source Alternate: ES
							ES when "1010",
							--String Source Alternate: SS
							SS when "1011",
							--BP Default: SS 
							SS when "1100",
							--BP Alternate: CS
							CS when "1101",
							--BP Alternate: DS
							DS when "1110",
							--BP Alternate: ES
							ES when "1111";
	with ControleLogicalAddress select	
		Offset <= 
					--NULL
					internal3 	when "0000",
					--Instruction Fetch
					IP 			when "0001",
					--Other Address Calculations
					Internal1 	when others;
			
	if ControleLogicalAddress = "0001" then
		IP <= IP+1;
	end if;
	
	with ControlesaidaADB select
		saidaADB <= 
						Internal1 when "00",
						Internal2 when "01",
						internal3 when others;

end comportamento;