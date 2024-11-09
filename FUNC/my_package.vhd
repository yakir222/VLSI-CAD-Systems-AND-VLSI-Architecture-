library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 

package MY_PACKAGE is 
	procedure wave_gen (signal clk: out std_logic); 
	procedure exec_inst(signal idle : in std_logic; signal clk : out std_logic); 
end MY_PACKAGE; 

package body MY_PACKAGE is 
	procedure wave_gen (signal clk: out std_logic) is 
	begin 
		clk	<= '0';			
			wait for 10 ns;	
		clk	<= '1';			
		wait for 10 ns; 
	end wave_gen;	
	
	procedure exec_inst(signal idle : in std_logic; signal clk : out std_logic) is 
	begin 
		wave_gen(clk); 
		while idle = '0' loop 
			wave_gen(clk); 
		end loop; 
	end exec_inst; 
	
end MY_PACKAGE;
