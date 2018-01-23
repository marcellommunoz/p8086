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

--entradas e saidas do RG
signal	ADBtoRG																			:	std_logic_vector(15 downto 0);
signal	RGtoADB1, RGtoADB2															:	std_logic_vector(7 downto 0);
--controle de entrada e saida do RG
signal	control_InRG1, control_InRG2, control_OutRG1, control_OutRG2	:	std_logic_vector(4 downto 0);
--sinal de escrita do RG
signal	control_wRG1, control_wRG2													:	std_logic;
--entradas e saidas do RT
signal	ADBtoRT1, ADBtoRT2, RTtoADB1, RTtoADB2, RTtoULA1, RTtoULA2		:	std_logic_vector(15 downto 0);
--sinal de escrita do RG
signal	control_wRT1, control_wRT2													:	std_logic;
--sinal de escrita FR
signal	control_wFR																		:	std_logic;
--entradas e saidas do FR
signal	FRout, FRin																		:	std_logic_vector(15 downto 0);
--controle de operacao ULA
signal	control_OpULA																	:	std_logic_vector(7 downto 0);
--saida da ULA
signal	ULAtoADB																			: std_logic_vector(15 downto 0);
--controle de entrada no ADB
signal	control_InADB																	:	std_logic_vector(2 downto 0);
--entrada e saidas do ADB

component RegistradoresP86  	IS PORT(
    entrada1, entrada2   					: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	 wsel1, wsel2, rsel1, rsel2 			: IN STD_LOGIC_VECTOR(4 downto 0);
    w1, w2, clk, clr  						: IN STD_LOGIC;
    saida1, saida2   						: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
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
		InControl 								: in std_LOGIC_VECTOR(2 downto 0);
		TemporalReg1, TemporalReg2 		: in std_LOGIC_VECTOR(15 downto 0);
		GeneralReg								: in std_LOGIC_VECTOR(15 downto 0);
		ULA, Flags								: in std_LOGIC_VECTOR(15 downto 0);
		SGeneral									: out std_LOGIC_VECTOR(15 downto 0);
		STemp1, STemp2							: out std_LOGIC_VECTOR(15 downto 0)
);
end component;

component ULA 						IS PORT(
		 clk										: in std_logic;
		 Controle 								: in std_logic_vector(7 downto 0);
		 Operando1, Operando2, Flags		: in std_logic_vector(15 downto 0);
		 SExtra, SFlags						: out std_logic_vector(15 downto 0)
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
begin
	--Registradores da maquina
	RG:	RegistradoresP86 		port map(
												ADBtoRG(15 downto 8), ADBtoRG(7 downto 0),
												control_InRG1, control_InRG2, control_OutRG1, control_OutRG2,
												control_wRG1, control_wRG2, clock, reset,
												RGtoADB1, RGtoADB2);
	--Registradores dos operandos
	RT:	RegisterTemp 			port map(
												ADBtoRT1, ADBtoRT2,
												reset, control_wRT1, control_wRT2,
												clock, 
												RTtoADB1, RTtoADB2, RTtoULA1, RTtoULA2);
	--barramento da ula
	--IQtoECSandADB talvez cause um bug por causa do jeito que foi implementado a fila
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
	FR: Registrador16				port map(
												FRin,
												control_wFR,
												reset,
												clock,
												FRout);
	saida <= ULAtoADB;
end description;