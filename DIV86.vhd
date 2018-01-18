library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_unsigned.all ;
USE IEEE.NUMERIC_STD.ALL;

entity DIV86 is
	port(
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		Saida1, Saida2:  out std_logic_vector(15 downto 0)
	);
	end DIV86;
	
architecture comportamento of DIV86 is
	signal S, Resto :std_logic_vector(15 downto 0);
	signal S1,S2, A1, B1: std_LOGIC_VECTOR(31 downto 0);

	begin
		A1(15 downto 0) <= A;
		B1(15 downto 0) <= B;
		A1(31 downto 16)<= "0000000000000000";
		B1(31 downto 16)<= "0000000000000000";
		
		S1 <= std_logic_vector(to_signed(to_integer(signed(A1) / signed(B1)),32));
		S2 <= std_logic_vector(to_signed(to_integer(signed(A1) mod signed(B1)),32));
		
		Saida1 <= S1(15 downto 0);
		Saida2 <= S2(15 downto 0);
		
end comportamento;
