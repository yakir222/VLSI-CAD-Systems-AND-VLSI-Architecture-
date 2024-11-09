-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-----------------------------
entity ram_16adr_16bit is
	generic (	adrmem          : integer := 16; -- the length of adress
				wordmem         : integer := 16); -- the length of memory word
	port
		(
		clk            	: in std_logic;
		adr            	: in std_logic_vector (adrmem - 1 downto 0);
		din            	: in std_logic_vector (wordmem - 1 downto 0);
		rdwr           	: in std_logic;
		dout           	: out std_logic_vector (wordmem - 1 downto 0)
		);
end ram_16adr_16bit;
-----------------------------
architecture arc_ram_16adr_16bit of ram_16adr_16bit is
	type ram_16adr_16bit_type is array (0 to 2**adrmem - 1)
	of std_logic_vector (wordmem - 1 downto 0);
	signal ram_16adr_16bit : ram_16adr_16bit_type;
begin
	process (clk)
		begin
			if (clk'event and clk = '1') then
				if (rdwr = '1') then
					-- write to the specified adress
					ram_16adr_16bit (to_integer(unsigned(adr))) <= din;
				end if;
				dout <= ram_16adr_16bit (to_integer(unsigned(adr))); -- read from the specified adress
			end if;
	end process;
end arc_ram_16adr_16bit;
-----------------------------
configuration cfg_ram_16adr_16bit of ram_16adr_16bit is
	for arc_ram_16adr_16bit
	end for;
end cfg_ram_16adr_16bit;
-----------------------------
