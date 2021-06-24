package Check;

import TypeDef::*;


//***************************************//
//               FUNCTIONS 				 //
//***************************************//	
// Valida os Filtros passados em IPv4
	function Bool checkIPv4(IP4Addr ip4_dst, 
		IP4Addr ip4_src, PortAddr port_dst, 
			PortAddr port_src);
		// Subnet		
		if (((ip4_dst & 'hffffff00) == 'hc0a83300) ||
			((ip4_src & 'hffffff00) == 'hc0a83300))
			return True;
		// Port Range
		else if((port_dst >= 6000 && port_dst <= 6010) ||
			(port_src >= 6000 && port_src <= 6010))
			return True;
		// IP de origem
		else if(ip4_src == 32'hc0a80f04)
			return True;
		// IP de destino
		else if(ip4_dst == 32'hc0a83303)
			return True;
		// IP e porta de origem
		else if(ip4_src == 32'hc0a83303 && port_src == 6000)
			return True;
		// IP e porta de destino
		else if(ip4_dst == 32'hc0a83303 && port_dst == 6010)
			return True;
		// Nenhum filtro ativado
		else return False;

	endfunction


// Valida os Filtros passados em IPv6
	function Bool checkIPv6(IP6Addr ip6_dst, 
		IP6Addr ip6_src, PortAddr port_dst, 
			PortAddr port_src);
		// Prefix (No teste está /64)
		if (((ip6_dst & 'hffffffffffffffff0000000000000000) == 
			'h0a000000000000000000000000000000) ||
			((ip6_src & 'hffffffffffffffff0000000000000000) == 
			'h0a000000000000000000000000000000))
			return True;
		// Port Range
		else if((port_dst >= 0001 && port_dst <= 0010) ||
		(port_src >= 0000 && port_src <= 0010))
			return True;
		// IP de origem
		else if(ip6_src == 128'h0000000000CB06405F15500082C00E00)
			return True;
		// IP de destino
		else if(ip6_dst == 128'h0000000000CB06405F15500082C00E00)
			return True;
		// IP e porta de origem
		else if(ip6_src == 128'h0000000000CB06405F15500082C00E00 && port_src == 0000)
			return True;
		// IP e porta de destino
		else if(ip6_dst == 128'h0000000000CB06405F15500082C00E00 && port_dst == 0000)
			return True;
		// Nenhum filtro ativado
		else return False;

	endfunction

endpackage