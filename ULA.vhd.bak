library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity ULA is
	port(
		clk: in std_logic;
		Controle : in std_logic_vector(7 downto 0);
		Operando1, Operando2, Flags: in std_logic_vector(15 downto 0); --Operando1 é o Source e o Operando2 é o destination
		SExtra, SFlags: out std_logic_vector(15 downto 0)
		--Flags -    -    -    -    O    D    I    T    S    Z    -    A    -    P    -    C    Flags
		--									 11   10   9    8    7    6         4         2         0
	);
	end ULA;

architecture comportamento of ULA is

component ADC86 IS
port(
		clk, carry, Controle, ControleByte: in std_logic;
		A, B: in std_logic_vector(15 downto 0);
		Abyte, Bbyte: in std_logic_vector(7 downto 0);
		AF, CF, overflow, PF, SF, ZF: out std_logic;
		Saida:  out std_logic_vector(15 downto 0)
	);
	end component;

component	ADD86 is
	port(
		clk, Controle, ControleByte: in std_logic;
		A, B : in std_logic_vector(15 downto 0);
		AByte, BByte: in std_logic_vector(7 downto 0);
		AF, CF, overflow, PF, SF, ZF: out std_logic;
		Saida:  out std_logic_vector(15 downto 0)
	);
	end component;
	
component DEC86 IS
	port(
		clk: in std_logic;
		A :in std_logic_vector(15 downto 0);
		AByte : in std_logic_vector(7 downto 0);
		ByteControl : in std_logic;
		zero, SF, Overflow, Parity, AF: out std_logic;
		Saida:  out std_logic_vector(15 downto 0)
	);
end component;

component DIV86 IS
	port(
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		ByteControl : in std_logic;
		Abyte, BByte: in std_logic_vector(7 downto 0);
		Saida1, Saida2:  out std_logic_vector(15 downto 0)
	);
end component;

component IDIV86 IS
	port(
		clk: in std_logic;
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		ByteControl : in std_logic;
		Abyte, BByte: in std_logic_vector(7 downto 0);
		Saida1, Saida2:  out std_logic_vector(15 downto 0)
	);
end component;

component INC86 is
	port(
		clk: in std_logic;
		A :in std_logic_vector(15 downto 0);
		AByte : in std_logic_vector(7 downto 0);
		ByteControl : in std_logic;
		zero, SF, Overflow, Parity, AF: out std_logic;
		Saida:  out std_logic_vector(15 downto 0)
	);

end component;

component LAHF86 is
	port(
		SF, ZF, AF, PF, CF: in std_logic;
		--7 6 4 2 0
		AH: in std_logic_vector(7 downto 0);
		Saida:  out std_logic_vector(7 downto 0)
	);

end component;

component MUL86 is
	port(
		clk: in std_logic;
		A, B: in std_logic_vector(15 downto 0);
		carryS, Overflow: out std_logic;
		Saida1, Saida2:  out std_logic_vector(15 downto 0)
	);

end component;

component MULB86 is
	port(
		clk: in std_logic;
		A, B: in std_logic_vector(7 downto 0);
		carryS, Overflow: out std_logic;
		Saida:  out std_logic_vector(15 downto 0)
	);

end component;

component NEG86 is
	port(
		clk: in std_logic;
		A :in std_logic_vector(15 downto 0);
		ByteControl : in std_logic;
		Abyte: in std_logic_vector(7 downto 0);
		zero, SF, Overflow, Parity, auxiliary, CF: out std_logic;
		Saida : out std_logic_vector(15 downto 0)
	);
end component;

component NOT86 is 
port(
	A : in std_logic_vector(15 downto 0);
	AByte 		: in std_logic_vector(7 downto 0);
	ByteControl			: in std_logic; 
	S: out std_logic_vector(15 downto 0)
);

end component;


component SAHF86 is
	port(
		SF, ZF, AF, PF, CF: out std_logic;
		--7 6 4 2 0
		AH: in std_logic_vector(7 downto 0)
	);

end component;

component XCHG86 is
	port(
		Source: inout std_logic_vector(15 downto 0);
		Destiny:  inout std_logic_vector(15 downto 0)
	);

end component;

component XOR86 is 
port(
	A, B : in std_logic_vector(15 downto 0);
	ByteControl : in std_logic;
	Abyte, BByte: in std_logic_vector(7 downto 0);
	S: out std_logic_vector(15 downto 0)
);

end component;

component AND86 is
   port
   (
      A, B 					: in std_logic_vector(15 downto 0);
		AByte, BByte 		: in std_logic_vector(7 downto 0);
		ByteControl			: in std_logic; 
		C						: out std_logic_vector(15 downto 0);
      Zout, Sout, Pout 	: out std_logic
   );
end component;

component OR86 is
port (
		A, B : in std_logic_vector(15 downto 0);
		ByteControl : in std_logic;
		Abyte, BByte: in std_logic_vector(7 downto 0);
		S: out std_logic_vector(15 downto 0)

);
end component;

component ROL86 is
   port
   (
      Source, Count	: in std_logic_vector(15 downto 0);
      Destination		: out std_logic_vector(15 downto 0);
		OFOut				: out std_logic
   );
end component;

component ROR86 is
   port
   (
      Source, Count	: in std_logic_vector(15 downto 0);
      Destination		: out std_logic_vector(15 downto 0);
		OFOut				: out std_logic
   );
end component;

component SAR86 is
   port
   (
      Source, Count	: in std_logic_vector(15 downto 0);
      Destination		: out std_logic_vector(15 downto 0);
		OFOut				: out std_logic
   );
end component;

component SHLSAL86 is
   port
   (
      Source, Count	: in std_logic_vector(15 downto 0);
      Destination		: out std_logic_vector(15 downto 0);
		OFOut				: out std_logic
   );
end component;

component SHR86 is
   port
   (
      Source, Count	: in std_logic_vector(15 downto 0);
      Destination		: out std_logic_vector(15 downto 0);
		OFOut				: out std_logic
   );
end component;

component TEST86 is
   port
   (
      A, B 					: in std_logic_vector(15 downto 0);
      Zout, Sout, Pout 	: out std_logic
   );
end component;

component AAA86 is
	port(
		AF, clk: in std_logic;
		AL, AH: in std_logic_vector(7 downto 0);
		SaidaAF, SaidaCF: out std_logic;
		SaidaAL, SaidaAH:  out std_logic_vector(7 downto 0)
	);
end component;

component DAA86 is
	port(
		AF, CF, clk: in std_logic;
		AL: in std_logic_vector(7 downto 0);
		SaidaCF, SaidaZF, SaidaSF, SaidaPF, SaidaAF: out std_logic;
		SaidaAL:  out std_logic_vector(7 downto 0)
	);
end component;	

component AAS86 is
	port(
		AF, clk: in std_logic;
		AL, AH: in std_logic_vector(7 downto 0);
		SaidaAF, SaidaCF: out std_logic;
		SaidaAL, SaidaAH:  out std_logic_vector(7 downto 0)
	);
end component;

component AAM86 is
	port(
		clk: in std_logic;
		AL, AH: in std_logic_vector(7 downto 0);
		SaidaZF, SaidaSF, SaidaPF: out std_logic;
		SaidaAL, SaidaAH:  out std_logic_vector(7 downto 0)
	);
end component;

component AAD86 is
	port(
		clk: in std_logic;
		AL, AH: in std_logic_vector(7 downto 0);
		SaidaZF, SaidaSF, SaidaPF: out std_logic;
		SaidaAL, SaidaAH:  out std_logic_vector(7 downto 0)
	);
end component;

component CMP86 is
port(
		clk: in std_logic;
		A , B:in std_logic_vector(15 downto 0);
		ByteControl : in std_logic;
		Abyte, BByte: in std_logic_vector(7 downto 0);
		zero, SF, Overflow, Parity, auxiliary, CF: out std_logic
	);
end component;

Signal SaidaAdd,SaidaAdc : std_logic_vector(15 downto 0); --ADD ADC
Signal Fadd, FAdc,FNeg, FCmp: std_logic_vector(5 downto 0); --ADC ADD FLAGS
Signal SaidaDec: std_logic_vector(15 downto 0); --DEC
Signal Fdec, FInc, FLahf, FDaa: std_logic_vector(4 downto 0); --DEC FLAgs
Signal SDiv1,SDiv2, SIdiv1, SIdiv2: std_logic_vector(15 downto 0); --DIV IDIV
Signal SInc : std_logic_vector(15 downto 0); --INC
Signal SMul1, SMul2, SMulb: std_logic_vector(15 downto 0); --MUL MULB
Signal FMul, FMulb , FAaa, FAas: std_logic_vector(1 downto 0);
Signal SNeg : std_logic_vector(15 downto 0); --NEG
Signal SNot : std_logic_vector(15 downto 0); --NOT
Signal FSahf, Slahf : std_logic_vector(15 downto 0); -- SAHF
Signal SXCHG1, SXCHG2 : std_logic_vector(15 downto 0); --XCHG
Signal SXOR : std_logic_vector(15 downto 0); --XOR
Signal SAnd, SOr: std_logic_vector(15 downto 0); --AND OR
Signal FAnd , FTest, FAam, FAad: Std_logic_vector(2 downto 0);
Signal SRol , SRor, SSar, SShlsal, SShr: std_logic_vector(15 downto 0); --ROL ROR
Signal FRol, FRor, FSar, FShlsal, FShr: std_logic;-- Flag ROL ROR
Signal SAaa,  SAas, SAam, SAad : std_logic_vector(15 downto 0);
Signal SDaa : std_logic_vector(7 downto 0);
Signal SubOperando1, SubOperando2 : std_logic_vector(7 downto 0);
Signal SOperando1, SOperando2, Saida: std_logic_vector(15 downto 0);
Signal Word2 : std_logic;
Signal SJA : std_logic_vector(15 downto 0);
Begin
	
SubOperando1 <= Operando1(15 downto 8);
SubOperando2 <= Operando1(7 downto 0);



add1: ADD86 port map(clk, Controle(7),Controle(6), Operando1, Operando2,SubOperando1, SubOperando2, Fadd(0), Fadd(1), Fadd(2), Fadd(3), Fadd(4), Fadd(5), SaidaAdd);

adc1: ADC86 port map(clk, Flags(0), Controle(7),Controle(6), Operando1, Operando2,SubOperando1, SubOperando2, Fadc(0), Fadc(1), Fadc(2), Fadc(3), Fadc(4), Fadc(5), SaidaAdc);

dec1: DEC86 port map(clk, Operando1,SubOperando1, Controle(6), Fdec(0), Fdec(1), Fdec(2), Fdec(3), Fdec(4), SaidaDec);
												--	6 7 11 2 4
div1: DIV86 port map(Operando1, Operando2, Controle(6), SubOperando1, SubOperando2, SDiv1, SDiv2);

idiv1: IDIV86 port map (clk, Operando1, Operando2, Controle(6), SubOperando1, SubOperando2, SIdiv1, SIdiv2);

inc1: INC86 port map (clk, Operando1,SubOperando1, Controle(6), FInc(0), FInc(1), FInc(2), FInc(3), FInc(4), SInc);
													--6 7 11 2 4
lahf1: LAHF86 port map(Flags(0), Flags(1), Flags(2), Flags(3), Flags(4), Operando1(15 downto 8), Slahf(15 downto 8));
								--7 6 4 2 0
mul1: MUL86 port map (clk, Operando1, Operando2, Fmul(0), Fmul(1), SMul1, SMul2);
																	--0 11
mulb1: MULB86 port map (clk, Operando1(15 downto 8), Operando1(7 downto 0), Fmulb(0), Fmulb(1), SMulb);
																	--0 11
neg1: NEG86 port map (clk, Operando1,Controle(6), SubOperando1, FNeg(0), FNeg(1), FNeg(2), FNeg(3), FNeg(4), FNeg(5), SNeg);								
													--6 7 11 2 4 0
not1: NOT86 port map (Operando1,SubOperando1, Controle(6), SNot);

sahf1: SAHF86 port map (FSahf(7), FSahf(6), FSahf(4), FSahf(2), FSahf(0), Operando1(15 downto 8));

xor1: XOR86 port map (Operando1, Operando2,Controle(6), SubOperando1, SubOperando2, SXOR);

and1 : AND86 port map (Operando1, Operando2, SubOperando1, SubOperando2, Controle(6), SAnd, FAnd(0), FAnd(1), FAnd(2));
																		--6 7 2
or1 : OR86 port map (Operando1, Operando2,Controle(6), SubOperando1, SubOperando2, SOr);

rol1 : ROL86 port map (Operando1, Operando2, SRol, FRol);

ror1 : ROR86 port map (Operando1, Operando2, SRor, FRor);

sar1 : SAR86 port map (Operando1, Operando2, SSar,FSar);

shlsal1 :SHLSAL86 port map (Operando1, Operando2, SShlsal, FShlsal);

shr1: SHR86 port map (Operando1, Operando2, SShr, FShr);

test1: TEST86 port map (Operando1, Operando2, FTest(0), FTest(1), FTest(2));
																--6 7 2																
aaa1: AAA86 port map (Flags(4), clk, Operando1(7 downto 0), Operando1(15 downto 8), FAaa(0), FAaa(1), SAaa(7 downto 0), SAaa(15 downto 8));

daa1: DAA86 port map (Flags(4), Flags(0), clk ,Operando1(7 downto 0), FDaa(0), FDaa(1), FDaa(2), FDaa(3), FDaa(4), SDaa(7 downto 0));

aas1: AAS86 port map (Flags(4), clk, Operando1(7 downto 0), Operando1(15 downto 8), FAas(0), FAas(1), SAas(7 downto 0), SAas(15 downto 8));

aam1: AAM86 port map (clk, Operando1(7 downto 0), Operando1(15 downto 8), FAam(0), FAam(1), FAam(2), SAam(7 downto 0), SAam(15 downto 8));

aad1: AAD86 port map (clk, Operando1(7 downto 0), Operando1(15 downto 8), FAad(0), FAad(1), FAad(2), SAad(7 downto 0), SAad(15 downto 8));

cmp1: CMP86 port map (clk, Operando1, Operando2, Controle(6), SubOperando1, SubOperando2, FCmp(0), FCmp(1), FCmp(2), FCmp(3), FCmp(4), FCmp(5));


process (clk)
	begin
		--Flags -    -    -    -    O    D    I    T    S    Z    -    A    -    P    -    C    Flags
		--									 11   10   9    8    7    6         4         2         0
		if Controle = "00000000" then --JMP
			SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			Word2 <= '0';
		elsif Controle = "00000010" then	 --JA
			if (Flags(0) or Flags(6)) = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
				Word2 <= '0';
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
				Word2 <= '0';
			end if;
			
			elsif Controle = "00000011" then -- JAE and JNC
				if Flags(0) = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
				Word2 <= '0';
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
				Word2 <= '0';
			end if;
			
			elsif Controle = "00000100" then -- JB
				if Flags(0) = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
				Word2 <= '0';
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
				Word2 <= '0';
			end if;
			
			elsif Controle = "00000101" then -- JBE
				if (Flags(0) or Flags(6)) = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
				Word2 <= '0';
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
				Word2 <= '0';
			end if;
			
			elsif Controle = "00000111" then -- JC
			Word2 <= '0';
				if Flags(0) = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001000" then -- JE
			Word2 <= '0';
				if Flags(6) = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001001" then -- JG
			Word2 <= '0';
				if ((Flags(7) xor Flags(11)) or Flags(6)) = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001010" then -- JGE
			Word2 <= '0';
				if (Flags(7) xor Flags(11)) = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001011" then -- JLE
			Word2 <= '0';
				if ((Flags(7) xor Flags(11)) or Flags(6)) = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001100" then -- JNE
			Word2 <= '0';
				if Flags(6)  = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001101" then -- JNO
			Word2 <= '0';
				if Flags(11)  = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001110" then -- JNPP
			Word2 <= '0';
				if Flags(2)  = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "00001111" then -- JNS
			Word2 <= '0';
				if Flags(7)  = '0' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "10000001" then -- JO
			Word2 <= '0';
				if Flags(11)  = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "10000010" then -- JP
			Word2 <= '0';
				if Flags(1)  = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "10000001" then -- JS
			Word2 <= '0';
				if Flags(7)  = '1' then
				SOperando1 <= Operando2; -- Operando2 quando utilizado em um desvio é o novo endereço de PC
			else
				SOperando1 <= Operando1; -- Operando1 quando utilizado em um desvio é endereço normal de PC
			end if;
			
			elsif Controle = "10010000" or Controle = "11010000" or Controle = "00010000" or Controle = "01010000"then --ADD
			SOperando1 <= SaidaAdd;
			SFlags(4) <= FAdd(0);
			SFlags(0) <= FAdd(1);
			SFlags(11) <= FAdd(2);
			SFlags(2) <= FAdd(3);
			SFlags(7) <= FAdd(4);
			SFlags(6) <= FAdd(5);
			SFlags(1) <= '0';
			SFlags(3) <= '0';
			SFlags(5) <= '0';
			SFlags(10 downto 8) <= "000";
			SFlags(15 downto 12) <= "0000";
			Word2 <= '0';
			
			elsif Controle = "10010001" or Controle = "11010001" or Controle = "00010001" or Controle = "01010001" then --ADC
				SOperando1 <= SaidaAdc;
				SFlags(4) <= FAdc(0);
				SFlags(0) <= FAdc(1);
				SFlags(11) <= FAdc(2);
				SFlags(2) <= FAdc(3);
				SFlags(7) <= FAdc(4);
				SFlags(6) <= FAdc(5);
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00010010" or Controle = "01010010"then --DEC
				SOperando1 <= SaidaDec;
				SFlags(6) <= FDec(0);
				SFlags(7) <= FDec(1);
				SFlags(11) <= FDec(2);
				SFlags(2) <= FDec(3);
				SFlags(4) <= FDec(4);
				SFlags(0) <= '0';
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
			
			elsif Controle = "00010011" or Controle = "01010011" then --DIV
				SOperando1 <= SDiv1;
				SOperando2 <= SDiv2;
				Word2 <= '1';		
			
			elsif Controle = "00010100" or Controle = "01010100" then --IDIV
				SOperando1 <= SIdiv1;
				SOperando2 <= SIdiv2;
				Word2 <= '1';	
			
			elsif Controle = "00010101" or Controle = "01010101"then --INC
				SFlags(6) <= FInc(0);
				SFlags(7) <= FInc(1);
				SFlags(11) <= FInc(2);
				SFlags(2) <= FInc(3);
				SFlags(4) <= FInc(4);
				SFlags(0) <= '0';
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00010110" then --LAHF
				SOperando1 <= Slahf;
			
			elsif Controle = "00010111" then
				SOperando1 <= SMul1;
				SOperando2 <= SMul2;
				SFlags(0) <= Fmul(0);
				SFlags(11) <= Fmul(1);
				SFlags(15 downto 12) <= "0000";
				SFlags(10 downto 1) <= "0000000000";
				Word2 <= '1';
				
			elsif Controle = "00011000" then
				SOperando1 <= SMulb;
				SFlags(0) <= Fmul(0);
				SFlags(11) <= Fmul(1);
				SFlags(15 downto 12) <= "0000";
				SFlags(10 downto 1) <= "0000000000";
				Word2 <= '0';
			elsif Controle = "00011001" or Controle = "01011001" then
				SOperando1 <= SNeg;
				SFlags(6) <= FNeg(0);
				SFlags(7) <= FNeg(1);
				SFlags(11) <= FNeg(2);
				SFlags(2) <= FNeg(3);
				SFlags(4) <= FNeg(4);
				SFlags(0) <= FNeg(5);
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00011010" or Controle = "01011010" then
				SOperando1 <= SNot;

			elsif Controle = "00011011" then
				SFlags(15 downto 8) <= Flags(15 downto 8);
				SFlags(5) <= Flags(5);
				SFlags(3) <= Flags(3);
				SFlags(1) <= Flags(1);
				SFlags(7) <= FSahf(7);
				SFlags(6) <= FSahf(6);
				SFlags(4) <= FSahf(4);
				SFlags(2) <= FSahf(2);
				SFlags(0) <= FSahf(0);
				Word2 <= '0';
			elsif Controle = "00011100" or Controle = "01011100" then
				SOperando1 <= SXOR;
			
			elsif Controle = "00011101" or Controle = "01011101" then
				SOperando1 <= SAnd;
				SFlags(6) <= FAnd(0);
				SFlags(7) <= FAnd(1);
				SFlags(2) <= FAnd(2);
				SFlags(4) <= '0';
				SFlags(0) <= '0';
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00011110" or Controle = "01011110" then
				SOperando1 <= SOr;
				Word2 <= '0';
			elsif Controle = "00011111" then
				SOperando1 <= SRol;
				SFlags(11) <= FRol;
				SFlags(10 downto 0) <= "00000000000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00100000" then
				SOperando1 <= SRor;
				SFlags(11) <= FRor;
				SFlags(10 downto 0) <= "00000000000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00100001" then
				SOperando1 <= SSar;
				SFlags(11) <= FSar;
				SFlags(10 downto 0) <= "00000000000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00100010" then
				SOperando1 <= SShlsal;
				SFlags(11) <= FShlsal;
				SFlags(10 downto 0) <= "00000000000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00100011" then
				SOperando1 <= SShr;
				SFlags(11) <= FShr;
				SFlags(10 downto 0) <= "00000000000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00100100" then
				SFlags(6) <= FTest(0);
				SFlags(7) <= FTest(1);
				SFlags(2) <= FTest(2);
				SFlags(4) <= '0';
				SFlags(0) <= '0';
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00000001" then --aaa
				SOperando1 <= SAaa;
				SFlags(4) <= FAaa(0);
				SFlags(0) <= FAaa(1);
				SFlags(3 downto 1) <= "000";
				SFlags(15 downto 5) <= "00000000000";
				Word2 <= '0';
			
			elsif Controle = "00100111" then
				SOperando1(7 downto 0) <= SDaa;
				SOperando1(15 downto 8) <= "00000000";
				SFlags(0) <=  FDaa(0);
				SFlags(6) <=  FDaa(1);
				SFlags(7) <=  FDaa(2);
				SFlags(2) <=  FDaa(3);
				SFlags(4) <=  FDaa(4);
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(15 downto 8) <= "00000000";
				Word2 <= '0';
			elsif Controle = "00101000" then
				SOperando1 <= SAas;
				SFlags(4) <= FAas(0);
				SFlags(0) <= FAas(1);
				SFlags(3 downto 1) <= "000";
				SFlags(15 downto 5) <= "00000000000";
				Word2 <= '0';
			elsif Controle = "00101001" then
				SOperando1 <= SAam;
				SFlags(6) <= FAam(0);
				SFlags(7) <= FAam(1);
				SFlags(2) <= FAam(2);
				SFlags(4) <= '0';
				SFlags(0) <= '0';
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
			elsif Controle = "00101010" then
				SOperando1 <= SAad;
				SFlags(6) <= FAad(0);
				SFlags(7) <= FAad(1);
				SFlags(2) <= FAad(2);
				SFlags(4) <= '0';
				SFlags(0) <= '0';
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
				Word2 <= '0';
				
			elsif Controle = "00101011" then
				Word2 <= '0';
				SFlags(6) <= FCmp(0);
				SFlags(7) <= FCmp(1);
				SFlags(11) <= FCmp(2);
				SFlags(2) <= FCmp(3);
				SFlags(4) <= FCmp(4);
				SFlags(0) <= FCmp(5);
				SFlags(1) <= '0';
				SFlags(3) <= '0';
				SFlags(5) <= '0';
				SFlags(10 downto 8) <= "000";
				SFlags(15 downto 12) <= "0000";
			
			elsif Controle = "00101100" then --CLC
				SFlags(0) <= '0';
				SFlags(15 downto 1) <= Flags (15 downto 1);
			
			elsif Controle = "00101101" then --CMC
				SFlags(0) <= not Flags(0);
				SFlags(15 downto 1) <= Flags(15 downto 1);
				
			elsif Controle = "00101110" then --STC
				SFlags(0) <= '1';
				SFlags(15 downto 1) <= Flags(15 downto 1);

			elsif Controle = "00101111" then --CLD
				SFlags(10) <= '0';
				SFlags(9 downto 0) <= Flags(9 downto 0);
				SFlags(15 downto 11) <= Flags(15 downto 11);
				
			elsif Controle = "00110000" then --STD
				SFlags(10) <= '1';
				SFlags(9 downto 0) <= Flags(9 downto 0);
				SFlags(15 downto 11) <= Flags(15 downto 11);
				
			elsif Controle = "00110001" then --CLI
				SFlags(9) <= '0';
				SFlags(8 downto 0) <= Flags(8 downto 0);
				SFlags(15 downto 10) <= Flags(15 downto 10);
				
			elsif Controle = "00110010" then --STI
				SFlags(9) <= '1';
				SFlags(8 downto 0) <= Flags(8 downto 0);
				SFlags(15 downto 10) <= Flags(15 downto 10);



		end if;
		Saida <= SOperando1;
		if Word2 = '1' then 
			Saida <= SOperando2;
		end if;	
end process;
SExtra <= Saida;

end comportamento;