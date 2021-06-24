package IP;

//***************************************//
//               IMPORTS 				 //
//***************************************//	
import StmtFSM::*;
import TypeDef::*;

//***************************************//
//               INTERFACES				 //
//***************************************//	
interface IP;
	method Action activate(Bool v);
	method Action parser(Data d);

 	method Action versionIHL (Bit#(16) v);

	method Bit#(4) version;

	method Bit#(16) length;
	method Byte nextProtocol;
	method IP4Addr ip4Src;
	method IP4Addr ip4Dst;

	method Bool validChecksum;

	method IP6Addr ip6Src;
	method IP6Addr ip6Dst;

endinterface

//***************************************//
//               MODULE 				 //
//***************************************//	
(* synthesize *)
module mkIP(IP);
//***************************************//
//               DECLARATIONS			 //
//***************************************//
	// Dados
	Reg#(Bit#(64)) data <- mkReg(?);

	// Auxiliares
	Reg#(Bit#(4)) i <- mkReg(4'h0);
	Reg#(Bit#(16)) temp <- mkReg(16'h0000);

	// Cabeçalho Ipv4 e IPv6 
	Reg#(Bit#(4)) ver <- mkReg(4'h0);
	
	// Cabeçalho IPv4
	Reg#(Bit#(4)) ihl <- mkReg(4'h0);
	Reg#(Bit#(6)) dscp <- mkReg(6'b000000);
	Reg#(Bit#(2)) ecn <- mkReg(2'b00);
	Reg#(Bit#(16)) total_length <- mkReg(16'h0000);
	Reg#(Bit#(16)) identification <- mkReg(16'h0000);
	Reg#(Bit#(1)) flag_reserved <- mkReg(1'b0); 
	Reg#(Bit#(1)) flag_df <- mkReg(1'b0); // don't fragment
	Reg#(Bit#(1)) flag_mf <- mkReg(1'b0); // more fragment
	Reg#(Bit#(13)) fragment_offset <- mkReg(13'b0000000000000);
	Reg#(Byte) ttl <- mkReg(8'h00);
	Reg#(Byte) proto <- mkReg(8'h00);
	Reg#(Bit#(16)) checksum <- mkReg(16'h0000);
	Reg#(IP4Addr) ip4_src <- mkReg(32'h00000000);
	Reg#(IP4Addr) ip4_dst <- mkReg(32'h00000000);

	// Cabeçalho Iv6
	Reg#(Byte) traffic_class <- mkReg(8'h00);
	Reg#(Bit#(20)) flow_label <- mkReg(20'b00000000000000000000);
	Reg#(Bit#(16)) payload_length <- mkReg(16'h0000);
	Reg#(Byte) next_header <- mkReg(8'h00);
	Reg#(Byte) hop_limit <- mkReg(8'h00);
	Reg#(IP6Addr) ip6_src <- mkReg(128'h00000000000000000000000000000000);
	Reg#(IP6Addr) ip6_dst <- mkReg(128'h00000000000000000000000000000000);

	Reg#(Bit#(4)) partial_flow_label <- mkReg(4'h0);
	Reg#(Bit#(80)) ip6_temp <- mkReg(80'h00000000000000000000);

	// Utilizados para cálculo do checksum IPv4
	Reg#(Bit#(16)) checksum_calc <- mkReg(16'hFFFF);
	Reg#(Bit#(16)) checksum_temp <- mkReg(16'h0000);	

	// Sinalização
	Reg#(Bool) active <- mkReg(False);


//***************************************//
//          FSM - Cabeçalho IP    		 //
//***************************************//
	Stmt stmt_rcv = (seq

		while (True) seq

			i <= 0;
		
			//***************************************//
			//            Cabeçalho IPv4     		 //
			//***************************************//
			if (ver == 4'd4) 
				seq				
					action
						// Aguarda sinal para iniciar
						await (active);

						total_length <= data[63:48];
						identification <= data[47:32];
						flag_reserved <= data[31];
						flag_df <= data[30];
						flag_mf <= data[29];
						fragment_offset <= data[28:16];
						ttl <= data[15:8];
						proto <= data[7:0];
					endaction


					action
						checksum <= data[63:48];
						ip4_src <= data[47:16];
						temp <= data[15:0];	

						i <= ihl - 5;
					endaction
	
					ip4_dst <= {temp, data[63:48]}; 

					// Dados opcionais do cabeçalho IP
					while (i > 0)							
						i <= i - 1;
			
				endseq


			//***************************************//
			//            Cabeçalho IPv6     		 //
			//***************************************//
			else if (ver == 4'd6) 
				seq

					action
						// Aguarda sinal para iniciar
						await (active);

						flow_label <= {partial_flow_label, data[63:48]};
						payload_length <= data[47:32];
						next_header <= data[31:24];
						hop_limit <= data[23:16];
						temp <= data[15:0];
					endaction

					action
						ip6_temp <= {temp, data};
					endaction

					action
						ip6_src <= {ip6_temp, data[63:16]};
						temp <= data[15:0];
					endaction

					ip6_temp <= {temp, data};

					ip6_dst <= {ip6_temp, data[63:16]};

				endseq
			
		endseq

	endseq);

	mkAutoFSM(stmt_rcv);


//***************************************//
//               METHODS 				 //
//***************************************//
	// Recebe sinal para desmembrar o cabeçalho IP
	method Action activate(Bool v);
		active <= v;
	endmethod	

	// Recebe dados para desmembrar o cabeçalho IP
	method Action parser(Data d);
		data <= d;
	endmethod

// Seta os 16 bits recebidos no mesmo segmento do cabeçalho ethernet
	method Action versionIHL (Bit#(16) v);
			ver <= v[15:12];

		// IPv4 -> Version, IHL, DSCP e ECN
		if (v[15:12] == 4'd4) begin
			ihl <= v[11:8];
			dscp <= v[7:2];
			ecn <= v[1:0];
		
		// IPv6 -> Version, Traffic Class e parte do Flow Label
		end else if (v[15:12] == 4'd6) begin
			traffic_class <= v[11:4];
			partial_flow_label <= v[3:0];
		end
	endmethod

	// Devolve a versão do IP
	method Bit#(4) version;
		return ver;
	endmethod

	// Devolve o tamanho do pacote sem o cabeçalho IP
	method Bit#(16) length;
		if (ver == 4'd4)
			return total_length - (extend(ihl*4)); // Transforma o ihl em bytes
		else
			return payload_length;
	endmethod

	// Devolve os valores dos campos do cabeçalho IP
	method Byte nextProtocol;
		if (ver == 4'd4)
			return proto;
		else
			return next_header;
	endmethod

	// Devolve o valor de validação do checksum
	method Bool validChecksum;
		if (checksum == checksum_calc)
			return True;
		else 
			return False;
	endmethod

	method IP4Addr ip4Src;
		return ip4_src;
	endmethod

	method IP4Addr ip4Dst;
		return ip4_dst;
	endmethod
	
	// IPv6
	method IP6Addr ip6Src;
		return ip6_src;
	endmethod

	method IP6Addr ip6Dst;
		return ip6_dst;
	endmethod

endmodule
endpackage