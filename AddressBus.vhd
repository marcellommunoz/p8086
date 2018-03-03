LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY AddressBus IS PORT(
    SegmentBase, Offset : in std_logic_vector(15 downto 0);
	 IP						: in std_logic_vector(15 downto 0);
	 Address 				: out std_logic_vector(19 downto 0);
	 IPpp						: out std_logic_vector(15 downto 0)
);
END AddressBus;

ARCHITECTURE comportamento OF AddressBus IS
begin
				Address <= (SegmentBase&"0000") + ("0000"&Offset);
				IPpp <= IP + "00000001";
end comportamento;