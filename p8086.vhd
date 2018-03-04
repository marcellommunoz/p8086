library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity p8086 is
  port (
	clock 	: in std_logic;
	reset 	: in std_logic;
	wDEBUG	: in std_logic;
   entradaAX, entradaBX, entradaCX, entradaDX, entradaSP, entradaBP, entradaDI, entradaSI	: in  std_logic_vector(15 downto 0);
	entradaCS, entradaDS, entradaSS, entradaES, entradaIP, entradaI1, entradaI2, entradaI3	: in  std_logic_vector(15 downto 0);
	saidaAX, saidaBX, saidaCX, saidaDX, saidaSP, saidaBP, saidaDI, saidaSI						: out std_logic_vector(15 downto 0);
	saidaCS, saidaDS, saidaSS, saidaES, saidaIP, saidaI1, saidaI2, saidaI3						: out std_logic_vector(15 downto 0);
	saidaIQ, saidaMem							 																	: out std_logic_vector(7 downto 0);
	SControlInRG1, SControlInRG2,	SControlOutRG1,	SControlOutRG2									: out std_logic_vector(3 downto 0);--debug
	SControlwRG1, 	SControlwRG2, 	SControlwRT1,	SControlwRT2										: out std_logic;--debug
	saidaQueueVazia, saidaQueueW, saidaQueueR, saidaQueueFull										: out std_logic
    );
end p8086;
 --controle = sinais de escrita e leitura; selecao = escolher entre varias entradas ou saidas; entrada e saida = sinal que liga dois componente; flags = sinais que sai dos componentes.
architecture description of p8086 is
signal	IPatual																								:	std_logic_vector(15 downto 0);
--entradas e saidas do RG
signal	ADBtoRG																								:	std_logic_vector(15 downto 0);
signal	RGtoADB1, RGtoADB2																				:	std_logic_vector(7 downto 0);
--sinais RB
signal	ADBtoRB, BCLtoRB																					:	std_logic_vector(15 downto 0);
signal	control_InRB1, control_InRB2, control_OutRB1, control_OutRB2, control_OutRB3	:	std_logic_vector(2 downto 0);
signal 	control_wRB1, control_wRB2																		: 	std_logic;
signal	RBtoADB, RBtoAB, RBtoBCL																		: 	std_logic_vector(15 downto 0);
signal	control_IPpp																						:	std_logic;
--sinais AB
signal 	ABtoBCL																								:	std_logic_vector(19 downto 0);
signal 	IPpp																									:	std_logic_vector(15 downto 0);
--sinais BCL
signal	BCLtoIQ																								:	std_logic_vector(7 downto 0);
--sinais IQ
signal	control_rQueue																						:	std_logic;
signal	control_wQueue																						:	std_logic;
signal	control_QueueFull																					:	std_logic;
signal	control_QueueEmpty																				:	std_logic;
signal	IQtoECS																								:	std_logic_vector(7 downto 0);
--controle de entrada e saida do RG
signal	control_InRG1, control_InRG2, control_OutRG1, control_OutRG2						:	std_logic_vector(3 downto 0);
--sinal de escrita do RG
signal	control_wRG1, control_wRG2																		:	std_logic;
--entradas e saidas do RT
signal	ADBtoRT1, ADBtoRT2, RTtoADB1, RTtoADB2, RTtoULA1, RTtoULA2							:	std_logic_vector(15 downto 0);
--sinal de escrita do RG
signal	control_wRT1, control_wRT2																		:	std_logic;
--sinal de escrita FR
signal	control_wFR																							:	std_logic;
--entradas e saidas do FR
signal	FRout, FRin																							:	std_logic_vector(15 downto 0);
--controle de operacao ULA
signal	control_OpULA																						:	std_logic_vector(7 downto 0);
--saida da ULA
signal	ULAtoADB																								: std_logic_vector(15 downto 0);
--controle de entrada no ADB
signal	control_InADB																						:	std_logic_vector(2 downto 0);
--entrada e saidas do ADB

component RegistradorGeral  	IS PORT(
    entrada1, entrada2   																				: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	 wsel1, wsel2, rsel1, rsel2 																		: IN 	STD_LOGIC_VECTOR(3 downto 0);
    w1, w2, clk, clr  																					: IN 	STD_LOGIC;
    saida1, saida2   																					: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 wDEBUG																									: IN 	STD_LOGIC;
	 eDebugAX, eDebugBX, eDebugCX, eDebugDX, eDebugSP, eDebugBP, eDebugDI, eDebugSI	: IN 	STD_LOGIC_VECTOR(15 downto 0);
	 sDebugAX, sDebugBX, sDebugCX, sDebugDX, sDebugSP, sDebugBP, sDebugDI, sDebugSI	: OUT STD_LOGIC_VECTOR(15 downto 0)
);
end component;

component BIURegisters  		IS PORT(
   Entrada1, Entrada2 																												: IN std_LOGIC_VECTOR(15 downto 0);
    wsel1, wsel2, ControleSaida1, ControleSaida2, ControleSaida3														: IN STD_LOGIC_VECTOR(2 downto 0);
    clr, w1, w2																														: IN STD_LOGIC;
    clk 																																	: IN STD_LOGIC;
    S1, S2 , S3																														: OUT std_LOGIC_VECTOR(15 downto 0);
	 WriteDebug 																														: IN STD_LOGIC;
	 EDebugCS, EDebugDS, EDebugSS, EDebugES, EDebugIP, EDebugInternal1, EDebugInternal2, EDebugInternal3 	: IN STD_LOGIC_VECTOR(15 downto 0);
	 SDebugCS, SDebugDS, SDebugSS, SDebugES, SDebugIP, SDebugInternal1, SDebugInternal2, SDebugInternal3 	: OUT STD_LOGIC_VECTOR(15 downto 0);
	 IPppw																																: IN STD_LOGIC;
	 IPpp																																	: IN STD_LOGIC_VECTOR(15 downto 0)
	 );
end component;

component RegisterTemp 			IS PORT(
		 Entrada1, Entrada2 					: IN std_LOGIC_VECTOR(15 downto 0);
		 clr, w1, w2							: IN STD_LOGIC;
		 clk 										: IN STD_LOGIC;
		 Saida1, Saida2 , Saida3, Saida4	: OUT std_LOGIC_VECTOR(15 downto 0)
);
end component;

component DataBus 				IS PORT(
		InControl 								: IN std_LOGIC_VECTOR(2 downto 0);
		TemporalReg1, TemporalReg2 		: IN std_LOGIC_VECTOR(15 downto 0);
		GeneralReg								: IN std_LOGIC_VECTOR(15 downto 0);
		ULA, Flags								: IN std_LOGIC_VECTOR(15 downto 0);
		SGeneral									: OUT std_LOGIC_VECTOR(15 downto 0);
		STemp1, STemp2							: OUT std_LOGIC_VECTOR(15 downto 0)
);
end component;

component ULA 						IS PORT(
		 clk										: IN std_logic;
		 Controle 								: IN std_logic_vector(7 downto 0);
		 Operando1, Operando2, Flags		: IN std_logic_vector(15 downto 0);
		 SExtra, SFlags						: OUT std_logic_vector(15 downto 0)
	);
end component;

component Registrador16 		IS PORT(
			d										: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			w  									: IN STD_LOGIC;
			clr									: IN STD_LOGIC;
			clk									: IN STD_LOGIC;
			q  									: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	 );
end component;
component InstructionQueue		IS PORT(
			reset 								: IN STD_LOGIC;
			clk     								: IN STD_LOGIC;
			w   									: IN STD_LOGIC;
			entrada 								: IN STD_LOGIC_VECTOR(7 downto 0);
			cheio   								: OUT STD_LOGIC;
			r  									: IN STD_LOGIC;
			saida 								: OUT STD_LOGIC_VECTOR(7 downto 0);
			vazio   								: OUT STD_LOGIC
			);
end component;
component EU_Control_System 	IS PORT(
			reset 													: in std_logic;
			clk     													: in std_logic;
			 QueueVazia												: in std_logic;
			 entradaInstrucao 									: in  std_logic_vector(7 downto 0);
			 entradaRG1, entradaRG2, saidaRG1, saidaRG2	: out std_logic_vector(3 downto 0);
			 LeituraQueue											: out std_logic;
			 sinalEscritaRG1, sinalEscritaRG2 				: out std_logic;
			 saidaDataBUS											: out std_logic_vector(2 downto 0);
			 sinalEscritaRT1, sinalEscritaRT2 				: out std_logic;
			 WFlag													: out std_logic;
			 OPULA													: out std_logic_vector(7 downto 0);
			 saidaBR1												: out std_logic_vector(2 downto 0)
			 );
end component;
component AddressBus				IS PORT(
			SegmentBase, Offset 	: IN STD_LOGIC_VECTOR(15 downto 0);
			IP							: IN STD_LOGIC_VECTOR(15 downto 0);
			Address 					: OUT STD_LOGIC_VECTOR(19 downto 0);
			IPpp						: OUT STD_LOGIC_VECTOR(15 downto 0));
end component;
component MemoriaSimples 		IS PORT(
			Dado														: IN std_LOGIC_VECTOR(15 downto 0);
			Ender														: IN std_LOGIC_VECTOR(19 downto 0);
			clk, reset												: IN STD_LOGIC;
			QueueFull 												: IN std_LOGIC;
			EscritaQueue 											: OUT std_LOGIC;
			IncrementaPC 											: OUT std_Logic;
			ControleBIURegister1, ControleBIURegister2 	: OUT std_logic_vector(2 downto 0);
			SaidaQueue												: OUT std_LOGIC_VECTOR(7 downto 0);
			SaidaRegs												: OUT std_LOGIC_VECTOR(15 downto 0)
		);
end component;
begin
	--Registradores utilizados para acesso a memoria
	RB:	BIURegisters 			port map(
												ADBtoRB, BCLtoRB,
												control_InRB1, control_InRB2, control_OutRB1, control_OutRB2, control_OutRB3,
												reset, control_wRB1, control_wRB2,
												clock,
												RBtoADB, RBtoAB, RBtoBCL,
												wDEBUG,
												entradaCS, entradaDS, entradaSS, entradaES, entradaIP, entradaI1, entradaI2, entradaI3,
												saidaCS, saidaDS, saidaSS, saidaES, IPatual, saidaI1, saidaI2, saidaI3,
												control_IPpp,
												IPpp);
	--Gera o endereço para memoria
	AB:	AddressBus				port map(
												RBtoAB, RBtoBCL,
												IPatual,
												ABtoBCL,
												IPpp);
	--Memoria
	BCL:	MemoriaSimples			port map(
												RBtoBCL,
												ABtoBCL,
												clock, reset,
												control_QueueFull,
												control_wQueue,
												control_IPpp,
												Control_OutRB2, Control_OutRB3,
												BCLtoIQ,
												BCLtoRB
												);
	--Fila de instructionQueue
	IQ:	InstructionQueue		port map(
												reset,
												clock,
												control_wQueue,
												BCLtoIQ,
												control_QueueFull,
												control_rQueue,
												IQtoECS,
												control_QueueEmpty
												);
	saidaMem <= BCLtoIQ;
	saidaIQ <= IQtoECS;
	saidaQueueVazia <= control_QueueEmpty;
	saidaQueueFull	 <= control_QueueFull;
	saidaQueueW		 <= control_wQueue;
	saidaQueueR		 <= control_rQueue;
	--Controle do processador
	ECS:	EU_Control_System		port map(
												reset,
												clock,
												control_QueueEmpty,
												IQtoECS,
												control_InRG1, control_InRG2, Control_OutRG1, control_OutRG2,
												control_rQueue,
												control_wRG1, control_wRG2,
												control_InADB,
												control_wRT1, control_wRT2,
												control_wFR,
												control_OpULA,
												control_OutRB1
												);
	SControlInRG1 <= Control_InRG1;
	SControlInRG2 <= Control_InRG2;
	SControlOutRG1 <= Control_OutRG1;
	SControlOutRG2 <= Control_OutRG2;
	SControlwRG1 <= Control_wRG1;
	SControlwRG2 <= Control_wrG2;
	SControlwRT1 <= Control_wRT1;
	SControlwRT2 <= Control_wrT2;
				 
	--Registradores de proposito geral
	RG:	RegistradorGeral 		port map(
												ADBtoRG(15 downto 8), ADBtoRG(7 downto 0),
												control_InRG1, control_InRG2, control_OutRG1, control_OutRG2,
												control_wRG1, control_wRG2, clock, reset,
												RGtoADB1, RGtoADB2,
												wDEBUG,
												entradaAX, entradaBX, entradaCX, entradaDX, entradaSP, entradaBP, entradaDI, entradaSI,
												saidaAX, saidaBX, saidaCX, saidaDX, saidaSP, saidaBP, saidaDI, saidaSI
												);
	--Registradores dos operandos da ULA
	RT:	RegisterTemp 			port map(
												ADBtoRT1, ADBtoRT2,
												reset, control_wRT1, control_wRT2,
												clock, 
												RTtoADB1, RTtoADB2, RTtoULA1, RTtoULA2);
	--barramento da ULA
	ADB:	DataBus 					port map(
												control_InADB,
												RTtoADB1, RTtoADB2,
												RGtoADB1 & RGtoADB2,
												ULAtoADB, FRout,
												ADBtoRG,
												ADBtoRT1, ADBtoRT2);											
	--ULA.											
	ALU:	ULA 						port map(
												clock,
												control_OpULA,
												RTtoULA1, RTtoULA2, FRout,
												ULAtoADB, FRin
												);
	
	--Registrador de Flags.
	FR:	Registrador16			port map(
												FRin,
												control_wFR,
												reset,
												clock,
												FRout);
	saidaIP <= IPAtual;
end description;