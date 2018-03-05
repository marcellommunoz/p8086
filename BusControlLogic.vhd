
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.all ;

ENTITY BusControlLogic IS PORT(
 	 Dado: in std_LOGIC_VECTOR(15 downto 0);
	 Ender: in std_LOGIC_VECTOR(19 downto 0);
    ByteControl, clk, w, ControleDadoInstru, reset: IN STD_LOGIC;
	 QueueFull : in std_LOGIC;
	 EscritaQueue : out std_LOGIC;
	 SaidaQueue, teste: out std_LOGIC_VECTOR(7 downto 0);
    SaidaRegs: out std_LOGIC_VECTOR(15 downto 0)
);
END BusControlLogic;

ARCHITECTURE comportamento OF BusControlLogic IS
Signal Smemoria : std_logic_vector(7 downto 0);
Signal data, byte: std_logic_vector(7 downto 0);
Signal notEscrita, controleleitura, wmemoria, ControleDIMemoria: std_logic;
Signal Saida , addr, addrmemoria, testeaddr, DataMemoria: std_logic_vector(15 downto 0); -- addrmemoria serve para saber se houve mudança de endereço
Signal DataByte : std_logic := '0';
Signal ok : std_logic := '0';
TYPE State_type IS (byteState ,primeiraParte, segundaParte, inicio, ZeroState, fim);
SIGNAL state : State_Type;
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

	memoria : Memory port map(addr, clk, Data, w, Smemoria);
	process(clk, reset)
		begin	
			if reset = '0' then
				addr <= Ender(15 downto 0);
				state <= ZeroState;
			else
				case state is 
					when ZeroState =>
						addr <= Ender(15 downto 0);
						state <= inicio;
					when inicio =>
						addrmemoria <= Ender(15 downto 0);
						wmemoria <= w;
						DataMemoria <= Dado;
						ControleDIMemoria <= ControleDadoInstru;
						if ByteControl = '1' or ControleDadoInstru = '1' then	
							addr <= Ender(15 downto 0);
							--addrmemoria <= addr;
							--ok <= '0';
							--Data <= Dado(7 downto 0);
							state <= byteState;
						else
							addr <= Ender(15 downto 0);
							--addrmemoria <= addr;
							--Data <= Dado(7 downto 0);
							--ok <= '0';
							state <= primeiraParte;
						end if;
						
					when byteState =>
						if w = '1' then 
							Data <= Dado(7 downto 0);
							state <= fim;
						elsif ControleDadoInstru = '1' then
							SaidaQueue <= Smemoria;
							state <= fim;
						else
							SaidaRegs(7 downto 0) <= Smemoria;
							SaidaRegs(15 downto 8) <= "00000000";
							state <= fim;
						end if;
						
					when primeiraParte =>
						if w = '1' then
							Data <= Dado(7 downto 0);
							addr <= Ender(15 downto 0)+1;
							state <= SegundaParte;
						else
							SaidaRegs(7 downto 0) <= Smemoria;
							Saida(7 downto 0) <= Smemoria;
							addr <= Ender(15 downto 0)+1;
							state <= SegundaParte;
						end if;
						
					when SegundaParte =>
						if w = '1' then
							Data <= Dado(15 downto 8);
							state <= fim;
						else
							SaidaRegs(15 downto 8) <= Smemoria;
							Saida(15 downto 8) <= Smemoria;
							state <= fim;
						end if;
					when fim =>
						if not(w = wmemoria and controleDIMemoria = ControleDadoInstru and Dado =  DataMemoria and addrmemoria = Ender(15 downto 0)) then
							state <= inicio;
						end if;
						state <= fim;
					end case;
				end if;
		teste <= Smemoria;
				
	end process;
	
	--controleleitura <= ControleDadoInstru and notEscrita;
	--SaidaRegs <= Saida;
	--SaidaQueue <= Saida(7 downto 0);
end comportamento;


