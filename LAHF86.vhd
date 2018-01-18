library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity LAHF86 is
	port(
		SF, ZF, AF, PF, CF: in std_logic;
		--7 6 4 2 0
		AH: in std_logic_vector(7 downto 0);
		Saida:  out std_logic_vector(7 downto 0)
	);
	end LAHF86;
	
architecture comportamento of LAHF86 is
	signal S :std_logic_vector(31 downto 0);
	signal X1, X2 , Y :std_logic_vector(7 downto 0);

	begin
		Saida(0) <= CF;
		Saida(1) <= AH(1);
		Saida(2) <= PF;
		Saida(3) <= AH(3);
		Saida(4) <= AF;
		Saida(5) <= AH(5);
		Saida(6) <= ZF;
		Saida(7) <= SF;

end comportamento;