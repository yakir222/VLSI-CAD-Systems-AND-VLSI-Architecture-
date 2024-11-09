-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-----------------------------
entity counter_p_16bit is
	port
		(
		clk            	: in std_logic;
		rst            	: in std_logic;
		en             	: in std_logic;
		count          	: in std_logic;
		din            	: in std_logic_vector (15 downto 0);
		dout           	: out std_logic_vector (15 downto 0)
		);
end counter_p_16bit;
-----------------------------
architecture arc_counter_p_16bit of counter_p_16bit is
begin
	process (rst, clk)
	variable tmp : unsigned(15 downto 0);
		begin
			if rst = '1' then
				tmp := (others => '0');
			elsif (clk'event and clk = '1') then
				if en = '1' then
					tmp := unsigned(din);
				elsif count = '1' then
					if tmp = "1111111111111111" then
						tmp := (others => '0');
					else
						tmp := tmp + 1;
					end if;
				end if;
			end if;
			dout <= std_logic_vector(tmp);
	end process;
end arc_counter_p_16bit;
-----------------------------
configuration cfg_counter_p_16bit of counter_p_16bit is
	for arc_counter_p_16bit
	end for;
end cfg_counter_p_16bit;
-----------------------------
