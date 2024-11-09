-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-----------------------------
package components is
	
	procedure wave_gen (signal clk: out std_logic);
	
	procedure exec_inst (
			signal Idle : in std_logic;
			signal clk : out std_logic);

component alu is
    port ( 
    	inp1     : in  std_logic_vector(15 downto 0); -- operand 1
    	inp2     : in  std_logic_vector(15 downto 0); -- operand 2
    	ctr      : in  std_logic_vector(4 downto 0);  -- instruction ctr
    	outp     : out std_logic_vector(15 downto 0);  -- outp out
		z		 : out std_logic 				  	 -- flags
		);   
end component;

component d_ff is
	port
		(
		clk            	: in std_logic;
		din            	: in std_logic;
		rst            	: in std_logic;
		en             	: in std_logic;
		dout           	: out std_logic
		);
end component;

component reg_16bit is
	port
		(
		clk            	: in std_logic;
		rst            	: in std_logic;
		din            	: in std_logic_vector (15 downto 0);
		en             	: in std_logic;
		dout           	: out std_logic_vector (15 downto 0)
		);
end component;

component bor_4adr_16bit is
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
end component;

component ram_16adr_16bit is
	generic (	adrmem          : integer := 16; -- the length of adress
				wordmem         : integer := 16); -- the length of memory word
	port
		(
		clk            	: in std_logic;
		adr            	: in std_logic_vector (adrmem - 1 downto 0);
		din            	: in std_logic_vector (wordmem - 1 downto 0);
		rdwr           	: in std_logic;
		dout           	: out std_logic_vector (wordmem - 1 downto 0)
		);
end component;

component counter_p_16bit is
	port
		(
		clk            	: in std_logic;
		rst            	: in std_logic;
		en             	: in std_logic;
		count          	: in std_logic;
		din            	: in std_logic_vector (15 downto 0);
		dout           	: out std_logic_vector (15 downto 0)
		);
end component;

component g_comp is
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
end component;

component alu_16bit is
	port
		(
		din1           	: in std_logic_vector(15 downto 0);
		din2           	: in std_logic_vector(15 downto 0);
		code           	: in std_logic_vector(3 downto 0);
		dout           	: out std_logic_vector(15 downto 0)
		);
end component;

component mux_2x16 is
	port
		(
		din0           	: in std_logic_vector (15 downto 0);
		din1           	: in std_logic_vector (15 downto 0);
		ctr_mux        	: in std_logic;
		dout           	: out std_logic_vector (15 downto 0)
		);
end component;

component mux_10x16 is
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
end component;

component mux_2x4 is
	port
		(
		din0           	: in std_logic_vector (3 downto 0);
		din1           	: in std_logic_vector (3 downto 0);
		ctr_mux        	: in std_logic;
		dout           	: out std_logic_vector (3 downto 0)
		);
end component;

end components;

package body components is
	
	procedure wave_gen (signal clk: out std_logic) is
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end wave_gen;
	
	procedure exec_inst (signal Idle : in std_logic;
		signal clk : out std_logic) is
		begin
			wave_gen(clk);
			while Idle = '0' loop
				wave_gen(clk);
			end loop;
	end exec_inst;
	
end components;
