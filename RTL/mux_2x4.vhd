-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
-----------------------------
entity mux_2x4 is
	port
		(
		din0           	: in std_logic_vector (3 downto 0);
		din1           	: in std_logic_vector (3 downto 0);
		ctr_mux        	: in std_logic;
		dout           	: out std_logic_vector (3 downto 0)
		);
end mux_2x4;
-----------------------------
architecture arc_mux_2x4 of mux_2x4 is
begin
	process (din0, din1, ctr_mux)
		begin
			case ctr_mux is
				when '0' => dout <= din0;
				when '1' => dout <= din1;
				when others => dout <= (others => '0');
			end case;
	end process;
end arc_mux_2x4;
-----------------------------
configuration cfg_mux_2x4 of mux_2x4 is
	for arc_mux_2x4
	end for;
end cfg_mux_2x4;
-----------------------------
