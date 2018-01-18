library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity p8086 is
  port (
	clock 	: in std_logic;
	reset 	: in std_logic;
   entrada 	: in  std_logic_vector(15 downto 0);
   saida 	: out std_logic_vector(15 downto 0)
    );
end p8086;
 --controle = sinais de escrita e leitura; selecao = escolher entre varias entradas ou saidas; entrada e saida = sinal que liga dois componente; flags = sinais que sai dos componentes.
architecture description of p8086 is
--saida IQ para a entrada do ECS
signal IQtoECSandADB																												: std_logic_vector(7 downto 0);
--selecao para as estradas do RG, de saida para o RG e de saida para a ADB.
signal control_InRG1, control_InRG2, control_OutRG1, control_OutRG2, control_OutADB							: std_logic_vector(3 downto 0);
--controle para escrita no RG.
signal control_wRG1, control_wRG2																							: std_logic;
--saida da ADB para as entradas do RG.
signal ADBtoRG																														: std_logic_vector(15 downto 0);
--saida dos RG para entrada do ADB.
signal RG1toADB, RG2toADB																										: std_logic_vector(7 downto 0);
--saida do ADB para a entrada do RT.
signal ADBtoRT1, ADBtoRT2																										: std_logic_vector(15 downto 0);
--selecao da entrada de RT e saida
signal control_InRT1, control_InRT2, control_OutRT1, control_OutRT2, control_OutRT3, control_OutRT4	: std_logic_vector(1 downto 0);
--controle para escrita no RT.
signal control_wRT1, control_wRT2																							: std_logic;
--saida do RT para entrada da ULA e da ADB.
signal RTtoADB1, RTtoADB2, RTtoULA1, RTtoULA2																			: std_logic_vector(15 downto 0);
--controle escrita e leitura na IQ.
signal control_wIQ, control_rIQ 																								: std_logic;
--instrucao BSL para o IQ.
signal BSLtoIQ																														: std_logic_vector(7 downto 0);
--flags IQ.
signal flag_IQFull, flag_IQEmpty																								: std_logic;
--selecao para as entradas do ADB.
signal control_InADB 																											: std_logic_vector(2 downto 0);
--saida BR para a entrada ADB.
signal BRtoADB, ULAtoADB																										: std_logic_vector(15 downto 0);
--saida da FR para entrada ADB.
signal FRtoADBandULA 																											: std_logic_vector(15 downto 0);
--saida da ADB to BR.
signal ADBtoBR 																													: std_logic_vector(15 downto 0);
--controle de sub ou add ULA.
signal control_ADDSUBULA																										: std_logic;
--controle da operacao da ULA.
signal control_OPULA																												: std_logic_vector;
--saida da ULA para o ADB e o FR.
signal ULAtoADB, ULAtoFR																										: std_logic_vector(15 downto 0);
--saida de dados da BR.
signal DATABUS 																													: std_logic_vector(15 downto 0);
--saida do endereco da ADDRESBUS.
signal ADDRESBUS 																													: std_logic_vector(19 downto 0);
--controle de escrita na memoria e de se e dados.
signal control_wMEM, control_dMEM 																							: std_logic;
--saida do BSL para o BR
signal BSLtoBR 																													: std_logic_vector(15 downto 0);
component EU_Control_System 	IS PORT(
    reset 						: in std_logic;
    clk     					: in std_logic;
    entradaInstrucao 		: in  std_logic_vector(7 downto 0);
	 entradaRG1, entradaRG2, saidaRG1, saidaRG2	: out std_logic_vector(3 downto 0);
	 saidaDataBUS				: out std_logic_vector(2 downto 0)
    );
end component;

component RegistradorGeral 	IS PORT(
    entrada1, entrada2   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 wsel1, wsel2, rsel1, rsel2 :IN STD_LOGIC_VECTOR(3 downto 0);
    w1, w2, clk, clr  : IN STD_LOGIC;
    saida1, saida2   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
end component;

component RegisterTemp 			IS PORT(
    Entrada1, Entrada2 : in std_LOGIC_VECTOR(15 downto 0);
    wsel1, wsel2, ControleSaida1, ControleSaida2, ControleSaida3, ControleSaida4: IN STD_LOGIC_vector(1 downto 0);
    clr, w1, w2: IN STD_LOGIC;
    clk : IN STD_LOGIC;
    S1, S2 , S3, S4: out std_LOGIC_VECTOR(15 downto 0)
);
end component;
   
component InstructionQueue 	IS PORT(
    reset 	: in std_logic;
    clk     : in std_logic;
    w   			:in  std_logic;
    entrada 	: in  std_logic_vector(7 downto 0);
    cheio   	: out std_logic;
    r   : in  std_logic;
    saida : out std_logic_vector(7 downto 0);
    vazio   : out std_logic;
    );
end component;

component DataBus 				IS PORT(
	 InControl : in std_LOGIC_VECTOR(2 downto 0);
    TemporalReg1, TemporalReg2 : in std_LOGIC_VECTOR(15 downto 0);
	 GeneralReg, BIURegs: in std_LOGIC_VECTOR(15 downto 0);
	 ULA, Flags: in std_LOGIC_VECTOR(15 downto 0);
	 InstructionQueue: in std_LOGIC_VECTOR(15 downto 0);
	 SGeneral, SBIURegs: out std_LOGIC_VECTOR(15 downto 0);
	 STemp1, STemp2: out std_LOGIC_VECTOR(15 downto 0)
);
end component;

component BusControlLogic 		IS PORT(
	 Dado: in std_LOGIC_VECTOR(15 downto 0);
	 Ender: in std_LOGIC_VECTOR(19 downto 0);
    clk, w, ControleDadIns: IN STD_LOGIC;
	 SaidaQueue: out std_LOGIC_VECTOR(7 downto 0);
    SaidaRegs: out std_LOGIC_VECTOR(15 downto 0)
);
end component;

component AddressBus 			IS PORT(
    A, B : in std_logic_vector(15 downto 0);
	 Flag, clk: in std_logic;
	 controle : in std_logic_vector(1 downto 0);
	 Saida : out std_logic_vector(19 downto 0)
);
end component;

component BIURegisters 			IS PORT(
	--entrada de 16 bits nos registradores de memoria.
    Entrada1, Entrada2 															: IN STD_LOGIC_VECTOR(15 downto 0);
	 --wsel seleciona qual registrador escrever. ControleSaida seleciona qual registrador vai sair em qual saida.
    wsel1, wsel2, ControleSaida1, ControleSaida2, ControleSaida3	: IN STD_LOGIC_vector(2 downto 0);
	 --clock, clear assincrono e sinais de escrita.
    clk,clr, w1, w2																: IN STD_LOGIC;
	 --tres saidas de 16 bits
    Saida1, Saida2 , Saida3													: OUT STD_LOGIC_VECTOR(15 downto 0)
);
end component;

component ULA 						IS PORT(
		clk, ADDSUB: in std_logic;
		Controle : in std_logic_vector(7 downto 0);
		Operando1, Operando2, Flags: in std_logic_vector(15 downto 0);
		SOperando1, SOperando2, SFlags, SExtra: out std_logic_vector(15 downto 0)
	);
end component;

component Registrador16 		IS PORT(
			d	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			w  : IN STD_LOGIC;
			clr: IN STD_LOGIC;
			clk: IN STD_LOGIC;
			q  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	 );
end component;
begin
	--falta signals de escrita no RG
	ECS:	EU_Control_System 	port map(
												reset,
												clock,
												IQtoECSandADB,
												control_InRG1, control_InRG2, control_OutRG1, control_OutRG2,
												control_OutADB);
	--Registradores da maquina
	RG:	RegistradorGeral 		port map(
												ADBtoRG(15 downto 8), ADBtoRG(7 downto 0),
												control_InRG1, control_InRG2, control_OutRG1, control_OutRG2,
												control_wRG1, control_wRG2, clock, reset,
												RG1toADB, RG2toADB);
	--Registradores dos operandos
	RT:	RegisterTemp 			port map(
												ADBtoRT1, ADBtoRT2,
												control_InRT1, control_InRT2, control_OutRT1, control_OutRT2, control_OutRT3, control_OutRT4,
												reset, control_wRT1, control_wRT2,
												clock, 
												RTtoADB1, RTtoADB2, RTtoULA1, RTtoULA2);
	--Fila de Instrucoes
	--talvez tenha reescrito algo errado.
	IQ:	InstructionQueue 		port map(
												reset,
												clock,
												control_wIQ,
												BSLtoIQ,
												flag_IQFull,
												control_rIQ,
												IQtoECSandADB,
												flag_IQEmpty);
	--barramento da ula
	--IQtoECSandADB talvez cause um bug por causa do jeito que foi implementado a fila
	ADB:	DataBus 					port map(
												control_InADB,
												RTtoADB1, RTtoADB2,
												RG1toADB&RG2toADB, BRtoADB,
												ULAtoADB, FRtoADBandULA
												IQtoECSandADB,
												ADBtoRG, ADBtoBR,
												ADBtoRT1, ADBtoRT2);
																							
	--barramento I/O
	BSL:	BusControlLogic 		port map(
													DATABUS,
													ADDRESBUS,
													clock, control_wMEM, control_dMEM,
													BSLtoIQ,
													BSLtoBr,
													);
	--ULA.											
	ALU:	ULA 						port map(
												clock, control_ADDSUBULA,
												control_OPULA,
												RTtoULA1, RTtoULA2, FRtoADBandULA,
												ULAtoADB, ULAtoFR
												);
	
	--Registrador de Flags.
	FR: Registrador16				port map(
												ULAtoFR,
												control_wFR,
												reset,
												clock,
												FRtoADBandULA);
	
end description;