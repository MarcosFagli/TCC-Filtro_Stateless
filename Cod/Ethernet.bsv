package Ethernet;


//***************************************//
//               IMPORTS 				 //
//***************************************//	
import TypeDef::*;


//***************************************//
//               INTERFACES				 //
//***************************************//	
interface Ethernet;
//	method Action parser(Bit#(128) d);
	method Action parser(Bit#(112) d);
	method Action activate(Bool v);

	method MacAddr macDst;
	method MacAddr macSrc;
	method Bit#(16) ethType;

//	method Bit#(16) topHeader;
endinterface


//***************************************//
//               MODULE 				 //
//***************************************//	
(* synthesize *)
module mkEthernet(Ethernet);
//***************************************//
//               DECLARATIONS			 //
//***************************************//
	// Dado
	//Reg#(Bit#(128)) data <- mkReg(?);
	Reg#(Bit#(112)) data <- mkReg(?);
		
	// Cabeçalho Ethernet
	Reg#(Bit#(48)) mac_src <- mkReg(48'h000000000000);
	Reg#(Bit#(48)) mac_dst <- mkReg(48'h000000000000);
	Reg#(Bit#(16)) eth_type <- mkReg(16'h0000);
//	Reg#(Bit#(16)) top_header <- mkReg(16'h0000);	
//	Reg#(Bit#(16)) temp <- mkReg(16'h0000);

	// Sinalização
	Reg#(Bool) active <- mkReg(False);


//***************************************//
//                RULES					 //
//***************************************//
	rule ethHeader (active);
		mac_dst <= data[111:64];
		mac_src <= data[63:16];
		eth_type <= data[15:0];

//		mac_dst <= data[127:80];
//		mac_src <= data[79:32];
//		eth_type <= data[31:16];
//		top_header <= data[15:0];
	endrule


//***************************************//
//               METHODS 				 //
//***************************************//
	// Recebe sinal para desmembrar o cabeçalho Ethernet
	method Action activate(Bool v);
		active <= v;
	endmethod	

	// Recebe dados para desmembrar o cabeçalho Ethernet
//	method Action parser(Bit#(128) d);
	method Action parser(Bit#(112) d);
		data <= d;
	endmethod

	// Devolve os valores dos campos do cabeçalho Ethernet
	method MacAddr macDst;
		return mac_dst;
	endmethod

	method MacAddr macSrc;
		return mac_src;
	endmethod

	method Bit#(16) ethType;
		return eth_type;
	endmethod

	// Devolve os dados pertencetes ao cabeçalho superior (IP, ARP, etc)
/*
	method Bit#(16) topHeader;
		return top_header;
	endmethod
*/
endmodule

endpackage