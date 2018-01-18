library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity NEG86 is
	port(
		clk: in std_logic;
		A :in std_logic_vector(15 downto 0);
		zero, SF, Overflow, Parity, auxiliary, CF: out std_logic;
		Saida : out std_logic_vector(15 downto 0)
	);
	end NEG86;
	
architecture comportamento of NEG86 is
	signal S :std_logic_vector(15 downto 0);
	signal Y :std_logic_vector(7 downto 0);
	--signal temp : std_logic;
	begin
		process(clk)
		begin
			S <= 0 - A;
			Overflow <= '0';
			zero <= '0';
			SF <= '0';
			auxiliary <= '0';
			CF <= '1';
			Parity <= not(S(0) xor S(1) xor S(2) xor S(3) xor S(4) xor S(5) xor S(6) xor S(7) xor S(8)xor S(9)xor S(10)xor S(11)xor S(12)xor S(13)xor S(14)xor S(15));
			if(S = 0) then
				zero <= '1';
				CF <= '0';
			end if;
			--temp <=(A(15) and (not B(15))) and (not(S(15)));
			if(A = "1000000000000000") then
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