-- Automatically generated using Goals v1.0.1.170
-----------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
-----------------------------
entity g_comp is
	generic
		(
		comp_kind       : string;
		size            : integer
		);
	port
		(
		din1            : in  std_logic_vector ((size-1) downto 0);
		din2            : in  std_logic_vector ((size-1) downto 0);
		dout            : out std_logic
		);
end g_comp;
-----------------------------
architecture arc_g_comp of g_comp is
begin
	comp_eq : if (comp_kind = "eq") generate
		dout <= '1' when (din1 = din2) else '0';
	end generate comp_eq;
	
	comp_neq : if (comp_kind = "neq") generate
		dout <= '1' when (din1 /= din2) else '0';
	end generate comp_neq;
	
	comp_gr : if (comp_kind = "gr") generate
		dout <= '1' when (din1 > din2) else '0';
	end generate comp_gr;
	
	comp_ls : if (comp_kind = "ls") generate
		dout <= '1' when (din1 < din2) else '0';
	end generate comp_ls;
	
	comp_geq : if (comp_kind = "geq") generate
		dout <= '1' when (din1 >= din2) else '0';
	end generate comp_geq;
	
	comp_leq : if (comp_kind = "leq") generate
		dout <= '1' when (din1 <= din2) else '0';
	end generate comp_leq;
	
end arc_g_comp;
-----------------------------
configuration cfg_g_comp of g_comp is
	for arc_g_comp
	end for;
end cfg_g_comp;
-----------------------------
