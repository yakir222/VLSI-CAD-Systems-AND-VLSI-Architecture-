#include <iostream>
#include "systemc.h"

SC_MODULE(Funcmi)
{
	enum States { a1 = 1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14 };

	sc_signal< int > currentIf;
	sc_signal< sc_uint<16> > bor[16];
	sc_signal< sc_uint<16> > br;
	sc_signal< sc_uint<16> > br1;
	sc_signal< sc_uint<16> > ir1;
	sc_signal< sc_uint<16> > ir2;
	sc_signal< sc_uint<16> > m0[65536];
	sc_signal< sc_uint<16> > m1[65536];
	sc_signal< sc_uint<16> > pc;
	sc_signal< sc_uint<16> > ralu;
	sc_signal< bool > zf;
	sc_in< bool > dma;
	sc_in< sc_uint<16> > ext_adr;
	sc_in< sc_uint<16> > ext_out;
	sc_in< bool > ext_rdwr;
	sc_in< sc_uint<16> > inpr;
	sc_in< bool > m;
	sc_in< bool > rst;
	sc_in< bool > s;
	sc_out< sc_uint<16> > ext_in;
	sc_out< bool > idle;
	sc_out< sc_uint<16> > outr;
	sc_uint<4> bor_adr;
	FSMStates currentState;
	sc_uint<16> m0_adr;
	sc_uint<16> m1_adr;
	sc_in_clk clk;

	void main_proc();
	void proc_Funcmi();
	SC_CTOR(Funcmi)
		:
		clk                 ("clk"),
		dma                 ("dma"),
		ext_adr             ("ext_adr"),
		ext_in              ("ext_in"),
		ext_out             ("ext_out"),
		ext_rdwr            ("ext_rdwr"),
		idle                ("idle"),
		inpr                ("inpr"),
		m                   ("m"),
		outr                ("outr"),
		rst                 ("rst"),
		s                   ("s")
	{
		SC_METHOD(main_proc);
		sensitive << clk.pos() << rst;
	}
};
