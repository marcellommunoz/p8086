
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BusControlLogic IS PORT(
	 Dado: in std_LOGIC_VECTOR(15 downto 0);
	 Ender: in std_LOGIC_VECTOR(19 downto 0);
    clk, w, ControleDadIns: IN STD_LOGIC;
	 SaidaQueue: out std_LOGIC_VECTOR(7 downto 0);
    SaidaRegs: out std_LOGIC_VECTOR(15 downto 0)
);
END BusControlLogic;

ARCHITECTURE comportamento OF BusControlLogic IS
Signal Smemoria : std_logic_vector(15 downto 0);
Signal escrita: std_logic;
component Memory IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end component;

begin

	memoria : Memory port map(Ender(14 downto 0), clk, Dado, w, Smemoria);
	escrita <= not w;
	process(clk)
		begin
			if((ControleDadIns = '1') and (escrita = '1')) then
				SaidaRegs <= Smemoria;
			elsif (ControleDadIns = '0') then
				SaidaQueue <= Smemoria(7 downto 0);
			end if;
	end process;
end comportamento;


