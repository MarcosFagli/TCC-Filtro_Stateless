import ReverseBytes::*;
import TypeDef::*;
import Network::*;

(* synthesize, always_ready, always_enabled *)
module mkTbIfc(Empty);
	
	// Instâncias
	Network ifc <- mkNetwork();
	
	Reg#(int) cnt <- mkReg(71);

	Reg#(Data) rx_data  <- mkReg(?);
	Reg#(Byte) rx_keep  <- mkReg(8'hff); 
	Reg#(Bit#(1)) rx_valid <- mkReg(1'b0);
	Reg#(Bit#(1)) rx_user  <- mkReg(1'b0);
	Reg#(Bit#(1)) rx_last  <- mkReg(1'b0);	
/*
	Reg#(Data) tx_data  <- mkReg(?);
	Reg#(Byte) tx_keep  <- mkReg(8'hff); 
	Reg#(Bit#(1)) tx_valid <- mkReg(1'b0);
	Reg#(Bit#(1)) tx_user  <- mkReg(1'b0);
	Reg#(Bit#(1)) tx_last  <- mkReg(1'b0);
*/
	rule ifc_rcv;
		ifc.mac_rx_data(rx_data);
		ifc.mac_rx_keep(rx_keep);
		ifc.mac_rx_user(rx_user);
		ifc.mac_rx_last(rx_last);
		ifc.mac_rx_valid(rx_valid);	
	endrule

	rule start (cnt >= 71 && cnt <= 72);
		if (cnt < 72)
			cnt <= cnt + 1;
		else
			cnt <= 0;

		if (cnt == 71) begin
			rx_data <= reverseBYTES(64'h0000000000000000);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end

		if (cnt == 72) begin
			rx_data <= reverseBYTES(64'h0000000000000000);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end
	endrule


	rule pck1 (cnt < 12);

		cnt <= cnt + 1;	
	
		if (cnt == 0) begin
			rx_data <= reverseBYTES(64'h1072230a318864c7);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end

		if (cnt == 1) begin
			rx_data <= reverseBYTES(64'h53da6cae08004500);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 2) begin
			rx_data <= reverseBYTES(64'h0040000040004006);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 3) begin
			rx_data <= reverseBYTES(64'h9e65c0a80f04c8a0);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;

		end
		else if (cnt == 4) begin
			rx_data <= reverseBYTES(64'h0406ef8501bb6cea);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 5) begin
			rx_data <= reverseBYTES(64'h48fe00000000b002);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 6) begin
			rx_data <= reverseBYTES(64'hffff2d5c00000204);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 7) begin
			rx_data <= reverseBYTES(64'h05b4010303060101);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 8) begin
			rx_data <= reverseBYTES(64'h080a6414620f0000);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 9) begin
			rx_data <= reverseBYTES(64'h0000040200000000);
			rx_keep <= 8'h3f;
			rx_user <= 1'b1;
			rx_last <= 1'b1;
			rx_valid <= 1'b1;
		end
		else if (cnt == 10) begin
			rx_data <= reverseBYTES(64'h0000000000000000);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end
		else if (cnt == 11) begin
			rx_data <= reverseBYTES(64'h0000000000000000);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end

	endrule

	rule pck2 (cnt >= 12 && cnt <= 22);
		//if (cnt < 21)
			cnt <= cnt + 1;
		//else
		//	cnt <= 0;

		if (cnt == 12) begin
			rx_data <= reverseBYTES(64'hffffffffffff001e);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 13) begin
			rx_data <= reverseBYTES(64'hc92708ff08060001);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 14) begin
			rx_data <= reverseBYTES(64'h080006040001001e);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 15) begin
			rx_data <= reverseBYTES(64'hc92708ffc0a83302);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 16) begin
			rx_data <= reverseBYTES(64'h000000000000c0a8);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 17) begin
			rx_data <= reverseBYTES(64'h3303000000000000);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 18) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 19) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'h0f;
			rx_user <= 1'b1;
			rx_last <= 1'b1;
			rx_valid <= 1'b1;
		end
		else if (cnt == 20) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end
		else if (cnt == 21) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end	
		else if (cnt == 22) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end	

	endrule

	rule pck3 (cnt >= 23 && cnt <= 58);
		//if (cnt < 57)
			cnt <= cnt + 1;
		//else
		//	cnt <= 0;

		if (cnt == 23) begin
			rx_data <= reverseBYTES(64'h00A0246FB6A300A0);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 24) begin
			rx_data <= reverseBYTES(64'h246FB70286DD6000);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 25) begin
			rx_data <= reverseBYTES(64'h000000CB06405F15);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 26) begin
			rx_data <= reverseBYTES(64'h500082C00E0000BD);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 27) begin
			rx_data <= reverseBYTES(64'h00A0246FB7025F15);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 28) begin
			rx_data <= reverseBYTES(64'h500082C00E0000BD);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 29) begin
			rx_data <= reverseBYTES(64'h00A0246FB6A3233F);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 30) begin
			rx_data <= reverseBYTES(64'h040663A9BC4A1E41);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 31) begin
			rx_data <= reverseBYTES(64'hB08080184380748A);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 32) begin
			rx_data <= reverseBYTES(64'h00000101080A000A);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 33) begin
			rx_data <= reverseBYTES(64'h96D9000014D54C61);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 34) begin
			rx_data <= reverseBYTES(64'h7374206C6F67696E);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 35) begin
			rx_data <= reverseBYTES(64'h3A20547565204A61);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 36) begin
			rx_data <= reverseBYTES(64'h6E2020372031373A);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 37) begin
			rx_data <= reverseBYTES(64'h30333A3436206672);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 38) begin
			rx_data <= reverseBYTES(64'h6F6D20616C696365);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 39) begin
			rx_data <= reverseBYTES(64'h2D76362E69707636);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 40) begin
			rx_data <= reverseBYTES(64'h0D0A5761726E696E);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 41) begin
			rx_data <= reverseBYTES(64'h673A206E6F204B65);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 42) begin
			rx_data <= reverseBYTES(64'h726265726F732074);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 43) begin
			rx_data <= reverseBYTES(64'h69636B6574732069);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 44) begin
			rx_data <= reverseBYTES(64'h73737565642E0D0A);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 45) begin
			rx_data <= reverseBYTES(64'h4F70656E42534420);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 46) begin
			rx_data <= reverseBYTES(64'h312E32202849504E);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 47) begin
			rx_data <= reverseBYTES(64'h474B455229202331);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 48) begin
			rx_data <= reverseBYTES(64'h3A20467269204E6F);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 49) begin
			rx_data <= reverseBYTES(64'h762031352030383A);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 50) begin
			rx_data <= reverseBYTES(64'h30333A3432205053);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 51) begin
			rx_data <= reverseBYTES(64'h5420313939360D0A);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 52) begin
			rx_data <= reverseBYTES(64'h0D0A57656C636F6D);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 53) begin
			rx_data <= reverseBYTES(64'h6520746F204F7065);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 54) begin
			rx_data <= reverseBYTES(64'h6E4253442E0D0A0D);
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b1;
		end
		else if (cnt == 55) begin
			rx_data <= reverseBYTES(64'h0AA35F44A9000000);
			rx_keep <= 8'h3f;
			rx_user <= 1'b1;
			rx_last <= 1'b1;
			rx_valid <= 1'b1;
		end
		else if (cnt == 56) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end
		else if (cnt == 57) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end	
		else if (cnt == 58) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end	
	endrule


	rule pck4 (cnt >= 59 && cnt <= 70);
		//if (cnt < 57)
			cnt <= cnt + 1;
		//else
		//	cnt <= 0;
		if (cnt == 59) begin 
			rx_data <= reverseBYTES(64'h64c753da6cae1072); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end		
		else if (cnt == 60) begin 
			rx_data <= reverseBYTES(64'h230a318808004500); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 61) begin 
			rx_data <= reverseBYTES(64'h003c000040003606); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 62) begin 
			rx_data <= reverseBYTES(64'ha869c8a00406c0a8); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 63) begin 
			rx_data <= reverseBYTES(64'h0f0401bbef857cd9); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 64) begin 
			rx_data <= reverseBYTES(64'h78f36cea48ffa012); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 65) begin 
			rx_data <= reverseBYTES(64'hfe885a4600000204); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 66) begin 
			rx_data <= reverseBYTES(64'h05ac0402080a1011); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 67) begin 
			rx_data <= reverseBYTES(64'hdfa96414620f0103); 
			rx_keep <= 8'hff; 
			rx_user <= 1'b0; 
			rx_last <= 1'b0; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 68) begin 
			rx_data <= reverseBYTES(64'h0307000000000000); 
			rx_keep <= 8'h03; 
			rx_user <= 1'b1; 
			rx_last <= 1'b1; 
			rx_valid <= 1'b1; 
		end
		else if (cnt == 69) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end
		else if (cnt == 70) begin
			rx_data <= 64'h0000000000000000;
			rx_keep <= 8'hff;
			rx_user <= 1'b0;
			rx_last <= 1'b0;
			rx_valid <= 1'b0;
		end	
	endrule

	rule set_ready;
		ifc.mac_tx_ready(1'b1);
	endrule

endmodule