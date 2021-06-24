package ReverseBytes;

import Vector::*;

//***************************************//
//                FUNCTIONS 			 //
//***************************************//
function Bit#(nd) reverseBYTES(Bit#(nd) a) provisos
(Mul#(8,nby,nd));
	Vector#(nby, Bit#(8)) vBytes = reverse(unpack(a));
	return pack(vBytes);
endfunction	

endpackage