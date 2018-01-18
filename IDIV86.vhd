library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_unsigned.all ;
USE IEEE.NUMERIC_STD.ALL;

entity IDIV86 is
	port(
		clk: in std_logic;
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		Saida1, Saida2:  out std_logic_vector(15 downto 0)
	);
	end IDIV86;
	
architecture comportamento of IDIV86 is
	signal S, Resto :std_logic_vector(15 downto 0);
	signal S1,S2, A1, B1: std_LOGIC_VECTOR(31 downto 0);

	begin
		process(clk)
			begin 
				A1(15 downto 0) <= A;
				B1(15 downto 0) <= B;
				if A(15) = '1' then
					A1(31 downto 16)<= "1111111111111111";
				else
					A1(31 downto 16)<= "0000000000000000";
				end if;
				if B(15) = '1' then
					B1(31 downto 16)<= "1111111111111111";
				else 
					B1(31 downto 16)<= "0000000000000000";
				end if;
		end process;
		
		S1 <= std_logic_vector(to_signed(to_integer(signed(A1) / signed(B1)),32));
		S2 <= std_logic_vector(to_signed(to_integer(signed(A1) rem signed(B1)),32));
		
		Saida1 <= S1(15 downto 0);
		Saida2 <= S2(15 downto 0);
		
end comportamento;
