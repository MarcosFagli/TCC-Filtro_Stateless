package TCP;


//***************************************//
//               IMPORTS 				 //
//***************************************//	
import StmtFSM::*;
import TypeDef::*;


//***************************************//
//               INTERFACES				 //
//***************************************//
interface TCP;
	method Action activate(Bool v);

	method Action parser(Data d);

	method Action pairOrodd (Bool signal); //False é par, True é ímpar
	method Action headerPair(Bit#(16) pair); 
	method Action headerOdd(Bit#(48) odd); 	

	method PortAddr portSrc;
	method PortAddr portDst;
endinterface


//***************************************//
//               MODULE 				 //
//***************************************//	
(* synthesize *)
module mkTCP(TCP);


//***************************************//
//               DECLARATIONS			 //
//***************************************//	
	// Dados e verificações
	Reg#(Bit#(64)) data  <- mkReg(?);

	// Auxiliares
	Reg#(Bit#(16)) temp <- mkReg(16'h0000);

	// // Sinalização
	Reg#(Bool) active <- mkReg(False);
	Reg#(Bool) valid_rcv <- mkReg(False);

	// Dados cabeçalho TCP recebidos junto com o 
	// fim do cabeçalho IP
	Reg#(Bool) pair_odd <- mkReg(False);
	Reg#(Bit#(16)) pair_header_down <- mkReg(?);
	Reg#(Bit#(48)) odd_header_down <- mkReg(?);

	// Início dos dados passar para a aplicação
	Reg#(Bit#(48)) pair_header_up <- mkReg(?);
	Reg#(Bit#(16)) odd_header_up <- mkReg(?);

	// Valor para cálculo do tcp length
	Reg#(Bit#(16)) tcp_length <- mkReg(16'h0000);	

	// Cabeçalho TCP
	Reg#(PortAddr) port_src <- mkReg(?);
	Reg#(PortAddr) port_dst <- mkReg(?);
	Reg#(Bit#(32)) seq_num <- mkReg(?);
	Reg#(Bit#(32)) ack_num <- mkReg(?);	 
	Reg#(Bit#(4)) data_offset <- mkReg(?);
	Reg#(Bit#(3)) reserved <- mkReg(?);
	Reg#(Bit#(1)) flag_ns <- mkReg(?);
	Reg#(Bit#(1)) flag_cwr <- mkReg(?);
	Reg#(Bit#(1)) flag_ece <- mkReg(?);
	Reg#(Bit#(1)) flag_urg <- mkReg(?);
	Reg#(Bit#(1)) flag_ack <- mkReg(?);
	Reg#(Bit#(1)) flag_psh <- mkReg(?);
	Reg#(Bit#(1)) flag_rst <- mkReg(?);
	Reg#(Bit#(1)) flag_syn <- mkReg(?);
	Reg#(Bit#(1)) flag_fin <- mkReg(?);
	Reg#(Bit#(16)) window_size <- mkReg(?);
	Reg#(Bit#(16)) checksum <- mkReg(?);
	Reg#(Bit#(16)) urgent_pointer <- mkReg(?); // Se a flag_urg estiver setada


//***************************************//
//          FSM - Cabeçalho TCP    		 //
//***************************************//
	Stmt stmt_rcv = (seq

		while (True) seq
		

			valid_rcv <= False;


			action
				// Aguarda sinal para iniciar
				await (active);

				if (pair_odd) begin // Se o protocolo anterior tem tamanho ímpar
					port_src <= odd_header_down[47:32];
					port_dst <= odd_header_down[31:16];
					seq_num <= {odd_header_down[15:0], data[63:48]};
					ack_num <= data[47:16];
					data_offset <= data[15:12];
					reserved <= data[11:9];
					flag_ns <= data[8];
					flag_cwr <= data[7];
					flag_ece <= data[6];
					flag_urg <= data[5];
					flag_ack <= data[4];
					flag_psh <= data[3];
					flag_rst <= data[2];
					flag_syn <= data[1];
					flag_fin <= data[0];
				end else begin // Se o protocolo anterior tem tamanho par
					port_src <= pair_header_down;
					port_dst <= data[63:48];
					seq_num <= data[47:16];
					
					temp <= data[15:0];
				end
			endaction

			action
				if (pair_odd) 
					begin // Se o protocolo anterior tem tamanho ímpar
						window_size <= data[63:48];
						checksum <= data[47:32];
						urgent_pointer <= data[31:16];

						odd_header_up <= data[15:0];
					end 
				else 
					begin // Se o protocolo anterior tem tamanho par
						ack_num <= {temp, data[63:48]};
						data_offset <= data[47:44];
						reserved <= data[43:41];
						flag_ns <= data[40];
						flag_cwr <= data[39];
						flag_ece <= data[38];
						flag_urg <= data[37];
						flag_ack <= data[36];
						flag_psh <= data[35];
						flag_rst <= data[34];
						flag_syn <= data[33];
						flag_fin <= data[32];
						window_size <= data[31:16];
						checksum <= data[15:0];
					end
			endaction
	

			action
				if (!pair_odd)
					begin
						urgent_pointer <= data[63:48];
						pair_header_up <= data[47:0];
					end
			endaction
	
			// Continua recebendo os dados
			while (active)
				noAction;				

			// Finaliza o recebimento
			noAction;


		endseq
	
	endseq);

	mkAutoFSM(stmt_rcv);


//***************************************//
//               METHODS 				 //
//***************************************//
	// Recebe sinal para desmembrar o cabeçalho Ethernet
	method Action activate(Bool v);
		active <= v;
	endmethod	

	// Recebe dados para desmembrar o cabeçalho Ethernet
	method Action parser(Data d);
		data <= d;
	endmethod

// Identifica a ordem de recebimento dos dados
	method Action pairOrodd (Bool signal); //False é par, True é ímpar
		pair_odd <= signal;
	endmethod

	method Action headerPair(Bit#(16) pair); 
		pair_header_down <= pair;
	endmethod					

	method Action headerOdd(Bit#(48) odd); 
		odd_header_down <= odd;
	endmethod					

	method PortAddr portSrc;
		return port_src;
	endmethod

	method PortAddr portDst;
		return port_dst;
	endmethod

endmodule
endpackage