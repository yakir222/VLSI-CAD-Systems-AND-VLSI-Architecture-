-- Automatically generated using Goals v1.0.1.170
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.components.all;
-----------------------------
entity dp is
	port
		(
		
		-- Inputs from control unit
		ralu_en          :  in    std_logic;	--(y1)
		zf_en            :  in    std_logic;	--(y2)
		ir2_en           :  in    std_logic;	--(y3)
		br_en            :  in    std_logic;	--(y4)
		ctr_mux3_1       :  in    std_logic;	--(y5)
		bor_en           :  in    std_logic;	--(y6)
		ctr_mux3_3       :  in    std_logic;	--(y7)
		ctr_mux3_0       :  in    std_logic;	--(y8)
		ctr_mux0         :  in    std_logic;	--(y9)
		pc_en            :  in    std_logic;	--(y10)
		ctr_mux3_2       :  in    std_logic;	--(y11)
		m1_rdwr          :  in    std_logic;	--(y12)
		br1_en           :  in    std_logic;	--(y13)
		ctr_mux1         :  in    std_logic;	--(y14)
		m0_rdwr          :  in    std_logic;	--(y15)
		pc_count         :  in    std_logic;	--(y16)
		ctr_mux2         :  in    std_logic;	--(y17)
		ir1_en           :  in    std_logic;	--(y18)
		tempreg16_1_en   :  in    std_logic;	--(y19)
		
		-- Inputs from outside
		clk              :  in    std_logic;
		rst              :  in    std_logic;
		ext_adr          :  in    std_logic_vector(15 downto 0);
		ext_out          :  in    std_logic_vector(15 downto 0);
		inpr             :  in    std_logic_vector(15 downto 0);
		
		-- Outputs to control unit
		ir1_10           :  out   std_logic;  --(x1)
		ir1_8            :  out   std_logic;  --(x2)
		zf               :  out   std_logic;  --(x5)
		ir1_15           :  out   std_logic;  --(x6)
		ir1_14           :  out   std_logic;  --(x7)
		ir1_12           :  out   std_logic;  --(x8)
		ir1_11           :  out   std_logic;  --(x9)
		comp4_1_dout     :  out   std_logic;  --(x12)
		
		-- Outputs to outside
		ext_in           :  out   std_logic_vector(15 downto 0);
		outr             :  out   std_logic_vector(15 downto 0)
		);

end dp;
-----------------------------------------------
architecture arc_dp of dp is
	signal mux1_dout          :  std_logic_vector (15 downto 0);
	signal mux2_dout          :  std_logic_vector (15 downto 0);
	signal mux3_dout          :  std_logic_vector (15 downto 0);
	signal mux0_dout          :  std_logic_vector (3 downto 0);
	signal alu_outp           :  std_logic_vector (15 downto 0);
	signal alu_z              :  std_logic;
	signal alu16_1_dout       :  std_logic_vector (15 downto 0);
	signal bor_dout           :  std_logic_vector (15 downto 0);
	signal br_dout            :  std_logic_vector (15 downto 0);
	signal br1_dout           :  std_logic_vector (15 downto 0);
	signal ir1_dout           :  std_logic_vector (15 downto 0);
	signal ir2_dout           :  std_logic_vector (15 downto 0);
	signal m0_dout            :  std_logic_vector (15 downto 0);
	signal m1_dout            :  std_logic_vector (15 downto 0);
	signal pc_dout            :  std_logic_vector (15 downto 0);
	signal ralu_dout          :  std_logic_vector (15 downto 0);
	signal tempreg16_1_dout   :  std_logic_vector (15 downto 0);
	signal ctr_mux3           :  std_logic_vector (3 downto 0);
begin
	
	---------
	-- Mux 1
	---------
	u1_mux1     :  mux_2x16   port map (ir2_dout, ext_adr, ctr_mux1, mux1_dout);
	
	---------
	-- Mux 2
	---------
	u2_mux2     :  mux_2x16   port map (ext_adr, pc_dout, ctr_mux2, mux2_dout);
	
	---------
	-- Mux 3
	---------
	u3_mux3     :  mux_10x16  port map (bor_dout, br_dout, m1_dout, br1_dout, m0_dout, ext_out, inpr, tempreg16_1_dout, ir2_dout, ralu_dout, ctr_mux3, mux3_dout);
	
	---------
	-- Mux 0
	---------
	u4_mux0     :  mux_2x4    port map (ir1_dout(3 downto 0), ir1_dout(7 downto 4), ctr_mux0, mux0_dout);
	
	---------
	-- alu
	---------
	u5_alu      :  alu        port map (br_dout, ir2_dout, ir1_dout(15 downto 11), alu_outp, alu_z);
	
	---------
	-- zf
	---------
	u6_zf       :  d_ff       port map (clk, alu_z, rst, zf_en, zf);
	
	---------
	-- br
	---------
	u7_br       :  reg_16bit  port map (clk, rst, mux3_dout, br_en, br_dout);
	
	---------
	-- br1
	---------
	u8_br1      :  reg_16bit  port map (clk, rst, br_dout, br1_en, br1_dout);
	
	---------
	-- ir1
	---------
	u9_ir1      :  reg_16bit  port map (clk, rst, m0_dout, ir1_en, ir1_dout);
	
	---------
	-- ir2
	---------
	u10_ir2     :  reg_16bit  port map (clk, rst, mux3_dout, ir2_en, ir2_dout);
	
	---------
	-- ralu
	---------
	u11_ralu    :  reg_16bit  port map (clk, rst, alu_outp, ralu_en, ralu_dout);
	
	---------
	-- tempreg16_1
	---------
	u12_tempreg16_1  :  reg_16bit  port map (clk, rst, alu16_1_dout, tempreg16_1_en, tempreg16_1_dout);
	
	---------
	-- bor
	---------
	u13_bor     :  bor_4adr_16bit port map (clk, rst, mux0_dout, mux3_dout, bor_en, bor_dout);
	
	---------
	-- m0
	---------
	u14_m0      :  ram_16adr_16bit port map (clk, mux2_dout, ext_out, m0_rdwr, m0_dout);
	
	---------
	-- m1
	---------
	u15_m1      :  ram_16adr_16bit port map (clk, mux1_dout, mux3_dout, m1_rdwr, m1_dout);
	
	---------
	-- pc
	---------
	u16_pc      :  counter_p_16bit port map (clk, rst, pc_en, pc_count, mux3_dout, pc_dout);
	
	---------
	-- comp4_1
	---------
	u17_comp4_1  :  g_comp     generic map (comp_kind => "eq", size => 4) port map (ir1_dout(3 downto 0), x"0", comp4_1_dout);
	
	---------
	-- alu16_1
	---------
	u18_alu16_1  :  alu_16bit  port map (ir2_dout, br_dout, "0001", alu16_1_dout);
	
	
	
	-----------------------
	-- Additional Signals
	-----------------------
	
	ctr_mux3       	<=	ctr_mux3_3 & ctr_mux3_2 & ctr_mux3_1 & ctr_mux3_0;
	ext_in         	<=	mux3_dout;
	outr           	<=	br_dout;
	ir1_10         	<=	ir1_dout(10);
	ir1_8          	<=	ir1_dout(8);
	ir1_15         	<=	ir1_dout(15);
	ir1_14         	<=	ir1_dout(14);
	ir1_12         	<=	ir1_dout(12);
	ir1_11         	<=	ir1_dout(11);
	
	
end  arc_dp;
-----------------------------------------------
configuration cfg_dp of dp is
	for arc_dp
	end for;
end cfg_dp;
-----------------------------
