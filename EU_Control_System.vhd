library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity EU_Control_System is
  port (
    reset 													: in std_logic;
    clk     												: in std_logic;
	 --Queue vazia
	 QueueVazia												: in std_logic;
	 --instrucao recebida
    entradaInstrucao 									: in  std_logic_vector(7 downto 0);
	 --Entrada Registrador Temporarios
	 EntradaRT1, EntradaRT2							: in std_logic_vector(15 downto 0);
	 --entrada e saidas dos RG
	 entradaRG1, entradaRG2, saidaRG1, saidaRG2	: out std_logic_vector(3 downto 0);
	 --Sinal de leitura da queue
	 LeituraQueue											: out std_logic;
	 --sinal de escrita para o RG
	 sinalEscritaRG1, sinalEscritaRG2 				: out std_logic;
	 --saida do ADB
	 saidaDataBUS											: out std_logic_vector(2 downto 0);
	 --sinal de escrita RT
	 sinalEscritaRT1, sinalEscritaRT2 				: out std_logic;
	 --sinal DataBus
	 sinalDataBus											: out std_logic_vector(2 downto 0);
	 --OP da ULA
	 --Sinal Escrita Flag
	 WFlag													: out std_logic;
	 IncrementaPC											: out std_logic;
	 OPULA													: out std_logic_vector(7 downto 0);
	 --Memory
	 saidaBR1, saidaBR2, saidaBR3						: out std_logic_vector(2 downto 0)
    );
end EU_Control_System;
 
architecture description of EU_Control_System is
	TYPE State_type IS (fetch, readin, writeback, op, boot, arithmetic161, arithmetic162, exe, resposta, final);
	SIGNAL state : State_Type;
	signal destino : std_logic_vector(3 downto 0);
	signal instrucaoReal : std_logic_vector(7 downto 0);
--controle sub add
--instrucao 8 bits


begin
 
	EU_CONTROL : process (clk, reset) is
	variable instrucaoAtual : std_logic_vector(7 downto 0);
	variable destinofonte : std_logic_vector(3 downto 0);
		begin
		if (reset = '1') then
			state <= boot;
		elsif clk'event and clk = '1' then
			case state is
				when boot =>
				IncrementaPC <= '0';
				if(QueueVazia = '1') then
					state <= boot;
				else
					LeituraQueue <= '1'; --sinal para ler instruçao da queue
					state <= fetch;
				end if;
				
				when fetch =>
					if (entradaInstrucao = "00000010" ) then --ADD registrador registrador 16
						instrucaoAtual := entradaInstrucao;
						instrucaoReal <= "00010000";
						if(QueueVazia = '1') then
							state <= fetch;
						else
							LeituraQueue <= '1'; --sinal para ler instruçao da queue
							state <= arithmetic161;
						end if;
					end if;
					
				when arithmetic161 =>

					if entradaInstrucao(7 downto 4) = "0000" then
						saidaRG1 <= "1000";
						elsif entradaInstrucao(7 downto 4) = "0001" then
						saidaRG1 <= "1001";
						elsif entradaInstrucao(7 downto 4) = "0010" then
						saidaRG1 <= "1010";
						elsif entradaInstrucao(7 downto 4) = "0011" then
						saidaRG1 <= "1011";
						elsif entradaInstrucao(7 downto 4) = "0100" then
						saidaRG1 <= "1100";
						elsif entradaInstrucao(7 downto 4) = "0101" then
						saidaRG1 <= "1101";
						elsif entradaInstrucao(7 downto 4) = "0110" then
						saidaRG1 <= "1110";
						elsif entradaInstrucao(7 downto 4) = "0111" then
						saidaRG1 <= "1111";
					end if;
					
					if entradaInstrucao(7 downto 4) = "0000" then
						saidaRG2<= "1000";
						elsif entradaInstrucao(7 downto 4) = "0001" then
						saidaRG2<= "1001";
						elsif entradaInstrucao(7 downto 4) = "0010" then
						saidaRG2<= "1010";
						elsif entradaInstrucao(7 downto 4) = "0011" then
						saidaRG2<= "1011";
						elsif entradaInstrucao(7 downto 4) = "0100" then
						saidaRG2<= "1100";
						elsif entradaInstrucao(7 downto 4) = "0101" then
						saidaRG2<= "1101";
						elsif entradaInstrucao(7 downto 4) = "0110" then
						saidaRG2<= "1110";
						elsif entradaInstrucao(7 downto 4) = "0111" then
						saidaRG2<= "1111";
					end if;
					
					
											
						saidaDataBUS <= "000";
						LeituraQueue <= '0';
						destino <= entradaInstrucao(7 downto 4);
						sinalEscritaRT1 <= '1'; --sinal para escrever no regitrador temporario 1 
						state <= arithmetic162;
				
				when arithmetic162 =>
						if entradaInstrucao(3 downto 0) = "0000" then
							saidaRG1 <= "1000";
							elsif entradaInstrucao(3 downto 0) = "0001" then
							saidaRG1 <= "1001";
							elsif entradaInstrucao(3 downto 0) = "0010" then
							saidaRG1 <= "1010";
							elsif entradaInstrucao(3 downto 0) = "0011" then
							saidaRG1 <= "1011";
							elsif entradaInstrucao(3 downto 0) = "0100" then
							saidaRG1 <= "1100";
							elsif entradaInstrucao(3 downto 0) = "0101" then
							saidaRG1 <= "1101";
							elsif entradaInstrucao(3 downto 0) = "0110" then
							saidaRG1 <= "1110";
							elsif entradaInstrucao(3 downto 0) = "0111" then
							saidaRG1 <= "1111";
						end if;
						
						if entradaInstrucao(3 downto 0) = "0000" then
							saidaRG2<= "1000";
							elsif entradaInstrucao(3 downto 0) = "0001" then
							saidaRG2<= "1001";
							elsif entradaInstrucao(3 downto 0) = "0010" then
							saidaRG2<= "1010";
							elsif entradaInstrucao(3 downto 0) = "0011" then
							saidaRG2<= "1011";
							elsif entradaInstrucao(3 downto 0) = "0100" then
							saidaRG2<= "1100";
							elsif entradaInstrucao(3 downto 0) = "0101" then
							saidaRG2<= "1101";
							elsif entradaInstrucao(3 downto 0) = "0110" then
							saidaRG2<= "1110";
							elsif entradaInstrucao(3 downto 0) = "0111" then
							saidaRG2<= "1111";
						end if;
						
											
						saidaDataBUS <= "001";
						sinalEscritaRT1 <= '0';
						sinalEscritaRT2 <= '1'; --sinal para escrever no regitrador temporario 2
						
						state <= exe;

				when resposta =>
					sinalEscritaRG1 <= '1';
					sinalEscritaRG2 <= '1';
					
					if destino = "0000" then
							EntradaRG1<= "0000";
							elsif destino = "0001" then
							EntradaRG1<= "0010";
							elsif destino = "0010" then
							EntradaRG1<= "0100";
							elsif destino = "0011" then
							EntradaRG1<= "0110";
							elsif destino = "0100" then
							EntradaRG1<= "1000";
							elsif destino = "0101" then
							EntradaRG1<= "1101";
							elsif destino = "0110" then
							EntradaRG1<= "1110";
							elsif destino = "0111" then
							EntradaRG1<= "1111";
						end if;
						
						if destino = "0000" then
							EntradaRG2<= "0001";
							elsif destino = "0001" then
							EntradaRG2<= "0011";
							elsif destino = "0010" then
							EntradaRG2<= "0101";
							elsif destino = "0011" then
							EntradaRG2<= "0111";
							elsif destino = "0100" then
							EntradaRG2<= "1001";
							elsif destino = "0101" then
							EntradaRG2<= "1100";
							elsif destino = "0110" then
							EntradaRG2<= "1110";
							elsif destino = "0111" then
							EntradaRG2<= "1111";
						end if;
				
				
					SaidaDataBUS <= "010";
					state <= final;
					
				when final =>
					sinalEscritaRG1 <= '0'; 
					sinalEscritaRG2 <= '0';
					sinalEscritaRT1 <= '0';
					sinalEscritaRT2 <= '0';
					IncrementaPC <= '1';
					

				when exe => --Parte final da instruçao 
				
					OPULA <= instrucaoReal;-- passa a instruçao pra ula
					WFlag <= '1'; --habilita escrita no registrador de flag
					
					state <= resposta;
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