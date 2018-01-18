library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity ADC86 is
	port(
		clk, carry, Controle: in std_logic;
		A, B: in std_logic_vector(15 downto 0);
		AF, CF, overflow, PF, SF, ZF: out std_logic;
		Saida:  out std_logic_vector(15 downto 0)
	);
	end ADC86;
	
architecture comportamento of ADC86 is
	signal S :std_logic_vector(15 downto 0);
	signal X1, X2 , Y :std_logic_vector(7 downto 0);
	signal temp, temp2 :std_logic;

	begin
		process(clk)
		begin
			if Controle = '1' then
				S <= A - B - carry;
			else
				S <= A + B + carry;
			end if;

			ZF <= '0';
			SF <= '0';
			Overflow <= '0';
			AF <= '0';
			CF <='0';

			Saida <= S;
			PF <= not(S(0) xor S(1) xor S(2) xor S(3) xor S(4) xor S(5) xor S(6) xor S(7) xor S(8)xor S(9)xor S(10)xor S(11)xor S(12)xor S(13)xor S(14)xor S(15));
			if(S = 0) then
				ZF <= '1';
			end if;
			temp <=(A(15)and B(15)) and (not(S(15)));
			if(temp = '1') then
				Overflow <= '1';
				else
					if S(15) = '1' then
						SF <= '1';
					end if;
			end if;
			X1 <= A(7 downto 0);
			X2 <= B(7 downto 0);
			Y <= X1 + X2+ carry;
			if (Y > 127) then
				AF <='1';
			end if;
			temp2 <=(A(15)and B(15)) and (not(S(15)));
			if (temp2 = '1') then
				CF <= '1';
			end if;
		end process;
end comportamento;