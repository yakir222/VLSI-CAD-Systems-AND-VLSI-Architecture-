#include "Funcmi.h"

void Funcmi::main_proc()
{
	if (rst.read() == 1)
	{
		br.write(0);
		br1.write(0);
		ext_in.write(0);
		idle.write(0);
		ir1.write(0);
		ir2.write(0);
		outr.write(0);
		pc.write(0);
		ralu.write(0);
		zf.write(0);
		for (unsigned int i = 0; i < 16; ++i)
		{
			bor[i].write(0);
		}
		for (unsigned int i = 0; i < 65536; ++i)
		{
			m0[i].write(0);
		}
		for (unsigned int i = 0; i < 65536; ++i)
		{
			m1[i].write(0);
		}

		currentState = a1;
		idle.write(1);
	}
	else
	{
		idle.write(0);
		proc_Funcmi();
	}
}

void Funcmi::proc_Funcmi()
{
	sc_uint<16> ir1_tmp = ir1.read();

	ext_in.write(0);
	idle.write(0);
	outr.write(0);

	switch (currentState)
	{
	case a1:
		if (s.read() && dma.read() && ext_rdwr.read() && m.read())
		{
			m1_adr = ext_adr.read();
			currentState = a1;
			m1[m1_adr].write(ext_out.read());
			idle.write(1);
		}
		else if (s.read() && dma.read() && ext_rdwr.read() && !m.read())
		{
			m0_adr = ext_adr.read();
			currentState = a1;
			m0[m0_adr].write(ext_out.read());
			idle.write(1);
		}
		else if (s.read() && dma.read() && !ext_rdwr.read() && m.read())
		{
			m1_adr = ext_adr.read();
			currentState = a1;
			ext_in.write(m1[m1_adr].read());
			idle.write(1);
		}
		else if (s.read() && dma.read() && !ext_rdwr.read() && !m.read())
		{
			m0_adr = ext_adr.read();
			currentState = a1;
			ext_in.write(m0[m0_adr].read());
			idle.write(1);
		}
		else if (s.read() && !dma.read())
		{
			m0_adr = pc.read();
			currentState = a2;
			ir1.write(m0[m0_adr].read());
		}
		else 
		{
			currentState = a1;
			idle.write(1);
		}

		break;

	case a2:
		
		{
			currentState = a3;
			pc.write(pc.read()+1);
		}

		break;

	case a3:
		if (ir1_tmp[15] && ir1_tmp[14] && ir1_tmp[11])
		{
			bor_adr = ir1_tmp.range(7, 4);
			currentState = a4;
			br.write(bor[bor_adr].read());
		}
		else if (ir1_tmp[15] && ir1_tmp[14] && !ir1_tmp[11])
		{
			currentState = a5;
			br.write(inpr.read());
		}
		else if (ir1_tmp[15] && !ir1_tmp[14] && ir1_tmp[12])
		{
			bor_adr = ir1_tmp.range(7, 4);
			currentState = a4;
			br.write(bor[bor_adr].read());
		}
		else if (ir1_tmp[15] && !ir1_tmp[14] && !ir1_tmp[12] && ir1_tmp[10])
		{
			m0_adr = pc.read();
			currentState = a6;
			ir2.write(m0[m0_adr].read());
		}
		else if (ir1_tmp[15] && !ir1_tmp[14] && !ir1_tmp[12] && !ir1_tmp[10])
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a5;
			br.write(bor[bor_adr].read());
		}
		else if (!ir1_tmp[15] && ir1_tmp[10])
		{
			m0_adr = pc.read();
			currentState = a6;
			ir2.write(m0[m0_adr].read());
		}
		else if (!ir1_tmp[15] && !ir1_tmp[10] && ir1_tmp[14] && ir1_tmp[11] && zf.read())
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a1;
			pc.write(bor[bor_adr].read());
			idle.write(1);
		}
		else if (!ir1_tmp[15] && !ir1_tmp[10] && ir1_tmp[14] && ir1_tmp[11] && !zf.read())
		{
			currentState = a1;
			idle.write(1);
		}
		else if (!ir1_tmp[15] && !ir1_tmp[10] && ir1_tmp[14] && !ir1_tmp[11])
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a1;
			pc.write(bor[bor_adr].read());
			idle.write(1);
		}
		else 
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a7;
			ir2.write(bor[bor_adr].read());
		}

		break;

	case a4:
		if (ir1_tmp[15] && ir1_tmp[14])
		{
			currentState = a1;
			outr.write(br.read());
			idle.write(1);
		}
		else if (ir1_tmp[15] && !ir1_tmp[14])
		{
			currentState = a8;
			br1.write(br.read());
		}
		else 
		{
			alu_inp1 = br.read();
			alu_inp2 = ir2.read();
			alu_ctr = ir1_tmp.range(15, 11);
			currentState = a9;
			alu(alu_inp1, alu_inp2, alu_ctr, alu_outp, alu_z);
			ralu.write(alu_outp);
			zf.write(alu_z);
		}

		break;

	case a5:
		
		{
			bor_adr = ir1_tmp.range(7, 4);
			currentState = a1;
			bor[bor_adr].write(br.read());
			idle.write(1);
		}

		break;

	case a6:
		
		{
			currentState = a10;
			pc.write(pc.read()+1);
		}

		break;

	case a7:
		
		{
			bor_adr = ir1_tmp.range(7, 4);
			currentState = a4;
			br.write(bor[bor_adr].read());
		}

		break;

	case a8:
		if (ir1_tmp[10])
		{
			m0_adr = pc.read();
			currentState = a6;
			ir2.write(m0[m0_adr].read());
		}
		else 
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a1;
			bor[bor_adr].write(br.read());
			idle.write(1);
		}

		break;

	case a9:
		
		{
			bor_adr = ir1_tmp.range(7, 4);
			currentState = a1;
			bor[bor_adr].write(ralu.read());
			idle.write(1);
		}

		break;

	case a10:
		if (ir1_tmp[15] && ir1_tmp[8] && ir1_tmp[12] && ir1_tmp.range(3, 0) == 0000)
		{
			currentState = a11;
			br.write(br1.read());
		}
		else if (ir1_tmp[15] && ir1_tmp[8] && ir1_tmp[12] && !(ir1_tmp.range(3, 0) == 0000))
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a13;
			br.write(bor[bor_adr].read());
		}
		else if (ir1_tmp[15] && ir1_tmp[8] && !ir1_tmp[12])
		{
			currentState = a5;
			br.write(ir2.read());
		}
		else if (ir1_tmp[15] && !ir1_tmp[8] && ir1_tmp[12] && ir1_tmp.range(3, 0) == 0000)
		{
			currentState = a11;
			br.write(br1.read());
		}
		else if (ir1_tmp[15] && !ir1_tmp[8] && !ir1_tmp[12] && ir1_tmp.range(3, 0) == 0000)
		{
			m1_adr = ir2.read();
			currentState = a12;
			br.write(m1[m1_adr].read());
		}
		else if (ir1_tmp[15] && !ir1_tmp[8] && !(ir1_tmp.range(3, 0) == 0000))
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a13;
			br.write(bor[bor_adr].read());
		}
		else if (!ir1_tmp[15] && ir1_tmp[14] && zf.read() && ir1_tmp[8])
		{
			currentState = a1;
			pc.write(ir2.read());
			idle.write(1);
		}
		else if (!ir1_tmp[15] && ir1_tmp[14] && zf.read() && !ir1_tmp[8] && ir1_tmp.range(3, 0) == 0000)
		{
			m1_adr = ir2.read();
			currentState = a1;
			pc.write(m1[m1_adr].read());
			idle.write(1);
		}
		else if (!ir1_tmp[15] && ir1_tmp[14] && zf.read() && !ir1_tmp[8] && !(ir1_tmp.range(3, 0) == 0000))
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a13;
			br.write(bor[bor_adr].read());
		}
		else if (!ir1_tmp[15] && ir1_tmp[14] && !zf.read() && ir1_tmp[11])
		{
			currentState = a1;
			idle.write(1);
		}
		else if (!ir1_tmp[15] && ir1_tmp[14] && !zf.read() && !ir1_tmp[11] && ir1_tmp[8])
		{
			currentState = a1;
			pc.write(ir2.read());
			idle.write(1);
		}
		else if (!ir1_tmp[15] && ir1_tmp[14] && !zf.read() && !ir1_tmp[11] && !ir1_tmp[8] && ir1_tmp.range(3, 0) == 0000)
		{
			m1_adr = ir2.read();
			currentState = a1;
			pc.write(m1[m1_adr].read());
			idle.write(1);
		}
		else if (!ir1_tmp[15] && ir1_tmp[14] && !zf.read() && !ir1_tmp[11] && !ir1_tmp[8] && !(ir1_tmp.range(3, 0) == 0000))
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a13;
			br.write(bor[bor_adr].read());
		}
		else if (!ir1_tmp[15] && !ir1_tmp[14] && ir1_tmp[8])
		{
			bor_adr = ir1_tmp.range(7, 4);
			currentState = a4;
			br.write(bor[bor_adr].read());
		}
		else if (!ir1_tmp[15] && !ir1_tmp[14] && !ir1_tmp[8] && ir1_tmp.range(3, 0) == 0000)
		{
			m1_adr = ir2.read();
			currentState = a12;
			br.write(m1[m1_adr].read());
		}
		else 
		{
			bor_adr = ir1_tmp.range(3, 0);
			currentState = a13;
			br.write(bor[bor_adr].read());
		}

		break;

	case a11:
		
		{
			m1_adr = ir2.read();
			currentState = a1;
			m1[m1_adr].write(br.read());
			idle.write(1);
		}

		break;

	case a12:
		if (ir1_tmp[15])
		{
			bor_adr = ir1_tmp.range(7, 4);
			currentState = a1;
			bor[bor_adr].write(br.read());
			idle.write(1);
		}
		else 
		{
			currentState = a7;
			ir2.write(br.read());
		}

		break;

	case a13:
		
		{
			currentState = a14;
			ir2.write(ir2.read()+br.read());
		}

		break;

	case a14:
		if (ir1_tmp[15] && ir1_tmp[12])
		{
			currentState = a11;
			br.write(br1.read());
		}
		else if (ir1_tmp[15] && !ir1_tmp[12])
		{
			m1_adr = ir2.read();
			currentState = a12;
			br.write(m1[m1_adr].read());
		}
		else if (!ir1_tmp[15] && ir1_tmp[14])
		{
			m1_adr = ir2.read();
			currentState = a1;
			pc.write(m1[m1_adr].read());
			idle.write(1);
		}
		else 
		{
			m1_adr = ir2.read();
			currentState = a12;
			br.write(m1[m1_adr].read());
		}

		break;

	}
}

#ifdef MTI_SYSTEMC
SC_MODULE_EXPORT(Funcmi);
#endif