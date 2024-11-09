<external_specifications>
    <functional_specifications>
        <declarations>
            <signal name="bor" width="16" size="16" />
            <signal name="m0"  width="16" size="65536" />
			<signal name="m1"  width="16" size="65536" />
			<port name="dma" width="1" direction="in" />
            <port name="ext_adr" width="16" direction="in" />
            <port name="ext_in" width="16" direction="out" />
            <port name="ext_out" width="16" direction="in" />
            <port name="ext_rdwr" width="1" direction="in" />
            <port name="inpr" width="16" direction="in" />
            <port name="m" width="1" direction="in" />
            <port name="outr" width="16" direction="out" />
            <port name="s" width="1" direction="in" />
            <signal name="br" width="16" />
            <signal name="br1" width="16" />
            <signal name="ir1" width="16" />
            <signal name="ir2" width="16" />
            <signal name="pc" width="16" />
            <signal name="ralu" width="16" />
            <signal name="zf" width="1" />
            <variable name="bor_adr" width="4" />
            <variable name="m0_adr" width="16" />
            <variable name="m1_adr" width="16" />
        </declarations>
        <functions>
            <func name="alu">
                <param name="alu_inp1" width="16" />
                <param name="alu_inp2" width="16" />
                <param name="alu_ctr" width="5" />
                <param name="alu_outp" width="16" />
                <param name="alu_z" width="1" />
            </func>
        </functions>
        <required_libraries>
            <vhdl>
                <library name="my_package" />
            </vhdl>
        </required_libraries>
    </functional_specifications>
</external_specifications>