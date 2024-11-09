-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-----------------------------
entity bor_4adr_16bit is
	generic (	adrmem          : integer := 4; -- the length of adress
				wordmem         : integer := 16); -- the length of memory word
	port
		(
		clk            	: in std_logic;
		rst            	: in std_logic;
		adr            	: in std_logic_vector (adrmem - 1 downto 0);
		din            	: in std_logic_vector (wordmem - 1 downto 0);
		en             	: in std_logic;
		dout           	: out std_logic_vector (wordmem - 1 downto 0)
		);
end bor_4adr_16bit;
-----------------------------
architecture arc_bor_4adr_16bit of bor_4adr_16bit is
	type bor_4adr_16bit_type is array (0 to 2**adrmem - 1)
	of std_logic_vector (wordmem - 1 downto 0);
	signal bor_4adr_16bit : bor_4adr_16bit_type;
begin
	process (clk,rst)
		begin
			if (rst = '1') then
				for i in 0 to 2**adrmem - 1 loop
					bor_4adr_16bit (to_integer(unsigned(to_unsigned(i, adrmem)))) <= "0000000000000000";	-- Clear the memory
				end loop;
			elsif (clk'event and clk = '1') then
				if (en = '1') then
					bor_4adr_16bit (to_integer(unsigned(adr))) <= din;	-- Write to the specified adress
				end if;
			end if;
		end process;
		dout <= bor_4adr_16bit (to_integer(unsigned(adr)));	-- Read from the specified adress
end arc_bor_4adr_16bit;
-----------------------------
configuration cfg_bor_4adr_16bit of bor_4adr_16bit is
	for arc_bor_4adr_16bit
	end for;
end cfg_bor_4adr_16bit;
-----------------------------
