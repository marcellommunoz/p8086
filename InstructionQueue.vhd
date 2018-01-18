library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity InstructionQueue is
  port (
    reset 	: in std_logic;
    clk     : in std_logic;
    w   			:in  std_logic;
    entrada 	: in  std_logic_vector(7 downto 0);
    cheio   	: out std_logic;
    r   : in  std_logic;
    saida : out std_logic_vector(7 downto 0);
    vazio   : out std_logic;
    );
end InstructionQueue;
 
architecture description of InstructionQueue is
 
	type type_queue is array (0 to 5) of std_logic_vector(7 downto 0);
	signal vetor_queue 		: type_queue := (others => (others => '0'));
	signal saida_parcial 	: std_logic_vector(7 downto 0);
	signal index_leitura   	: integer range 0 to 5 := 0;
	signal index_escrita   	: integer range 0 to 5 := 0;
	signal w_cheio  			: std_logic;
	signal w_vazio 			: std_logic;
   
begin
 
  p_CONTROL : process (clk, reset) is
	VARIABLE contador 		: integer range -1 to 6 := 0;
  begin
	if(reset = '1') then
        contador := 0;
        index_leitura   <= 0;
        index_escrita   <= 0;
		  w_cheio <= '0';
		  w_vazio <= '1';
	elsif (clk = '1' AND clk'EVENT) then
			--controle escrita
			if w = '1' AND w_cheio = '0' then
				vetor_queue(index_escrita) <= entrada;
				if index_escrita = 5 then
					index_escrita <= 0;
				else
					index_escrita <= index_escrita + 1;
				end if;
			end if;
			--controle leitura
			if (r = '1' and w_vazio = '0') then
				saida_parcial <= vetor_queue(index_leitura);
				if index_leitura = 5 then
					index_leitura <= 0;
				else
					index_leitura <= index_leitura + 1;
				end if;
			end if;
			--controle leitura e escrita
			if w = '1' and r = '1' and w_vazio = '1' then
				index_escrita <= 0;
				index_leitura <= 0;
				vetor_queue(0) <= entrada;
				saida_parcial <= entrada;
			end if;
			--controle quantidade
			if (w = '1' and r = '0' and w_cheio = '0') then
				if(contador = -1) then
					contador := 1;
				else
					contador := contador + 1;
				end if;
			elsif (w = '0' and r = '1' and w_vazio = '0') then
				contador := contador - 1;
			end if;
			--controle sinais
			if contador = 6 then
				w_cheio <= '1';
			else
				w_cheio <= '0';
			end if;
			
			if contador = 0 then
				w_vazio <= '1';
			else
				w_vazio <= '0';
			end if;
    end if;
	saida 	<= saida_parcial;
	cheio  <= w_cheio;
	vazio 	<= w_vazio;
  end process p_CONTROL;
end description;