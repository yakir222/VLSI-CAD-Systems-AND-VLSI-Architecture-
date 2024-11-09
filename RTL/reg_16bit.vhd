-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-----------------------------
entity reg_16bit is
	port
		(
		clk            	: in std_logic;
		rst            	: in std_logic;
		din            	: in std_logic_vector (15 downto 0);
		en             	: in std_logic;
		dout           	: out std_logic_vector (15 downto 0)
		);
end reg_16bit;
-----------------------------
architecture arc_reg_16bit of reg_16bit is
begin
	process (rst, clk)
		begin
			if rst = '1' then
				dout <= std_logic_vector(to_unsigned(0, 16));
			elsif (clk'event and clk = '1') then
				if en = '1' then
					dout <= din;
				end if;
			end if;
	end process;
end arc_reg_16bit;
-----------------------------
configuration cfg_reg_16bit of reg_16bit is
	for arc_reg_16bit
	end for;
end cfg_reg_16bit;
-----------------------------
