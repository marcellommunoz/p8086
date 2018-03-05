LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.all ;

ENTITY MemoriaSimples IS PORT(
 	 Dado: in std_LOGIC_VECTOR(15 downto 0);
	 Ender: in std_LOGIC_VECTOR(19 downto 0);
    clk, reset: IN STD_LOGIC;
	 QueueFull : in std_LOGIC;
	 EscritaQueue : out std_LOGIC;
	 IncrementaPC : out std_Logic;
	 ControleBIURegister1, ControleBIURegister2 : out std_logic_vector(2 downto 0);
	 SaidaQueue: out std_LOGIC_VECTOR(7 downto 0);
    SaidaRegs: out std_LOGIC_VECTOR(15 downto 0)
);
END MemoriaSimples;


ARCHITECTURE comportamento OF MemoriaSimples IS

signal addr : std_logic_vector(15 downto 0);
signal Smemoria, data :std_logic_vector(7 downto 0);
signal w: std_LOGIC;

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
	w <= '0';
	ControleBIURegister1 <= "000";
	ControleBIURegister2 <= "100";
	addr <= Ender(15 downto 0);
	data <= Dado(7 downto 0);
	memoria : Memory port map(addr, clk, data, w, Smemoria);
	SaidaQueue <= Smemoria;
	IncrementaPC <= not QueueFull;
	EscritaQueue <= not QueueFull;
	
end comportamento;
