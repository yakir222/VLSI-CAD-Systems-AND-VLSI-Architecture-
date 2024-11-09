--------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
---------------------------------
entity alu is
    port ( 
    	inp1     : in  std_logic_vector(15 downto 0); -- operand 1
    	inp2     : in  std_logic_vector(15 downto 0); -- operand 2
    	ctr      : in  std_logic_vector(4 downto 0);  -- instruction ctr
    	outp     : out std_logic_vector(15 downto 0);  -- outp out
		z		 : out std_logic 				  	 -- flags
		);   
end alu;
-----------------------------------
architecture arc_alu of alu is	
begin
	process (inp1, inp2, ctr)
	
		constant add 		: std_logic_vector (4 downto 0) := "00001";
		constant log_and	: std_logic_vector (4 downto 0) := "00010";
		constant sub 		: std_logic_vector (4 downto 0) := "00011";
		constant shl 		: std_logic_vector (4 downto 0) := "00110";
		constant shr 		: std_logic_vector (4 downto 0) := "00111";
		constant inc 		: std_logic_vector (4 downto 0) := "00101";
		constant com 	  	: std_logic_vector (4 downto 0) := "00100";

		variable vinp1, vinp2 : signed (15 downto 0);		
		variable voutp 				: signed (15 downto 0);		    
		variable vz 				: std_logic;	-- for flags	

	begin -- process     

     		vinp1 := signed (inp1);
     		vinp2 := signed (inp2);
     		vz   := '0'; -- zero
     		voutp := x"0000"; 
     
     case ctr is      

     	when add => -------------- add signed-----------------

     		voutp := vinp1 + vinp2;     		        		
     		
     	when sub => ------------ sub signed---------

     		voutp := vinp1 - vinp2;
		                		
     	when log_and =>-------------- logic and ------
     	
     		voutp := vinp1 and vinp2;
     		
     	when shl =>-------------- shift left ---------
     	
		  voutp := vinp1 (14 downto 0) & '0';
			
     	when shr =>  -------------- shift right --------
     		
		  voutp := '0' & vinp1 (15 downto 1);
		    
     	when inc =>  ------------ increment -------------
			
		 voutp := vinp1 + 1;    		    		
     	
		  when com =>  ----------- complement -------------

     		voutp := not vinp1;
     		
		when others => null;  ------- others for case  		

     end case;
	 
     		-- define zero flag
       if voutp = x"0000" then     		
         vz := '1';
       else 
         vz := '0';
       end if;	 
     
     -- assign alu_out signals   	
     
     z <= vz;
     outp <= std_logic_vector(voutp);
     end process;
end arc_alu;
----------------------------------------
configuration cfg_alu of alu is
	for arc_alu
	end for;
end cfg_alu;
-----------------------------------------
