library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity NOT86 is 
port(
	A : in std_logic_vector(15 downto 0);
	S: out std_logic_vector(15 downto 0)
);
end NOT86;

architecture comportamento of NOT86 is

	begin	
		S<= not A;
	end comportamento;