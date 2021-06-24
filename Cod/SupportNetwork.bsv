package SupportNetwork;

//***************************************//
//               FUNCTIONS 				 //
//***************************************//	
	
	// Calcula o complemento de 1
	function Bit#(16) checkSum(Bit#(32) d);
		Bit#(16) checksum = 16'h0000;
		Bit#(17) temp_checksum = extend(d[15:0]) + extend(d[31:16]);
				
		if (temp_checksum[16] == 1'b1)
			checksum = temp_checksum[15:0] + 16'h0001;
		else
			checksum = temp_checksum[15:0];

		return checksum; //truncate(temp_check);
	endfunction


	// Calcula o checksum do protocolo IP
	function Bit#(16) checksumIPCalc(Bit#(80) c);
		let result0 = checkSum(c[79:48]);
		let result1 = checkSum({result0 , c[47:32]});
		let result2 = checkSum({result1 , c[31:16]});
		let result = checkSum({result2 , c[15:0]});

		return result;
	endfunction


	// Calcula o checksum do protocolo TCP
	function Bit#(16) checksumTCPCalc(Bit#(128) odd);	
		let result0 = checkSum(odd[127:96]);
		let result1 = checkSum({result0, odd[95:80]});
		let result2 = checkSum({result1, odd[79:64]});
		let result3 = checkSum({result2, odd[63:48]});
		let result4 = checkSum({result3, odd[47:32]});
		let result5 = checkSum({result4, odd[31:16]});
		let result = checkSum({result5, odd[15:0]});

		return result;
	endfunction

	// Cálculo do Pseudo-Header IPv4 para verificar o checksum 
	function Bit#(16) pseudoHeaderIPv4(Bit#(96) p4);
		let result0 = checkSum(p4[95:64]);
		let result1 = checkSum({result0, p4[63:48]});
		let result2 = checkSum({result1, p4[47:32]});
		let result3 = checkSum({result2, p4[31:16]});
		let result = checkSum({result3, p4[15:0]});		
					
		return result;
	endfunction
		

	// Cálculo do Pseudo-Header IPv6 para verificar o checksum 
	function Bit#(16) pseudoHeaderIPv6(Bit#(320) p6);
		let result0 = checkSum(p6[319:288]);
		let result1 = checkSum({result0, p6[287:272]});
		let result2 = checkSum({result1, p6[271:256]});
		let result3 = checkSum({result2, p6[255:240]});
		let result4 = checkSum({result3, p6[239:224]});
		let result5 = checkSum({result4, p6[223:208]});
		let result6 = checkSum({result5, p6[207:192]});
		let result7 = checkSum({result6, p6[191:176]});
		let result8 = checkSum({result7, p6[175:160]});
		let result9 = checkSum({result8, p6[159:144]});
		let result10 = checkSum({result9, p6[143:128]});
		let result11 = checkSum({result10, p6[127:112]});
		let result12 = checkSum({result11, p6[111:96]});
		let result13 = checkSum({result12, p6[95:80]});
		let result14 = checkSum({result13, p6[79:64]});
		let result15 = checkSum({result14, p6[63:48]});
		let result16 = checkSum({result15, p6[47:32]});
		let result17 = checkSum({result16, p6[31:16]});
		let result = checkSum({result17, p6[15:0]});

		return result;
	endfunction


endpackage