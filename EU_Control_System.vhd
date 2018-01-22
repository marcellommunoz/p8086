library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity EU_Control_System is
  port (
    reset 													: in std_logic;
    clk     												: in std_logic;
	 --instrucao recebida
    entradaInstrucao 									: in  std_logic_vector(7 downto 0);
	 --entrada e saidas dos RG
	 entradaRG1, entradaRG2, saidaRG1, saidaRG2	: out std_logic_vector(3 downto 0);
	 --sinal de escrita para o RG
	 sinalEscritaRG1, sinalEscritaRG2 				: out std_logic;
	 --saida do ADB
	 saidaDataBUS											: out std_logic_vector(2 downto 0);
	 --sinal de escrita RT
	 sinalEscritaRT1, sinalEscritaRT2 				: out std_logic;
	 --OP da ULA
	 OPULA													: out std_logic_vector(7 downto 0);
	 --Memory
	 saidaBR1, saidaBR2, saidaBR3						: out std_logic_vector(2 downto 0)
    );
end EU_Control_System;
 
architecture description of EU_Control_System is
	TYPE State_type IS (fetch, readin, writeback, op);
	SIGNAL state : State_Type;
--controle sub add
--instrucao 8 bits


begin
 
	EU_CONTROL : process (clk, reset) is
	variable instrucaoAtual : std_logic_vector(7 downto 0);
		begin
		if (reset = '1') then
			state <= fetch;
		elsif clk'event and clk = '1' then
			case state is
				when fetch =>
					--AAA
					if(entradaInstrucao = "00000001") then
						instrucaoAtual  := entradaInstrucao;
					end if;
					state <= readin;
				when readin =>
					--AAA
					if(instrucaoAtual = "00000001") then
						--AL
						saidaRG1 		<= "1000";
						--AH
						saidaRG2 		<= "1000";
						--tmp reg 1
						saidaDataBUS 	<= "000";
					end if;
				when op =>
					if(instrucaoAtual = "00000001") then
						
					end if;
				when writeback =>
				
			end case;
		end if;
	end process EU_CONTROL;
end description;