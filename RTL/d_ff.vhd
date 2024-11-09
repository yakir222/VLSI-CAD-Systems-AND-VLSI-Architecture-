-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
-----------------------------
entity d_ff is
	port
		(
		clk            	: in std_logic;
		din            	: in std_logic;
		rst            	: in std_logic;
		en             	: in std_logic;
		dout           	: out std_logic
		);
end d_ff;
-----------------------------
architecture arc_d_ff of d_ff is
begin
	process (rst, clk)
		begin
			if rst = '1' then
				dout <= '0';
			elsif (clk'event and clk = '1') then
				if en = '1' then
					dout <= din;
				end if;
			end if;
	end process;
end arc_d_ff;
-----------------------------
configuration cfg_d_ff of d_ff is
	for arc_d_ff
	end for;
end cfg_d_ff;
-----------------------------
