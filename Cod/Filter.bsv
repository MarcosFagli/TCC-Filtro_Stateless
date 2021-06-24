package Filter;


//***************************************//
//               IMPORTS 				 //
//***************************************//	
import StmtFSM::*;
import FIFOF::*;
import TypeDef::*;
import Check::*;


//***************************************//
//               INTERFACES				 //
//***************************************//	
interface Filter;
	method Action fifoToCheck(Bit#(294) v);
	method Action fifoToFilter(Bit#(73) d);

	method Bool validSend;
	method ActionValue#(Bit#(73)) getToSend ();
endinterface


//***************************************//
//                TYPES 				 //
//***************************************//
/*
typedef struct {
	Bit#(32) ip_dst;
	Bit#(32) ip_src;
	Bit#(16) port_dst;
	Bit#(16) port_dst;
} Ipv4Filter deriving (Eq, Bits, FShow);
*/

//***************************************//
//               MODULE 				 //
//***************************************//	
(* synthesize *)
module mkFilter(Filter);


//***************************************//
//               DECLARATIONS			 //
//***************************************//
	// Pacotes recebidos a serem filtrados
	FIFOF#(Bit#(73)) fifoIn <- mkSizedFIFOF(128);
	FIFOF#(Bit#(294)) fifoCheck <- mkSizedFIFOF(32);	
	FIFOF#(Bit#(73)) fifoOut <- mkSizedFIFOF(32);

	// Sinalização
	Reg#(Bool) active <- mkReg(False);

	// Sinais de saída 
	Reg#(Bit#(1)) tx_ready  <- mkReg(1'b1);

	Reg#(Data) tx_data  <- mkReg(?);
	Reg#(Byte) tx_keep  <- mkReg(8'hFF); 
	Reg#(Bit#(1)) tx_valid <- mkReg(1'b0);
	Reg#(Bit#(1)) tx_user  <- mkReg(1'b0);
	Reg#(Bit#(1)) tx_last  <- mkReg(1'b0);


//***************************************//
//               FUNCTIONS 				 //
//***************************************//	
// Filtro IPv4
	function Bool ip4Filter(Bit#(96) ip4f);
		//, 
		//function Bool checkIPv4(IP4Addr ip4_dst, 
		//	IP4Addr ip4_src, PortAddr port_dst, 
		//	PortAddr port_src)
		//	);

		let ip4_dst = ip4f[95:64];
		let ip4_src = ip4f[63:32];
		let port_dst = ip4f[31:16];
		let port_src = ip4f[15:0];

		return checkIPv4(ip4_dst, ip4_src, port_dst, port_src);

	endfunction


// Filtro IPv6
	function Bool ip6Filter(Bit#(288) ip6f);
/*		, 
		function Bool checkIPv6(Bit#(32) ip6_dst, 
			Bit#(32) ip6_src, Bit#(16) port_dst, 
			Bit#(16) port_src)
*/
		//	);

		let ip6_dst = ip6f[287:160];
		let ip6_src = ip6f[159:32];		
		let port_dst = ip6f[31:16];
		let port_src = ip6f[15:0];	

		return checkIPv6(ip6_dst, ip6_src, port_dst, port_src);
	endfunction

//***************************************//
//             FSM - Filter 	    	 //
//***************************************//
	Stmt stmt_rcv = (seq

		while (True) seq
					
			await(fifoCheck.notEmpty);

			// Versão IP, Sinal negativo para discartar, Sinal positivo para filtrar
			// e o Filtro IPv4
			if (fifoCheck.first[293:290] == 4'd4 && fifoCheck.first[289] == 1'b0 
				&& fifoCheck.first[288] == 1'b1 && !ip4Filter(fifoCheck.first[95:0]))
				seq
					
					fifoCheck.deq;

					// Envia o pacote
					while (fifoIn.first[72] != 1'b1)
						action
							fifoIn.deq;
							fifoOut.enq(fifoIn.first);
						endaction

					// Envia o último dado
					action					
						fifoIn.deq;
						fifoOut.enq(fifoIn.first);
					endaction
				
				endseq

			// Versão IP, Sinal negativo para discartar, Sinal positivo para filtrar
			// e o Filtro IPv6
			else if (fifoCheck.first[293:290] == 4'd6 && fifoCheck.first[289] == 1'b0 
				&& fifoCheck.first[288] == 1'b1 && !ip6Filter(fifoCheck.first[287:0]))
				seq
					
					fifoCheck.deq;

					// Envia o pacote
					while (fifoIn.first[72] != 1'b1)
						action
							fifoIn.deq;
							fifoOut.enq(fifoIn.first);
						endaction

					// Envia o último dado
					action					
						fifoIn.deq;
						fifoOut.enq(fifoIn.first);
					endaction
				
				endseq

			// Sinal negativo para discartar e sinal negativo para filtrar
			else if (fifoCheck.first[289] == 1'b0 && fifoCheck.first[288] == 1'b0)
				seq

					fifoCheck.deq;

					// Envia o pacote
					while (fifoIn.first[72] != 1'b1)
						action
							fifoIn.deq;
							fifoOut.enq(fifoIn.first);
						endaction

					// Envia o último dado do pacote
					action					
						fifoIn.deq;
						fifoOut.enq(fifoIn.first);
					endaction
				
				endseq

			// Discarta o pacote
			else 
				seq

					fifoCheck.deq;

					while (fifoIn.first[72] != 1'b1)
						fifoIn.deq;

					fifoIn.deq;
				endseq

		endseq

	endseq);

	mkAutoFSM(stmt_rcv);

//***************************************//
//               METHODS 				 //
//***************************************//
	// Sinal para ativar o filtro
	method Action fifoToCheck(Bit#(294) v);
		fifoCheck.enq(v);
	endmethod	

	// Fila que recebe os pacotes 
	method Action fifoToFilter(Bit#(73) d);
		fifoIn.enq(d);
	endmethod

	// Valida o envio - Fila não está vazia
	method Bool validSend;
		return fifoOut.notEmpty;
	endmethod

// Decrementa e envia os dados da fila
	method ActionValue#(Bit#(73)) getToSend ();
		fifoOut.deq;
		return fifoOut.first;
	endmethod

endmodule

endpackage