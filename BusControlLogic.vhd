
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.all ;

ENTITY BusControlLogic IS PORT(
 	 Dado: in std_LOGIC_VECTOR(15 downto 0);
	 Ender: in std_LOGIC_VECTOR(19 downto 0);
    ByteControl, clk, w, ControleDadoInstru: IN STD_LOGIC;
	 SaidaQueue: out std_LOGIC_VECTOR(7 downto 0);
    SaidaRegs: out std_LOGIC_VECTOR(15 downto 0)
);
END BusControlLogic;

ARCHITECTURE comportamento OF BusControlLogic IS
Signal Smemoria : std_logic_vector(7 downto 0);
Signal data, byte: std_logic_vector(7 downto 0);
Signal notEscrita: std_logic;
Signal Saida , addr: std_logic_vector(15 downto 0);
Signal DataByte : std_logic := '0';
Signal Contador : std_logic := '0';
component Memory IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

begin
	--ByteControl <= ByteWord and 
	with Contador select
		Data <= Dado(7 downto 0) when '0',
				 Dado(15 downto 8) when '1';
				 
	addr <= Ender(15 downto 0) + Contador;
	memoria : Memory port map(addr, clk, Data, w, Smemoria);
	--Byte(15 downto 8)<= Smemoria(15 downto 8);
	notEscrita <= not w;
	
	process(clk)
		begin
			if (Contador = '0') and ((not ByteControl) = '1') then
				Saida(7 downto 0) <= Smemoria;
				Contador <= '1';
				--addr <= addr + 1;
				else
					Saida(15 downto 8) <= Smemoria;
					Contador <= '0';
			end if;
			
			if((ControleDadoInstru = '1') and (notEscrita = '1') and (Contador = '1')) then
				SaidaRegs <= Saida;
			elsif (ControleDadoInstru = '0') then
				SaidaQueue <= Smemoria;
			end if;
	end process;
	
end comportamento;


