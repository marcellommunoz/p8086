
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DataBus IS PORT(
	 InControl 							: in std_LOGIC_VECTOR(2 downto 0);
    TemporalReg1, TemporalReg2 	: in std_LOGIC_VECTOR(15 downto 0);
	 GeneralReg							: in std_LOGIC_VECTOR(15 downto 0);
	 ULA, Flags							: in std_LOGIC_VECTOR(15 downto 0);
	 SGeneral							: out std_LOGIC_VECTOR(15 downto 0);
	 STemp1, STemp2					: out std_LOGIC_VECTOR(15 downto 0)
);
END DataBus;

ARCHITECTURE comportamento OF DataBus IS

Signal entrada: std_LOGIC_VECTOR(15 downto 0);

begin

	with InControl select
		entrada	<=	TemporalReg1 	when "000",
						TemporalReg2 	when "001",
						ULA 				when "010",
						Flags 			when "011",
						GeneralReg 		when others;
	SGeneral	<=	entrada;
					  
	with InControl select
		STemp1	<=	"00000000"&entrada(7 downto 0)	when "100",
						entrada 									when others;
	with InControl select
		STemp2	<=	"00000000"&entrada(15 downto 8)	when "100",
						entrada 									when others;
					  
end comportamento;



