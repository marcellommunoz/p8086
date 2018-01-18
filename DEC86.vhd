library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity DEC86 is
	port(
		clk: in std_logic;
		A :in std_logic_vector(15 downto 0);
		zero, SF, Overflow, Parity, auxiliary: out std_logic;
		Saida:  out std_logic_vector(15 downto 0)
	);
	end DEC86;
	
architecture comportamento of DEC86 is
	signal S :std_logic_vector(15 downto 0);
	signal Y :std_logic_vector(7 downto 0);

	begin
		process(clk)
		begin
			S <= A + "1000000000000000";
			Overflow <= '0';
			zero <= '0';
			SF <= '0';
			auxiliary <= '0';
			Parity <= not(S(0) xor S(1) xor S(2) xor S(3) xor S(4) xor S(5) xor S(6) xor S(7) xor S(8)xor S(9)xor S(10)xor S(11)xor S(12)xor S(13)xor S(14)xor S(15));
			if(S = 0) then
				zero <= '1';
			end if;
			if(A = "111111111111111")then
				Overflow <= '1';
				else
					if S(15) = '1' then
						SF <= '1';
					end if;
			end if;
			Y <= A(7 downto 0)+"11111111";
			if (Y > 127) then
				auxiliary <='1';
			end if;
		end process;
		Saida <= S;
end comportamento;