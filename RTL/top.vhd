library IEEE;
use IEEE.std_logic_1164.all;
-----------------------------------------------
entity top is
    port 
    	(
        clk       : in  std_logic;
        dma       : in  std_logic;
        ext_adr   : in  std_logic_vector(15 downto 0);
        ext_in    : out std_logic_vector(15 downto 0);
        ext_out   : in  std_logic_vector(15 downto 0);
        ext_rdwr  : in  std_logic;
        idle      : out std_logic;
        inpr      : in  std_logic_vector(15 downto 0);
        m         : in  std_logic;
        outr      : out std_logic_vector(15 downto 0);
        rst       : in  std_logic;
        s         : in  std_logic
    	);
end top;
-----------------------------------------------
architecture arc_top of top is
component Structm is
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
end component;

component dp is
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

end component;

    -- output of  control unit
    signal ralu_en         : std_logic;
    signal zf_en           : std_logic;
    signal ir2_en          : std_logic;
    signal br_en           : std_logic;
    signal ctr_mux3_1      : std_logic;
    signal bor_en          : std_logic;
    signal ctr_mux3_3      : std_logic;
    signal ctr_mux3_0      : std_logic;
    signal ctr_mux0        : std_logic;
    signal pc_en           : std_logic;
    signal ctr_mux3_2      : std_logic;
    signal m1_rdwr         : std_logic;
    signal br1_en          : std_logic;
    signal ctr_mux1        : std_logic;
    signal m0_rdwr         : std_logic;
    signal pc_count        : std_logic;
    signal ctr_mux2        : std_logic;
    signal ir1_en          : std_logic;
    signal tempreg16_1_en  : std_logic;

    -- output of operational unit
    signal ir1_10          : std_logic;
    signal ir1_8           : std_logic;
    signal zf              : std_logic;
    signal ir1_15          : std_logic;
    signal ir1_14          : std_logic;
    signal ir1_12          : std_logic;
    signal ir1_11          : std_logic;
    signal comp4_1_dout    : std_logic;
              
begin
  
    u1_fsm : structm port map
    	(
		bor_en          => bor_en         ,
		br_en           => br_en          ,
		br1_en          => br1_en         ,
		clk             => clk            ,
		comp4_1_dout    => comp4_1_dout   ,
		ctr_mux0        => ctr_mux0       ,
		ctr_mux1        => ctr_mux1       ,
		ctr_mux2        => ctr_mux2       ,
		ctr_mux3_0      => ctr_mux3_0     ,
		ctr_mux3_1      => ctr_mux3_1     ,
		ctr_mux3_2      => ctr_mux3_2     ,
		ctr_mux3_3      => ctr_mux3_3     ,
		dma             => dma            ,
		ext_rdwr        => ext_rdwr       ,
		idle            => idle           ,
		ir1_10          => ir1_10         ,
		ir1_11          => ir1_11         ,
		ir1_12          => ir1_12         ,
		ir1_14          => ir1_14         ,
		ir1_15          => ir1_15         ,
		ir1_8           => ir1_8          ,
		ir1_en          => ir1_en         ,
		ir2_en          => ir2_en         ,
		m               => m              ,
		m0_rdwr         => m0_rdwr        ,
		m1_rdwr         => m1_rdwr        ,
		pc_count        => pc_count       ,
		pc_en           => pc_en          ,
		ralu_en         => ralu_en        ,
		rst             => rst            ,
		s               => s              ,
		tempreg16_1_en  => tempreg16_1_en ,
		zf              => zf             ,
		zf_en           => zf_en          
    	);

    u2_dp : dp port map
    	(
		clk             => clk            ,
		rst             => rst            ,
		ext_adr         => ext_adr        ,
		ext_out         => ext_out        ,
		inpr            => inpr           ,
		ralu_en         => ralu_en        ,
		zf_en           => zf_en          ,
		ir2_en          => ir2_en         ,
		br_en           => br_en          ,
		ctr_mux3_1      => ctr_mux3_1     ,
		bor_en          => bor_en         ,
		ctr_mux3_3      => ctr_mux3_3     ,
		ctr_mux3_0      => ctr_mux3_0     ,
		ctr_mux0        => ctr_mux0       ,
		pc_en           => pc_en          ,
		ctr_mux3_2      => ctr_mux3_2     ,
		m1_rdwr         => m1_rdwr        ,
		br1_en          => br1_en         ,
		ctr_mux1        => ctr_mux1       ,
		m0_rdwr         => m0_rdwr        ,
		pc_count        => pc_count       ,
		ctr_mux2        => ctr_mux2       ,
		ir1_en          => ir1_en         ,
		tempreg16_1_en  => tempreg16_1_en ,
		ext_in          => ext_in         ,
		outr            => outr           ,
		ir1_10          => ir1_10         ,
		ir1_8           => ir1_8          ,
		zf              => zf             ,
		ir1_15          => ir1_15         ,
		ir1_14          => ir1_14         ,
		ir1_12          => ir1_12         ,
		ir1_11          => ir1_11         ,
		comp4_1_dout    => comp4_1_dout   
    	);	
end arc_top;
-----------------------------------
configuration cfg_top of top is
	for arc_top
	end for;
end cfg_top;
------------------------------------
