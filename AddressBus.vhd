LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.all ;

ENTITY AddressBus IS PORT(
    A, B : in std_logic_vector(15 downto 0);
	 Flag, clk: in std_logic;
	 controle : in std_logic_vector(1 downto 0);
	 Saida : out std_logic_vector(19 downto 0)
);
END AddressBus;

ARCHITECTURE comportamento OF AddressBus IS
signal S1A, S1B, S2B, Soma, S: std_logic_vector(19 downto 0);
begin
	S1A(19 downto 4) <= A;
	S1A(3 downto 0) <= "0000";
	S1B(19 downto 4) <= B;
	S1B(3 downto 0) <= "0000";
	S2B(19 downto 16) <= "0000";
	S2B(15 downto 0) <= B;
	with flag select
		S <= S1B when '0',
			  S2B when '1';
	process(clk)
		begin
			if(controle = "00") then
				Soma <= S1A + S;
			elsif(controle = "01") then
				Soma <= S;
			elsif(controle = "10") then
				Soma <= S+1;
			end if;	
	end process;
	Saida <= Soma;
end comportamento;