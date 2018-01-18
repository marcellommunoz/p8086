library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity OR86 is
port (
		A, B : in std_logic_vector(15 downto 0);
		S: out std_logic_vector(15 downto 0)

);
end OR86;
	
architecture comportamento of OR86 is


begin
	S <= A or B;
end comportamento;