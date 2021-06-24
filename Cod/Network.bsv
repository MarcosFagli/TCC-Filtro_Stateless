package Network;


//***************************************//
//               IMPORTS 				 //
//***************************************//
import FIFOF::*;
import StmtFSM::*;
import TypeDef::*;
import ReverseBytes::*;
import SupportNetwork::*;

// Protocolos
import Ethernet::*;
import IP::*;
import TCP::*;

import Filter::*;


//***************************************//
//               INTERFACES				 //
//***************************************//	
interface Network;
	method Action mac_rx_data(Data data);
	method Action mac_rx_keep(Byte keep);
	method Action mac_rx_valid(Bit#(1) valid);
	method Action mac_rx_user(Bit#(1) user);
	method Action mac_rx_last(Bit#(1) last);

	method Data mac_tx_data;
	method Bit#(1) mac_tx_last;
	method Bit#(1) mac_tx_user;
	method Bit#(1) mac_tx_valid;
	method Byte mac_tx_keep;
	method Action mac_tx_ready(Bit#(1) ready);
endinterface


//***************************************//
//               MODULE 				 //
//***************************************//	
(* synthesize, always_ready, always_enabled *)
module mkNetwork(Network);

	// Instâncias
	Ethernet eth <- mkEthernet();
	IP ip <- mkIP();
	TCP tcp <- mkTCP();
	Filter filter <- mkFilter();

	// Dados recebidos da interface A
	Reg#(Data) rx_data  <- mkReg(?);
	Reg#(Byte) rx_keep  <- mkReg(8'hFF); 
	Reg#(Bit#(1)) rx_valid <- mkReg(1'b0);
	Reg#(Bit#(1)) rx_user  <- mkReg(1'b0);
	Reg#(Bit#(1)) rx_last  <- mkReg(1'b0);

	Reg#(Bit#(1)) tx_ready  <- mkReg(1'b1);

	// Dados enviados para a interface B
	Reg#(Data) tx_data  <- mkReg(?);
	Reg#(Byte) tx_keep  <- mkReg(8'hFF); 
	Reg#(Bit#(1)) tx_valid <- mkReg(1'b0);
	Reg#(Bit#(1)) tx_user  <- mkReg(1'b0);
	Reg#(Bit#(1)) tx_last  <- mkReg(1'b0);


	Reg#(Data) data  <- mkReg(?);
	Reg#(Byte) keep  <- mkReg(8'hFF); 
	Reg#(Bit#(1)) valid <- mkReg(1'b0);
	//Reg#(Bit#(1)) user  <- mkReg(1'b0);
	Reg#(Bit#(1)) last  <- mkReg(1'b0);

	// Sinalização de início e fim do recebimento
	// e de erro
	Reg#(Bool) start <- mkReg(False);
	Reg#(Bool) finish <- mkReg(True);
	Reg#(Bool) error <- mkReg(False);
	Reg#(Bool) check <- mkReg(False);


	Reg#(Bit#(32)) i <- mkReg(?);

	Reg#(Bit#(16)) eth_topheader <- mkReg(?);
	Reg#(Bit#(16)) ippair_topheader <- mkReg(?);
	Reg#(Bit#(48)) ipodd_topheader <- mkReg(?);

	Reg#(Bit#(16)) ip4_checksum <- mkReg(?);

	Reg#(Bit#(16)) tcp_checksum <- mkReg(?);
	Reg#(Bit#(16)) pseudo_header <- mkReg(?);
	

//***************************************//
//                RULES					 //
//***************************************//
	// Recebe os dados
	rule rcv (rx_valid == 1'b1);
		data <= reverseBYTES(rx_data);
		keep <= rx_keep;
		valid <= rx_valid;
		last <= rx_last;
	endrule

	// Armazena pacotes para filtragem e validação
	rule fifoInput (rx_valid == 1'b1);
		filter.fifoToFilter({rx_last, rx_keep, rx_data});
	endrule

	// Regra marca que pacote está sendo recebido.
	rule pkgStart (rx_valid == 1'b1 && rx_last == 1'b0);
		start <= True;
		finish <= False;
	endrule

	// Regra marca o fim do recebimento.
	rule pkgLast (!finish && rx_last == 1'b1);
		start <= False;
		finish <= True;

		check <= True;
	endrule

	// Envia pacotes TCP para a filtragem e validação
	rule fifoCheck (finish && check);
		check <= False;

		// IPv4 validando o checksum
		if (eth.ethType == 16'h0800 && ip.nextProtocol == 8'h06 && 
			ip.version == 4'd4 && ip4_checksum == 16'hFFFF) 
			filter.fifoToCheck({4'd4, 1'b0, 1'b1, 
				192'h000000000000000000000000000000000000000000000000, 
				ip.ip4Dst, ip.ip4Src, tcp.portDst, tcp.portSrc});

		// IPv6
		else if (eth.ethType == 16'h86DD && ip.nextProtocol == 8'h06 
			&& ip.version == 4'd6)
			filter.fifoToCheck({4'd6, 1'b0, 1'b1, ip.ip6Dst, ip.ip6Src, 
				tcp.portDst, tcp.portSrc});

		// Erro (Problema no recebimento - discarta
		else if (error || keep == 8'h00 || valid == 1'b0)
			filter.fifoToCheck({4'd0, 1'b1, 1'b0, 
				288'h000000000000000000000000000000000000000000000000000000000000000000000000});

		// Não filtra
		else
			filter.fifoToCheck({4'd0, 1'b0, 1'b0, 
				288'h000000000000000000000000000000000000000000000000000000000000000000000000});

	endrule

	// Regra para validar se o pacote foi recebido sem erro
	rule pkgCheck;
		if (start && (keep != 8'hFF || valid == 1'b0))
			error <= True;

		else error <= False;
	endrule


//***************************************//
//       FSM - Parser dos pacotes        //
//***************************************//
	Stmt parser = (seq

		while(True) seq


//****************************************//
//           Protocolo Ethernet 	      //
//****************************************//		
			action
				await (start);

				eth.activate(True);
				eth.parser({data, reverseBYTES(rx_data[47:0])});
			endaction

			action
				eth.activate(False);
				eth_topheader <= data[15:0];
			endaction


//*****************************************//
//              Protocolos IP   	       //
//*****************************************//
			if ((eth.ethType == 16'h0800 && (eth_topheader[11:8] >= 5 && 
						eth_topheader[11:8] <= 15)) || eth.ethType == 16'h86DD) 
				seq
					
					action
						ip.activate(True);
						ip.parser(data);
						ip.versionIHL(eth_topheader);
		
						ip4_checksum <= checksumIPCalc({eth_topheader, data[63:0]});

						// Calcula o tamanho do cabeçalho IP em 
						// bytes subtraindo essa iteração
						if (eth_topheader[15:12] == 4'd4) 
							i <= ( extend(eth_topheader[11:8]) * 4 ) - 8;
						else 
							i <= 40 - 8;

					endaction

					while (i > 0)
						action
							ip.parser(data);
															
							if (i <= 8) 
								begin
									ip.activate(False);
									i <= 0;

									if (eth_topheader[11:8] %2 == 0)
										begin
											ip4_checksum <= checksumIPCalc({ip4_checksum, 
												data[63:16], 16'h0000});
		
											ippair_topheader <= data[15:0];
										end
									else
										begin
											ip4_checksum <= checksumIPCalc({ip4_checksum, 
												data[63:48], 48'h000000000000});
		
											ipodd_topheader <= data[47:0];
										end
								end
							else
								begin
									ip4_checksum <= checksumIPCalc({ip4_checksum, data[63:0]});
									i <= i - 8;
								end
						endaction


					//************************************************//				
					//                  Protocolo TCP                 //
					//************************************************//				
					if (ip.nextProtocol == 8'h06 && ((ip.version == 4'd4 && 
						ip4_checksum == 16'hFFFF) || ip.version == 4'd6))
						seq		
	
							if (last == 1'b0)
								action
									tcp.activate(True);
									tcp.parser(data);

									// Inicia o cálculo do checksum levando em consideração 
									// a parte do cabeçalho TCP recebido junto com segmento IP
									if (eth_topheader[11:8] %2 == 0)
										begin
											tcp.pairOrodd(False);
											tcp.headerPair(ippair_topheader);
											
											tcp_checksum <= checksumTCPCalc({48'h000000000000, 
												ippair_topheader, data});
										end
									else
										begin
											tcp.pairOrodd(True);
											tcp.headerOdd(ipodd_topheader);
											
											tcp_checksum <= checksumTCPCalc({16'h0000, ipodd_topheader, data});
										end
								endaction


							action
								tcp.parser(data);

								tcp_checksum <= checksumTCPCalc({tcp_checksum, 
										48'h000000000000, data});

								// Pseudo Header
								if (ip.version == 4'd4)
									pseudo_header <= pseudoHeaderIPv4({ip.ip4Src, ip.ip4Dst, 
										8'h00, ip.nextProtocol, ip.length});
								else 
									pseudo_header <= pseudoHeaderIPv6({ip.ip6Src, ip.ip6Dst, 
										16'h0000, ip.length, 24'h000000, ip.nextProtocol});
							endaction


							while (last == 1'b0)
								action		
									tcp.parser(data);

									tcp_checksum <= checksumTCPCalc({tcp_checksum, 
										48'h000000000000, data});
								endaction


							if (last == 1'b1)
								action
									tcp.activate(False);
									tcp.parser(data);

									tcp_checksum <= checksumTCPCalc({tcp_checksum, 
										32'h00000000, pseudo_header, data});
								endaction

						endseq


					//************************************************//				
					// Protocolos dentro do protocolo IP não tratados //
					//************************************************//
					// Se tiver protocolos de extensão do IPv6, por exemplo
					// Vai precisar tratar para ver se posteriormente tem TCP?			
					else 
						seq
				
							while (last != 1'b1)
								noAction;

							noAction;

						endseq				

				endseq	


//*****************************************//
//          Protocolos não tratados 	   //
//*****************************************//
			else
				seq
				
					while (last != 1'b1)
						noAction;

					noAction;

				endseq		

		endseq

	endseq);

	mkAutoFSM(parser);


//***************************************//
// FSM - envia os dados para a interface //
//***************************************//
	Stmt send = (seq

		
		while (True) seq

			// Mantém TX com a mesma informação
			//noAction;

			// Se a interface pode receber dados
			if (tx_ready == 1'b1)
				//**************************************//
				// 	   		   Envia um dado        	//
				//**************************************//
				action
					// Aguarda a fila de saída não ser vazia
					await (filter.validSend);

					// Requisita o dado da fila de saída
					let data <- filter.getToSend;

					//Envia os dados para a interface
					tx_data <= data[63:0];
					tx_keep <= data[71:64];
					tx_last <= data[72];
					tx_valid <= 1'b1;
					tx_user <= 1'b0;

				endaction
			
			// Mantém TX com a mesma informação
			else
				noAction;

		endseq

	endseq);

	mkAutoFSM(send);

//***************************************//
//               METHODS 				 //
//***************************************//
// Lê o RX da interface A
	method Action mac_rx_data(Data d);
		rx_data <= d;
	endmethod

	method Action mac_rx_keep(Byte k);
		rx_keep <= k;
	endmethod

	method Action mac_rx_valid(Bit#(1) v);
		rx_valid <= v;
	endmethod

	method Action mac_rx_user(Bit#(1) u);
		rx_user <= u;
	endmethod

	method Action mac_rx_last(Bit#(1) l);
 		rx_last <= l;
	endmethod

// Seta o TX da interface B
	method Data mac_tx_data;
   		return tx_data;
	endmethod

	method Bit#(1) mac_tx_last;
   		return tx_last;
	endmethod

	method Bit#(1) mac_tx_user;
   		return tx_user; 
	endmethod

	method Bit#(1) mac_tx_valid;
   		return tx_valid;
	endmethod

	method Byte mac_tx_keep;
   		return tx_keep;
	endmethod

	// 0 - Mantém o envio do dado anterior e 1 - Envia o próximo
	method Action mac_tx_ready(Bit#(1) ready);
		tx_ready <= ready;
	endmethod

endmodule

endpackage