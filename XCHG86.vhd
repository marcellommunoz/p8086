library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity XCHG86 is
	port(
		Source: inout std_logic_vector(15 downto 0);
		Destiny:  inout std_logic_vector(15 downto 0)
	);
	end XCHG86;
	
architecture comportamento of XCHG86 is
	signal temp :std_logic_vector(15 downto 0);

	begin
		temp<= destiny;
		destiny <= source;
		source <= temp;

end comportamento;