library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all ;

entity AAA86 is
	port(
		AF, clk: in std_logic;
		AL, AH: in std_logic_vector(7 downto 0);
		SaidaAF, SaidaCF: out std_logic;
		SaidaAL, SaidaAH:  out std_logic_vector(7 downto 0)
	);
	end AAA86;
	
architecture comportamento of AAA86 is
Signal numero: std_logic_vector(3 downto 0);
begin
	numero <= AL(3 downto 0);
	process(clk)
	begin
		if ((numero > 9) or (AF = '1')) then
			SaidaAL <= AL + 6 ;
			SaidaAH <= AH + 1;
			SaidaAF <= '1';
			SaidaCF <= '1';
			
		else 
			SaidaAF <= '0';
			SaidaCF <= '0';
			SaidaAL(3 downto 0) <= AL(3 downto 0);
			SaidaAH <= AH;
			
		end if;
		SaidaAL(7 downto 4) <= "0000";
	end process;
end comportamento;