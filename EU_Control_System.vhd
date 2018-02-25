library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity EU_Control_System is
  port (
    reset 													: in std_logic;
    clk     												: in std_logic;
	 --instrucao recebida
    entradaInstrucao 									: in  std_logic_vector(7 downto 0);
	 --Entrada Registrador Temporarios
	 EntradaRT1, EntradaRT2							: in std_logic_vector(15 downto 0);
	 --entrada e saidas dos RG
	 entradaRG1, entradaRG2, saidaRG1, saidaRG2	: out std_logic_vector(3 downto 0);
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
	 OPULA													: out std_logic_vector(7 downto 0);
	 --Memory
	 saidaBR1, saidaBR2, saidaBR3						: out std_logic_vector(2 downto 0)
    );
end EU_Control_System;
 
architecture description of EU_Control_System is
	TYPE State_type IS (fetch, readin, writeback, op, boot, arithmetic, exe);
	SIGNAL state : State_Type;
--controle sub add
--instrucao 8 bits


begin
 
	EU_CONTROL : process (clk, reset) is
	variable instrucaoAtual : std_logic_vector(7 downto 0);
		begin
		if (reset = '1') then
			state <= boot;
		elsif clk'event and clk = '1' then
			case state is
				when boot =>
					
				when fetch =>
					--AAA
					if(entradaInstrucao = "00000001") then
						instrucaoAtual  := entradaInstrucao;
						state <= readin;
					elsif (entradaInstrucao = "01010000" or entradaInstrucao = "11010000") then --ADD
						instrucaoAtual := entradaInstrucao;
						state <= arithmetic;
					end if;
					
				when arithmetic =>
					
					--ADD
					--entradaInstrucao(7) = '0' registrador registrador
					if (instrucaoAtual(6) = '1') then
						if (entradaInstrucao(7) = '0')then
							sinalDataBus <= "111";
							if (entradaInstrucao(6 downto 0) = "000000") then -- AL e AH
								saidaRG1 <= "0000";
								saidaRG2 <= "0001";
							elsif (entradaInstrucao(6 downto 0) = "0000001") then -- AL e BH
								saidaRG1 <= "0000";
								saidaRG2 <= "0011";
							elsif (entradaInstrucao(6 downto 0) = "0000010") then -- AL e BL
								saidaRG1 <= "0000";
								saidaRG2 <= "0010";
							elsif (entradaInstrucao(6 downto 0) = "0000011") then -- AL e CH
								saidaRG1 <= "0000";
								saidaRG2 <= "0101";
							elsif (entradaInstrucao(6 downto 0) = "0000100") then -- AL e CL
								saidaRG1 <= "0000";
								saidaRG2 <= "0100";
							elsif (entradaInstrucao(6 downto 0) = "0000101") then -- AL e DH
								saidaRG1 <= "0000";
								saidaRG2 <= "0111";
							elsif (entradaInstrucao(6 downto 0) = "0000110") then -- AL e DL
								saidaRG1 <= "0000";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0000111") then -- AH e BH
								saidaRG1 <= "0001";
								saidaRG2 <= "0011";
							elsif (entradaInstrucao(6 downto 0) = "0001000") then -- AH e BL
								saidaRG1 <= "0001";
								saidaRG2 <= "0010";
							elsif (entradaInstrucao(6 downto 0) = "0001001") then -- AH e CH
								saidaRG1 <= "0001";
								saidaRG2 <= "0101";
							elsif (entradaInstrucao(6 downto 0) = "0001010") then -- AH e CL
								saidaRG1 <= "0001";
								saidaRG2 <= "0100";
							elsif (entradaInstrucao(6 downto 0) = "0001011") then -- AH e DH
								saidaRG1 <= "0001";
								saidaRG2 <= "0111";
							elsif (entradaInstrucao(6 downto 0) = "0001100") then -- AH e DL
								saidaRG1 <= "0001";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0001101") then -- BL e BH
								saidaRG1 <= "0010";
								saidaRG2 <= "0011";
							elsif (entradaInstrucao(6 downto 0) = "0001110") then -- BL e AL
								saidaRG1 <= "0010";
								saidaRG2 <= "0000";
							elsif (entradaInstrucao(6 downto 0) = "0001111") then -- BL e CH
								saidaRG1 <= "0010";
								saidaRG2 <= "0101";
							elsif (entradaInstrucao(6 downto 0) = "0010000") then -- BL e CL
								saidaRG1 <= "0010";
								saidaRG2 <= "0100";
							elsif (entradaInstrucao(6 downto 0) = "0010001") then -- BL e DH
								saidaRG1 <= "0010";
								saidaRG2 <= "0111";
							elsif (entradaInstrucao(6 downto 0) = "0010010") then -- BL e DL
								saidaRG1 <= "0010";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0010011") then -- BH e AH
								saidaRG1 <= "0011";
								saidaRG2 <= "0001";
							elsif (entradaInstrucao(6 downto 0) = "0010100") then -- BH e AL
								saidaRG1 <= "0011";
								saidaRG2 <= "0000";
							elsif (entradaInstrucao(6 downto 0) = "0010101") then -- BH e CH
								saidaRG1 <= "0011";
								saidaRG2 <= "0101";
							elsif (entradaInstrucao(6 downto 0) = "0010110") then -- BH e CL
								saidaRG1 <= "0011";
								saidaRG2 <= "0100";
							elsif (entradaInstrucao(6 downto 0) = "0010111") then -- BH e DH
								saidaRG1 <= "0011";
								saidaRG2 <= "0111";
							elsif (entradaInstrucao(6 downto 0) = "0011000") then -- BH e DL
								saidaRG1 <= "0011";
								saidaRG2 <= "0110";							
							elsif (entradaInstrucao(6 downto 0) = "0001101") then -- CL e CH
								saidaRG1 <= "0100";
								saidaRG2 <= "0101";
							elsif (entradaInstrucao(6 downto 0) = "0001110") then -- CL e AL
								saidaRG1 <= "0100";
								saidaRG2 <= "0000";
							elsif (entradaInstrucao(6 downto 0) = "0001111") then -- CL e AH
								saidaRG1 <= "0100";
								saidaRG2 <= "0001";
							elsif (entradaInstrucao(6 downto 0) = "0010000") then -- CL e BL
								saidaRG1 <= "0100";
								saidaRG2 <= "0010";
							elsif (entradaInstrucao(6 downto 0) = "0010001") then -- CL e BH
								saidaRG1 <= "0100";
								saidaRG2 <= "0011";
							elsif (entradaInstrucao(6 downto 0) = "0010010") then -- CL e DL
								saidaRG1 <= "0100";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0010010") then -- CL e DH
								saidaRG1 <= "0100";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0010011") then -- CH e CL
								saidaRG1 <= "0101";
								saidaRG2 <= "0100";
							elsif (entradaInstrucao(6 downto 0) = "0010011") then -- CH e AH
								saidaRG1 <= "0101";
								saidaRG2 <= "0001";
							elsif (entradaInstrucao(6 downto 0) = "0010100") then -- CH e AL
								saidaRG1 <= "0101";
								saidaRG2 <= "0000";
							elsif (entradaInstrucao(6 downto 0) = "0010101") then -- CH e BH
								saidaRG1 <= "0101";
								saidaRG2 <= "0011";
							elsif (entradaInstrucao(6 downto 0) = "0010110") then -- CH e BL
								saidaRG1 <= "0101";
								saidaRG2 <= "0010";
							elsif (entradaInstrucao(6 downto 0) = "0010111") then -- CH e DH
								saidaRG1 <= "0101";
								saidaRG2 <= "0111";
							elsif (entradaInstrucao(6 downto 0) = "0011000") then -- CH e DL
								saidaRG1 <= "0101";
								saidaRG2 <= "0110";	
							elsif (entradaInstrucao(6 downto 0) = "0011001") then -- DL e DH
								saidaRG1 <= "0110";
								saidaRG2 <= "0111";
							elsif (entradaInstrucao(6 downto 0) = "0011010") then -- DL e AL
								saidaRG1 <= "0110";
								saidaRG2 <= "0000";
							elsif (entradaInstrucao(6 downto 0) = "0011011") then -- DL e AH
								saidaRG1 <= "0110";
								saidaRG2 <= "0001";
							elsif (entradaInstrucao(6 downto 0) = "0011100") then -- DL e BL
								saidaRG1 <= "0110";
								saidaRG2 <= "0010";
							elsif (entradaInstrucao(6 downto 0) = "0011101") then -- DL e BH
								saidaRG1 <= "0110";
								saidaRG2 <= "0011";
							elsif (entradaInstrucao(6 downto 0) = "0011110") then -- DL e DL
								saidaRG1 <= "0110";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0011111") then -- DL e DH
								saidaRG1 <= "0110";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0100000") then -- DH e DL
								saidaRG1 <= "0111";
								saidaRG2 <= "0110";
							elsif (entradaInstrucao(6 downto 0) = "0100001") then -- DH e AH
								saidaRG1 <= "0111";
								saidaRG2 <= "0001";
							elsif (entradaInstrucao(6 downto 0) = "0100010") then -- DH e AL
								saidaRG1 <= "0101";
								saidaRG2 <= "0000";
							elsif (entradaInstrucao(6 downto 0) = "0100011") then -- DH e BH
								saidaRG1 <= "0111";
								saidaRG2 <= "0011";
							elsif (entradaInstrucao(6 downto 0) = "0100100") then -- DH e BL
								saidaRG1 <= "0111";
								saidaRG2 <= "0010";
							elsif (entradaInstrucao(6 downto 0) = "0100101") then -- DH e CH
								saidaRG1 <= "0111";
								saidaRG2 <= "0101";
							elsif (entradaInstrucao(6 downto 0) = "0100110") then -- DH e CL
								saidaRG1 <= "0111";
								saidaRG2 <= "0100";
							end if;
						end if;
						sinalEscritaRT1 <= '1';
						state <= exe;
					end if;
					state <= readin;

				
				when exe => --Parte final da instruçao 
				
					OPULA <= instrucaoAtual;-- passa a instruçao pra ula
					WFlag <= '1'; --habilita escrita no registrador de flag
					
					state <= fetch;
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