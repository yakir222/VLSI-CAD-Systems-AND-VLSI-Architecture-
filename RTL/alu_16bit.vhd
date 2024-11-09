-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-----------------------------
entity alu_16bit is
	port
		(
		din1           	: in std_logic_vector(15 downto 0);
		din2           	: in std_logic_vector(15 downto 0);
		code           	: in std_logic_vector(3 downto 0);
		dout           	: out std_logic_vector(15 downto 0)
		);
end alu_16bit;
-----------------------------
architecture arc_alu_16bit of alu_16bit is
begin
	process (din1, din2, code)
	
		constant add      : std_logic_vector(3 downto 0) := "0001";
		
		variable vdin1, vdin2 : unsigned (15 downto 0);
		variable vout : unsigned (31 downto 0);
		
	begin  --process
	
		vdin1 := unsigned (din1);
		vdin2 := unsigned (din2);
		vout(31 downto 0) := (others => '0');
		
	case code is
		
		when add => -------------- add unsigned -----------------
		
			vout(15 downto 0) := vdin1 + vdin2;
			
		when others => null;  ------- others for case
	end case;
	-- assign dout signal
	dout <= std_logic_vector(vout(15 downto 0));
	end process;
end arc_alu_16bit;
-----------------------------
configuration cfg_alu_16bit of alu_16bit is
	for arc_alu_16bit
	end for;
end cfg_alu_16bit;
-----------------------------
