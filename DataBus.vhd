
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DataBus IS PORT(
	 InControl : in std_LOGIC_VECTOR(2 downto 0);
    TemporalReg1, TemporalReg2 : in std_LOGIC_VECTOR(15 downto 0);
	 GeneralReg, BIURegs: in std_LOGIC_VECTOR(15 downto 0);
	 ULA, Flags: in std_LOGIC_VECTOR(15 downto 0);
	 InstructionQueue: in std_LOGIC_VECTOR(7 downto 0);
	 SGeneral, SBIURegs: out std_LOGIC_VECTOR(15 downto 0);
	 STemp1, STemp2: out std_LOGIC_VECTOR(15 downto 0)
);
END DataBus;

ARCHITECTURE comportamento OF DataBus IS

Signal Entrada: std_LOGIC_VECTOR(15 downto 0);

begin

	with InControl select
		Entrada <= TemporalReg1 when "000",
					  TemporalReg2 when "001",
					  GeneralReg when "010",
					  BIURegs when "011",
					  ULA when "100",
					  Flags when "101",
					  "00000000"&InstructionQueue when "110",
					  "0000000000000000" when "111";
	
	SGeneral <= Entrada;
	SBIURegs <= Entrada;
	STemp1 <= Entrada;
	STemp2 <= Entrada;
					  
end comportamento;



