-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
-----------------------------
entity mux_10x16 is
	port
		(
		din0           	: in std_logic_vector (15 downto 0);
		din1           	: in std_logic_vector (15 downto 0);
		din2           	: in std_logic_vector (15 downto 0);
		din3           	: in std_logic_vector (15 downto 0);
		din4           	: in std_logic_vector (15 downto 0);
		din5           	: in std_logic_vector (15 downto 0);
		din6           	: in std_logic_vector (15 downto 0);
		din7           	: in std_logic_vector (15 downto 0);
		din8           	: in std_logic_vector (15 downto 0);
		din9           	: in std_logic_vector (15 downto 0);
		ctr_mux        	: in std_logic_vector (3 downto 0);
		dout           	: out std_logic_vector (15 downto 0)
		);
end mux_10x16;
-----------------------------
architecture arc_mux_10x16 of mux_10x16 is
begin
	process (din0, din1, din2, din3, din4, din5, din6, din7, din8, din9, ctr_mux)
		begin
			case ctr_mux is
				when "0000" => dout <= din0;
				when "0001" => dout <= din1;
				when "0010" => dout <= din2;
				when "0011" => dout <= din3;
				when "0100" => dout <= din4;
				when "0101" => dout <= din5;
				when "0110" => dout <= din6;
				when "0111" => dout <= din7;
				when "1000" => dout <= din8;
				when "1001" => dout <= din9;
				when others => dout <= (others => '0');
			end case;
	end process;
end arc_mux_10x16;
-----------------------------
configuration cfg_mux_10x16 of mux_10x16 is
	for arc_mux_10x16
	end for;
end cfg_mux_10x16;
-----------------------------
