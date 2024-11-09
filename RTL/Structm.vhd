library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;

entity Structm is
	port (
		bor_en         : out std_logic;
		br1_en         : out std_logic;
		br_en          : out std_logic;
		clk            : in std_logic;
		comp4_1_dout   : in std_logic;
		ctr_mux0       : out std_logic;
		ctr_mux1       : out std_logic;
		ctr_mux2       : out std_logic;
		ctr_mux3_0     : out std_logic;
		ctr_mux3_1     : out std_logic;
		ctr_mux3_2     : out std_logic;
		ctr_mux3_3     : out std_logic;
		dma            : in std_logic;
		ext_rdwr       : in std_logic;
		idle           : out std_logic;
		ir1_10         : in std_logic;
		ir1_11         : in std_logic;
		ir1_12         : in std_logic;
		ir1_14         : in std_logic;
		ir1_15         : in std_logic;
		ir1_8          : in std_logic;
		ir1_en         : out std_logic;
		ir2_en         : out std_logic;
		m              : in std_logic;
		m0_rdwr        : out std_logic;
		m1_rdwr        : out std_logic;
		pc_count       : out std_logic;
		pc_en          : out std_logic;
		ralu_en        : out std_logic;
		rst            : in std_logic;
		s              : in std_logic;
		tempreg16_1_en : out std_logic;
		zf             : in std_logic;
		zf_en          : out std_logic
	);
end Structm;

architecture ARC_Structm of Structm is

	type FSMStates is (
		a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15
	);

	signal currentState : FSMStates;

begin

	process (clk , rst)


	procedure proc_Structm is 
	begin

	bor_en <= '0';
	br1_en <= '0';
	br_en <= '0';
	ctr_mux0 <= '0';
	ctr_mux1 <= '0';
	ctr_mux2 <= '0';
	ctr_mux3_0 <= '0';
	ctr_mux3_1 <= '0';
	ctr_mux3_2 <= '0';
	ctr_mux3_3 <= '0';
	idle <= '0';
	ir1_en <= '0';
	ir2_en <= '0';
	m0_rdwr <= '0';
	m1_rdwr <= '0';
	pc_count <= '0';
	pc_en <= '0';
	ralu_en <= '0';
	tempreg16_1_en <= '0';
	zf_en <= '0';

	case currentState is
	when a1 =>
		if (s and dma and ext_rdwr and m) = '1' then
			ctr_mux3_0 <= '1';
			ctr_mux3_2 <= '1';
			m1_rdwr <= '1';
			ctr_mux1 <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and ext_rdwr and not m) = '1' then
			m0_rdwr <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and not ext_rdwr and m) = '1' then
			ctr_mux3_1 <= '1';
			ctr_mux1 <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (s and dma and not ext_rdwr and not m) = '1' then
			ctr_mux3_2 <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (s and not dma) = '1' then
			ctr_mux2 <= '1';
			ir1_en <= '1';
			currentState <= a2;

		else
			currentState <= a1;
			idle <= '1';

		end if;

	when a2 =>
		
			pc_count <= '1';
			currentState <= a3;

	when a3 =>
		if (ir1_15 and ir1_14 and ir1_11) = '1' then
			br_en <= '1';
			ctr_mux0 <= '1';
			currentState <= a4;

		elsif (ir1_15 and ir1_14 and not ir1_11) = '1' then
			br_en <= '1';
			ctr_mux3_1 <= '1';
			ctr_mux3_2 <= '1';
			currentState <= a5;

		elsif (ir1_15 and not ir1_14 and ir1_12) = '1' then
			br_en <= '1';
			ctr_mux0 <= '1';
			currentState <= a4;

		elsif (ir1_15 and not ir1_14 and not ir1_12 and ir1_10) = '1' then
			ir2_en <= '1';
			ctr_mux3_2 <= '1';
			ctr_mux2 <= '1';
			currentState <= a6;

		elsif (ir1_15 and not ir1_14 and not ir1_12 and not ir1_10) = '1' then
			br_en <= '1';
			currentState <= a5;

		elsif (not ir1_15 and ir1_10) = '1' then
			ir2_en <= '1';
			ctr_mux3_2 <= '1';
			ctr_mux2 <= '1';
			currentState <= a6;

		elsif (not ir1_15 and not ir1_10 and ir1_14 and ir1_11 and zf) = '1' then
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and not ir1_10 and ir1_14 and ir1_11 and not zf) = '1' then
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and not ir1_10 and ir1_14 and not ir1_11) = '1' then
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		else
			ir2_en <= '1';
			currentState <= a7;

		end if;

	when a4 =>
		if (ir1_15 and ir1_14) = '1' then
			currentState <= a1;
			idle <= '1';

		elsif (ir1_15 and not ir1_14) = '1' then
			br1_en <= '1';
			currentState <= a8;

		else
			ralu_en <= '1';
			zf_en <= '1';
			currentState <= a9;

		end if;

	when a5 =>
		
			bor_en <= '1';
			ctr_mux3_0 <= '1';
			ctr_mux0 <= '1';
			currentState <= a1;
			idle <= '1';

	when a6 =>
		
			pc_count <= '1';
			currentState <= a10;

	when a7 =>
		
			br_en <= '1';
			ctr_mux0 <= '1';
			currentState <= a4;

	when a8 =>
		if (ir1_10) = '1' then
			ir2_en <= '1';
			ctr_mux3_2 <= '1';
			ctr_mux2 <= '1';
			currentState <= a6;

		else
			bor_en <= '1';
			ctr_mux3_0 <= '1';
			currentState <= a1;
			idle <= '1';

		end if;

	when a9 =>
		
			bor_en <= '1';
			ctr_mux3_3 <= '1';
			ctr_mux3_0 <= '1';
			ctr_mux0 <= '1';
			currentState <= a1;
			idle <= '1';

	when a10 =>
		if (ir1_15 and ir1_8 and ir1_12 and comp4_1_dout) = '1' then
			br_en <= '1';
			ctr_mux3_1 <= '1';
			ctr_mux3_0 <= '1';
			currentState <= a11;

		elsif (ir1_15 and ir1_8 and ir1_12 and not comp4_1_dout) = '1' then
			br_en <= '1';
			currentState <= a13;

		elsif (ir1_15 and ir1_8 and not ir1_12) = '1' then
			br_en <= '1';
			ctr_mux3_3 <= '1';
			currentState <= a5;

		elsif (ir1_15 and not ir1_8 and comp4_1_dout and ir1_12) = '1' then
			br_en <= '1';
			ctr_mux3_1 <= '1';
			ctr_mux3_0 <= '1';
			currentState <= a11;

		elsif (ir1_15 and not ir1_8 and comp4_1_dout and not ir1_12) = '1' then
			br_en <= '1';
			ctr_mux3_1 <= '1';
			currentState <= a12;

		elsif (ir1_15 and not ir1_8 and not comp4_1_dout) = '1' then
			br_en <= '1';
			currentState <= a13;

		elsif (not ir1_15 and ir1_14 and zf and ir1_8) = '1' then
			ctr_mux3_3 <= '1';
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and ir1_14 and zf and not ir1_8 and comp4_1_dout) = '1' then
			ctr_mux3_1 <= '1';
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and ir1_14 and zf and not ir1_8 and not comp4_1_dout) = '1' then
			br_en <= '1';
			currentState <= a13;

		elsif (not ir1_15 and ir1_14 and not zf and ir1_11) = '1' then
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and ir1_14 and not zf and not ir1_11 and ir1_8) = '1' then
			ctr_mux3_3 <= '1';
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and ir1_14 and not zf and not ir1_11 and not ir1_8 and comp4_1_dout) = '1' then
			ctr_mux3_1 <= '1';
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		elsif (not ir1_15 and ir1_14 and not zf and not ir1_11 and not ir1_8 and not comp4_1_dout) = '1' then
			br_en <= '1';
			currentState <= a13;

		elsif (not ir1_15 and not ir1_14 and ir1_8) = '1' then
			br_en <= '1';
			ctr_mux0 <= '1';
			currentState <= a4;

		elsif (not ir1_15 and not ir1_14 and not ir1_8 and comp4_1_dout) = '1' then
			br_en <= '1';
			ctr_mux3_1 <= '1';
			currentState <= a12;

		else
			br_en <= '1';
			currentState <= a13;

		end if;

	when a11 =>
		
			ctr_mux3_0 <= '1';
			m1_rdwr <= '1';
			currentState <= a1;
			idle <= '1';

	when a12 =>
		if (ir1_15) = '1' then
			bor_en <= '1';
			ctr_mux3_0 <= '1';
			ctr_mux0 <= '1';
			currentState <= a1;
			idle <= '1';

		else
			ir2_en <= '1';
			ctr_mux3_0 <= '1';
			currentState <= a7;

		end if;

	when a13 =>
		
			tempreg16_1_en <= '1';
			currentState <= a14;

	when a14 =>
		
			ir2_en <= '1';
			ctr_mux3_1 <= '1';
			ctr_mux3_0 <= '1';
			ctr_mux3_2 <= '1';
			currentState <= a15;

	when a15 =>
		if (ir1_15 and ir1_12) = '1' then
			br_en <= '1';
			ctr_mux3_1 <= '1';
			ctr_mux3_0 <= '1';
			currentState <= a11;

		elsif (ir1_15 and not ir1_12) = '1' then
			br_en <= '1';
			ctr_mux3_1 <= '1';
			currentState <= a12;

		elsif (not ir1_15 and ir1_14) = '1' then
			ctr_mux3_1 <= '1';
			pc_en <= '1';
			currentState <= a1;
			idle <= '1';

		else
			br_en <= '1';
			ctr_mux3_1 <= '1';
			currentState <= a12;

		end if;

	end case;
	end proc_Structm;

	begin
		if (rst = '1') then
			bor_en <= '0';
			br1_en <= '0';
			br_en <= '0';
			ctr_mux0 <= '0';
			ctr_mux1 <= '0';
			ctr_mux2 <= '0';
			ctr_mux3_0 <= '0';
			ctr_mux3_1 <= '0';
			ctr_mux3_2 <= '0';
			ctr_mux3_3 <= '0';
			idle <= '0';
			ir1_en <= '0';
			ir2_en <= '0';
			m0_rdwr <= '0';
			m1_rdwr <= '0';
			pc_count <= '0';
			pc_en <= '0';
			ralu_en <= '0';
			tempreg16_1_en <= '0';
			zf_en <= '0';

			currentState <= a1;
			idle <= '1';

		elsif (clk'event and clk = '0') then
			idle <= '0';
			proc_Structm;
		end if;
	end process;

end ARC_Structm;
