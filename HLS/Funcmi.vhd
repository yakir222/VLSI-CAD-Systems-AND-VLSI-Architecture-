library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity Funcmi is
	port (
		clk          : in std_logic;
		dma          : in std_logic;
		ext_adr      : in std_logic_vector(15 downto 0);
		ext_in       : out std_logic_vector(15 downto 0);
		ext_out      : in std_logic_vector(15 downto 0);
		ext_rdwr     : in std_logic;
		idle         : out std_logic;
		inpr         : in std_logic_vector(15 downto 0);
		m            : in std_logic;
		outr         : out std_logic_vector(15 downto 0);
		rst          : in std_logic;
		s            : in std_logic
	);
end Funcmi;

architecture ARC_Funcmi of Funcmi is

	type FSMStates is (
		a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14
	);
	type bor_type is array (integer range 0 to 15) of std_logic_vector(15 downto 0);
	type m0_type is array (integer range 0 to 65535) of std_logic_vector(15 downto 0);
	type m1_type is array (integer range 0 to 65535) of std_logic_vector(15 downto 0);

	signal bor : bor_type;
	signal br : std_logic_vector(15 downto 0);
	signal br1 : std_logic_vector(15 downto 0);
	signal currentState : FSMStates;
	signal ir1 : std_logic_vector(15 downto 0);
	signal ir2 : std_logic_vector(15 downto 0);
	signal m0 : m0_type;
	signal m1 : m1_type;
	signal pc : std_logic_vector(15 downto 0);
	signal ralu : std_logic_vector(15 downto 0);
	signal zf : std_logic;

begin

	process (clk , rst)

		variable alu_ctr : std_logic_vector(4 downto 0);
		variable alu_inp1 : std_logic_vector(15 downto 0);
		variable alu_inp2 : std_logic_vector(15 downto 0);
		variable alu_outp : std_logic_vector(15 downto 0);
		variable alu_z : std_logic;
		variable bor_adr : std_logic_vector(3 downto 0);
		variable m0_adr : std_logic_vector(15 downto 0);
		variable m1_adr : std_logic_vector(15 downto 0);

	procedure proc_Funcmi is 
	begin


	case currentState is
	when a1 =>
		if (s and dma and ext_rdwr and m) = '1' then
			m1_adr := ext_adr;
			m1(to_integer(unsigned(m1_adr))) <= ext_out;
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and ext_rdwr and not m) = '1' then
			m0_adr := ext_adr;
			m0(to_integer(unsigned(m0_adr))) <= ext_out;
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and not ext_rdwr and m) = '1' then
			m1_adr := ext_adr;
			ext_in <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and not ext_rdwr and not m) = '1' then
			m0_adr := ext_adr;
			ext_in <= m0(to_integer(unsigned(m0_adr)));
			currentState <= a1;
			idle <= '1';

		elsif (s and not dma) = '1' then
			m0_adr := pc;
			ir1 <= m0(to_integer(unsigned(m0_adr)));
			currentState <= a2;

		else
			currentState <= a1;
			idle <= '1';

		end if;

	when a2 =>
		
			pc <= std_logic_vector(unsigned(pc) + 1);
			currentState <= a3;

	when a3 =>
		if (ir1(15) and ir1(14) and ir1(11)) = '1' then
			bor_adr := ir1(7 downto 4);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a4;

		elsif (ir1(15) and ir1(14) and not ir1(11)) = '1' then
			br <= inpr;
			currentState <= a5;

		elsif (ir1(15) and not ir1(14) and ir1(12)) = '1' then
			bor_adr := ir1(7 downto 4);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a4;

		elsif (ir1(15) and not ir1(14) and not ir1(12) and ir1(10)) = '1' then
			m0_adr := pc;
			ir2 <= m0(to_integer(unsigned(m0_adr)));
			currentState <= a6;

		elsif (ir1(15) and not ir1(14) and not ir1(12) and not ir1(10)) = '1' then
			bor_adr := ir1(3 downto 0);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a5;

		elsif (not ir1(15) and ir1(10)) = '1' then
			m0_adr := pc;
			ir2 <= m0(to_integer(unsigned(m0_adr)));
			currentState <= a6;

		elsif (not ir1(15) and not ir1(10) and ir1(14) and ir1(11) and zf) = '1' then
			bor_adr := ir1(3 downto 0);
			pc <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a1;
			idle <= '1';

		elsif (not ir1(15) and not ir1(10) and ir1(14) and ir1(11) and not zf) = '1' then
			currentState <= a1;
			idle <= '1';

		elsif (not ir1(15) and not ir1(10) and ir1(14) and not ir1(11)) = '1' then
			bor_adr := ir1(3 downto 0);
			pc <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a1;
			idle <= '1';

		else
			bor_adr := ir1(3 downto 0);
			ir2 <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a7;

		end if;

	when a4 =>
		if (ir1(15) and ir1(14)) = '1' then
			outr <= br;
			currentState <= a1;
			idle <= '1';

		elsif (ir1(15) and not ir1(14)) = '1' then
			br1 <= br;
			currentState <= a8;

		else
			alu_inp1 := br;
			alu_inp2 := ir2;
			alu_ctr := ir1(15 downto 11);
			alu(alu_inp1, alu_inp2, alu_ctr, alu_outp, alu_z);
			ralu <= alu_outp;
			zf <= alu_z;
			currentState <= a9;

		end if;

	when a5 =>
		
			bor_adr := ir1(7 downto 4);
			bor(to_integer(unsigned(bor_adr))) <= br;
			currentState <= a1;
			idle <= '1';

	when a6 =>
		
			pc <= std_logic_vector(unsigned(pc) + 1);
			currentState <= a10;

	when a7 =>
		
			bor_adr := ir1(7 downto 4);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a4;

	when a8 =>
		if (ir1(10)) = '1' then
			m0_adr := pc;
			ir2 <= m0(to_integer(unsigned(m0_adr)));
			currentState <= a6;

		else
			bor_adr := ir1(3 downto 0);
			bor(to_integer(unsigned(bor_adr))) <= br;
			currentState <= a1;
			idle <= '1';

		end if;

	when a9 =>
		
			bor_adr := ir1(7 downto 4);
			bor(to_integer(unsigned(bor_adr))) <= ralu;
			currentState <= a1;
			idle <= '1';

	when a10 =>
		if (ir1(3 downto 0) = "0000" and (ir1(15) and ir1(8) and ir1(12)) = '1') then
			br <= br1;
			currentState <= a11;

		elsif (not (ir1(3 downto 0) = "0000") and (ir1(15) and ir1(8) and ir1(12)) = '1') then
			bor_adr := ir1(3 downto 0);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a13;

		elsif (ir1(15) and ir1(8) and not ir1(12)) = '1' then
			br <= ir2;
			currentState <= a5;

		elsif (ir1(3 downto 0) = "0000" and (ir1(15) and not ir1(8) and ir1(12)) = '1') then
			br <= br1;
			currentState <= a11;

		elsif (ir1(3 downto 0) = "0000" and (ir1(15) and not ir1(8) and not ir1(12)) = '1') then
			m1_adr := ir2;
			br <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a12;

		elsif (not (ir1(3 downto 0) = "0000") and (ir1(15) and not ir1(8)) = '1') then
			bor_adr := ir1(3 downto 0);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a13;

		elsif (not ir1(15) and ir1(14) and zf and ir1(8)) = '1' then
			pc <= ir2;
			currentState <= a1;
			idle <= '1';

		elsif (ir1(3 downto 0) = "0000" and (not ir1(15) and ir1(14) and zf and not ir1(8)) = '1') then
			m1_adr := ir2;
			pc <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a1;
			idle <= '1';

		elsif (not (ir1(3 downto 0) = "0000") and (not ir1(15) and ir1(14) and zf and not ir1(8)) = '1') then
			bor_adr := ir1(3 downto 0);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a13;

		elsif (not ir1(15) and ir1(14) and not zf and ir1(11)) = '1' then
			currentState <= a1;
			idle <= '1';

		elsif (not ir1(15) and ir1(14) and not zf and not ir1(11) and ir1(8)) = '1' then
			pc <= ir2;
			currentState <= a1;
			idle <= '1';

		elsif (ir1(3 downto 0) = "0000" and (not ir1(15) and ir1(14) and not zf and not ir1(11) and not ir1(8)) = '1') then
			m1_adr := ir2;
			pc <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a1;
			idle <= '1';

		elsif (not (ir1(3 downto 0) = "0000") and (not ir1(15) and ir1(14) and not zf and not ir1(11) and not ir1(8)) = '1') then
			bor_adr := ir1(3 downto 0);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a13;

		elsif (not ir1(15) and not ir1(14) and ir1(8)) = '1' then
			bor_adr := ir1(7 downto 4);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a4;

		elsif (ir1(3 downto 0) = "0000" and (not ir1(15) and not ir1(14) and not ir1(8)) = '1') then
			m1_adr := ir2;
			br <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a12;

		else
			bor_adr := ir1(3 downto 0);
			br <= bor(to_integer(unsigned(bor_adr)));
			currentState <= a13;

		end if;

	when a11 =>
		
			m1_adr := ir2;
			m1(to_integer(unsigned(m1_adr))) <= br;
			currentState <= a1;
			idle <= '1';

	when a12 =>
		if (ir1(15)) = '1' then
			bor_adr := ir1(7 downto 4);
			bor(to_integer(unsigned(bor_adr))) <= br;
			currentState <= a1;
			idle <= '1';

		else
			ir2 <= br;
			currentState <= a7;

		end if;

	when a13 =>
		
			ir2 <= std_logic_vector(unsigned(ir2) + unsigned(br));
			currentState <= a14;

	when a14 =>
		if (ir1(15) and ir1(12)) = '1' then
			br <= br1;
			currentState <= a11;

		elsif (ir1(15) and not ir1(12)) = '1' then
			m1_adr := ir2;
			br <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a12;

		elsif (not ir1(15) and ir1(14)) = '1' then
			m1_adr := ir2;
			pc <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a1;
			idle <= '1';

		else
			m1_adr := ir2;
			br <= m1(to_integer(unsigned(m1_adr)));
			currentState <= a12;

		end if;

	end case;
	end proc_Funcmi;

	begin
		if (rst = '1') then
			br <= (others => '0');
			br1 <= (others => '0');
			ext_in <= (others => '0');
			idle <= '0';
			ir1 <= (others => '0');
			ir2 <= (others => '0');
			outr <= (others => '0');
			pc <= (others => '0');
			ralu <= (others => '0');
			zf <= '0';

			currentState <= a1;
			idle <= '1';

		elsif (clk'event and clk = '1') then
			idle <= '0';
			proc_Funcmi;
		end if;
	end process;

end ARC_Funcmi;
