package TypeDef;

//***************************************//
//                TYPES 				 //
//***************************************//
typedef Bit#(64) Data;
typedef Bit#(32) IP4Addr;
typedef Bit#(128) IP6Addr;
typedef Bit#(8) Byte;
typedef Bit#(48) MacAddr;
typedef Bit#(16) PortAddr;


//***************************************//
//               INTERFACES				 //
//***************************************//	
/*
interface TypeDef;
	method Action setIPv4(IP4Addr ip);
	method Action setIPv6(IP6Addr ip6);
	method Action setMacAddr(MacAddr mac);
	method IP4Addr getIPv4;
	method IP6Addr getIPv6;
	method MacAddr getMacAddr;
endinterface
*/
//***************************************//
//               MODULE 				 //
//***************************************//	
/*
(* synthesize *)
module mkTypeDef(TypeDef);
	
	Reg#(MacAddr) my_mac_addr <- mkReg(?);
	Reg#(IP4Addr) my_ipv4 <-  mkReg(?);
	Reg#(IP6Addr) my_ipv6 <-  mkReg(?);

	method Action setIPv4(IP4Addr ip);
		my_ipv4 <= ip;
	endmethod

	method Action setIPv6(IP6Addr ip6);
		my_ipv6 <= ip6;
	endmethod
	
	method Action setMacAddr(MacAddr mac);
		my_mac_addr <= mac;
	endmethod

	method IP4Addr getIPv4;
		return my_ipv4;
	endmethod

	method IP6Addr getIPv6;
		return my_ipv6;
	endmethod

	method MacAddr getMacAddr;
		return my_mac_addr;
	endmethod
endmodule
*/
endpackage