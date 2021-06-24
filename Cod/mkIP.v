//
// Generated by Bluespec Compiler (build 2c1ed34)
//
// On Wed Jun  9 13:32:46 -03 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_activate                   O     1 const
// RDY_parser                     O     1 const
// RDY_versionIHL                 O     1 const
// version                        O     4 reg
// RDY_version                    O     1 const
// length                         O    16
// RDY_length                     O     1 const
// nextProtocol                   O     8
// RDY_nextProtocol               O     1 const
// ip4Src                         O    32 reg
// RDY_ip4Src                     O     1 const
// ip4Dst                         O    32 reg
// RDY_ip4Dst                     O     1 const
// validChecksum                  O     1
// RDY_validChecksum              O     1 const
// ip6Src                         O   128 reg
// RDY_ip6Src                     O     1 const
// ip6Dst                         O   128 reg
// RDY_ip6Dst                     O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// activate_v                     I     1 reg
// parser_d                       I    64 reg
// versionIHL_v                   I    16
// EN_activate                    I     1
// EN_parser                      I     1
// EN_versionIHL                  I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkIP(CLK,
	    RST_N,

	    activate_v,
	    EN_activate,
	    RDY_activate,

	    parser_d,
	    EN_parser,
	    RDY_parser,

	    versionIHL_v,
	    EN_versionIHL,
	    RDY_versionIHL,

	    version,
	    RDY_version,

	    length,
	    RDY_length,

	    nextProtocol,
	    RDY_nextProtocol,

	    ip4Src,
	    RDY_ip4Src,

	    ip4Dst,
	    RDY_ip4Dst,

	    validChecksum,
	    RDY_validChecksum,

	    ip6Src,
	    RDY_ip6Src,

	    ip6Dst,
	    RDY_ip6Dst);
  input  CLK;
  input  RST_N;

  // action method activate
  input  activate_v;
  input  EN_activate;
  output RDY_activate;

  // action method parser
  input  [63 : 0] parser_d;
  input  EN_parser;
  output RDY_parser;

  // action method versionIHL
  input  [15 : 0] versionIHL_v;
  input  EN_versionIHL;
  output RDY_versionIHL;

  // value method version
  output [3 : 0] version;
  output RDY_version;

  // value method length
  output [15 : 0] length;
  output RDY_length;

  // value method nextProtocol
  output [7 : 0] nextProtocol;
  output RDY_nextProtocol;

  // value method ip4Src
  output [31 : 0] ip4Src;
  output RDY_ip4Src;

  // value method ip4Dst
  output [31 : 0] ip4Dst;
  output RDY_ip4Dst;

  // value method validChecksum
  output validChecksum;
  output RDY_validChecksum;

  // value method ip6Src
  output [127 : 0] ip6Src;
  output RDY_ip6Src;

  // value method ip6Dst
  output [127 : 0] ip6Dst;
  output RDY_ip6Dst;

  // signals for module outputs
  wire [127 : 0] ip6Dst, ip6Src;
  wire [31 : 0] ip4Dst, ip4Src;
  wire [15 : 0] length;
  wire [7 : 0] nextProtocol;
  wire [3 : 0] version;
  wire RDY_activate,
       RDY_ip4Dst,
       RDY_ip4Src,
       RDY_ip6Dst,
       RDY_ip6Src,
       RDY_length,
       RDY_nextProtocol,
       RDY_parser,
       RDY_validChecksum,
       RDY_version,
       RDY_versionIHL,
       validChecksum;

  // inlined wires
  wire start_wire$whas, state_set_pw$whas;

  // register active
  reg active;
  wire active$D_IN, active$EN;

  // register checksum
  reg [15 : 0] checksum;
  wire [15 : 0] checksum$D_IN;
  wire checksum$EN;

  // register checksum_calc
  reg [15 : 0] checksum_calc;
  wire [15 : 0] checksum_calc$D_IN;
  wire checksum_calc$EN;

  // register checksum_temp
  reg [15 : 0] checksum_temp;
  wire [15 : 0] checksum_temp$D_IN;
  wire checksum_temp$EN;

  // register data
  reg [63 : 0] data;
  wire [63 : 0] data$D_IN;
  wire data$EN;

  // register dscp
  reg [5 : 0] dscp;
  wire [5 : 0] dscp$D_IN;
  wire dscp$EN;

  // register ecn
  reg [1 : 0] ecn;
  wire [1 : 0] ecn$D_IN;
  wire ecn$EN;

  // register flag_df
  reg flag_df;
  wire flag_df$D_IN, flag_df$EN;

  // register flag_mf
  reg flag_mf;
  wire flag_mf$D_IN, flag_mf$EN;

  // register flag_reserved
  reg flag_reserved;
  wire flag_reserved$D_IN, flag_reserved$EN;

  // register flow_label
  reg [19 : 0] flow_label;
  wire [19 : 0] flow_label$D_IN;
  wire flow_label$EN;

  // register fragment_offset
  reg [12 : 0] fragment_offset;
  wire [12 : 0] fragment_offset$D_IN;
  wire fragment_offset$EN;

  // register hop_limit
  reg [7 : 0] hop_limit;
  wire [7 : 0] hop_limit$D_IN;
  wire hop_limit$EN;

  // register i
  reg [3 : 0] i;
  reg [3 : 0] i$D_IN;
  wire i$EN;

  // register identification
  reg [15 : 0] identification;
  wire [15 : 0] identification$D_IN;
  wire identification$EN;

  // register ihl
  reg [3 : 0] ihl;
  wire [3 : 0] ihl$D_IN;
  wire ihl$EN;

  // register ip4_dst
  reg [31 : 0] ip4_dst;
  wire [31 : 0] ip4_dst$D_IN;
  wire ip4_dst$EN;

  // register ip4_src
  reg [31 : 0] ip4_src;
  wire [31 : 0] ip4_src$D_IN;
  wire ip4_src$EN;

  // register ip6_dst
  reg [127 : 0] ip6_dst;
  wire [127 : 0] ip6_dst$D_IN;
  wire ip6_dst$EN;

  // register ip6_src
  reg [127 : 0] ip6_src;
  wire [127 : 0] ip6_src$D_IN;
  wire ip6_src$EN;

  // register ip6_temp
  reg [79 : 0] ip6_temp;
  wire [79 : 0] ip6_temp$D_IN;
  wire ip6_temp$EN;

  // register next_header
  reg [7 : 0] next_header;
  wire [7 : 0] next_header$D_IN;
  wire next_header$EN;

  // register partial_flow_label
  reg [3 : 0] partial_flow_label;
  wire [3 : 0] partial_flow_label$D_IN;
  wire partial_flow_label$EN;

  // register payload_length
  reg [15 : 0] payload_length;
  wire [15 : 0] payload_length$D_IN;
  wire payload_length$EN;

  // register proto
  reg [7 : 0] proto;
  wire [7 : 0] proto$D_IN;
  wire proto$EN;

  // register running
  reg running;
  wire running$D_IN, running$EN;

  // register start_reg
  reg start_reg;
  wire start_reg$D_IN, start_reg$EN;

  // register start_reg_1
  reg start_reg_1;
  wire start_reg_1$D_IN, start_reg_1$EN;

  // register state_can_overlap
  reg state_can_overlap;
  wire state_can_overlap$D_IN, state_can_overlap$EN;

  // register state_fired
  reg state_fired;
  wire state_fired$D_IN, state_fired$EN;

  // register state_mkFSMstate
  reg [3 : 0] state_mkFSMstate;
  reg [3 : 0] state_mkFSMstate$D_IN;
  wire state_mkFSMstate$EN;

  // register temp
  reg [15 : 0] temp;
  wire [15 : 0] temp$D_IN;
  wire temp$EN;

  // register total_length
  reg [15 : 0] total_length;
  wire [15 : 0] total_length$D_IN;
  wire total_length$EN;

  // register traffic_class
  reg [7 : 0] traffic_class;
  wire [7 : 0] traffic_class$D_IN;
  wire traffic_class$EN;

  // register ttl
  reg [7 : 0] ttl;
  wire [7 : 0] ttl$D_IN;
  wire ttl$EN;

  // register ver
  reg [3 : 0] ver;
  wire [3 : 0] ver$D_IN;
  wire ver$EN;

  // rule scheduling signals
  wire WILL_FIRE_RL_action_l100c41,
       WILL_FIRE_RL_action_l127c51,
       WILL_FIRE_RL_action_l138c41,
       WILL_FIRE_RL_fsm_start;

  // inputs to muxes for submodule ports
  wire [3 : 0] MUX_i$write_1__VAL_1, MUX_i$write_1__VAL_2;
  wire MUX_start_reg$write_1__SEL_2;

  // remaining internal signals
  wire [3 : 0] x__h32373;
  wire abort_whas_AND_abort_wget_OR_state_mkFSMstate__ETC___d103,
       start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56;

  // action method activate
  assign RDY_activate = 1'd1 ;

  // action method parser
  assign RDY_parser = 1'd1 ;

  // action method versionIHL
  assign RDY_versionIHL = 1'd1 ;

  // value method version
  assign version = ver ;
  assign RDY_version = 1'd1 ;

  // value method length
  assign length =
	     (ver == 4'd4) ?
	       total_length - { 12'd0, x__h32373 } :
	       payload_length ;
  assign RDY_length = 1'd1 ;

  // value method nextProtocol
  assign nextProtocol = (ver == 4'd4) ? proto : next_header ;
  assign RDY_nextProtocol = 1'd1 ;

  // value method ip4Src
  assign ip4Src = ip4_src ;
  assign RDY_ip4Src = 1'd1 ;

  // value method ip4Dst
  assign ip4Dst = ip4_dst ;
  assign RDY_ip4Dst = 1'd1 ;

  // value method validChecksum
  assign validChecksum = checksum == checksum_calc ;
  assign RDY_validChecksum = 1'd1 ;

  // value method ip6Src
  assign ip6Src = ip6_src ;
  assign RDY_ip6Src = 1'd1 ;

  // value method ip6Dst
  assign ip6Dst = ip6_dst ;
  assign RDY_ip6Dst = 1'd1 ;

  // rule RL_action_l100c41
  assign WILL_FIRE_RL_action_l100c41 =
	     active && ver == 4'd4 && state_mkFSMstate == 4'd1 ;

  // rule RL_action_l127c51
  assign WILL_FIRE_RL_action_l127c51 =
	     i != 4'd0 &&
	     (state_mkFSMstate == 4'd4 || state_mkFSMstate == 4'd5) ;

  // rule RL_action_l138c41
  assign WILL_FIRE_RL_action_l138c41 =
	     active && ver == 4'd6 && state_mkFSMstate == 4'd1 ;

  // rule RL_fsm_start
  assign WILL_FIRE_RL_fsm_start =
	     abort_whas_AND_abort_wget_OR_state_mkFSMstate__ETC___d103 &&
	     start_reg ;

  // inputs to muxes for submodule ports
  assign MUX_start_reg$write_1__SEL_2 =
	     abort_whas_AND_abort_wget_OR_state_mkFSMstate__ETC___d103 &&
	     !start_reg &&
	     !running ;
  assign MUX_i$write_1__VAL_1 = i - 4'd1 ;
  assign MUX_i$write_1__VAL_2 = ihl - 4'd5 ;

  // inlined wires
  assign start_wire$whas =
	     WILL_FIRE_RL_fsm_start || start_reg_1 && !state_fired ;
  assign state_set_pw$whas =
	     state_mkFSMstate == 4'd9 || state_mkFSMstate == 4'd8 ||
	     state_mkFSMstate == 4'd7 ||
	     state_mkFSMstate == 4'd6 ||
	     WILL_FIRE_RL_action_l138c41 ||
	     WILL_FIRE_RL_action_l127c51 ||
	     state_mkFSMstate == 4'd3 ||
	     state_mkFSMstate == 4'd2 ||
	     WILL_FIRE_RL_action_l100c41 ||
	     start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56 ;

  // register active
  assign active$D_IN = activate_v ;
  assign active$EN = EN_activate ;

  // register checksum
  assign checksum$D_IN = data[63:48] ;
  assign checksum$EN = state_mkFSMstate == 4'd2 ;

  // register checksum_calc
  assign checksum_calc$D_IN = 16'h0 ;
  assign checksum_calc$EN = 1'b0 ;

  // register checksum_temp
  assign checksum_temp$D_IN = 16'h0 ;
  assign checksum_temp$EN = 1'b0 ;

  // register data
  assign data$D_IN = parser_d ;
  assign data$EN = EN_parser ;

  // register dscp
  assign dscp$D_IN = versionIHL_v[7:2] ;
  assign dscp$EN = EN_versionIHL && versionIHL_v[15:12] == 4'd4 ;

  // register ecn
  assign ecn$D_IN = versionIHL_v[1:0] ;
  assign ecn$EN = EN_versionIHL && versionIHL_v[15:12] == 4'd4 ;

  // register flag_df
  assign flag_df$D_IN = data[30] ;
  assign flag_df$EN = WILL_FIRE_RL_action_l100c41 ;

  // register flag_mf
  assign flag_mf$D_IN = data[29] ;
  assign flag_mf$EN = WILL_FIRE_RL_action_l100c41 ;

  // register flag_reserved
  assign flag_reserved$D_IN = data[31] ;
  assign flag_reserved$EN = WILL_FIRE_RL_action_l100c41 ;

  // register flow_label
  assign flow_label$D_IN = { partial_flow_label, data[63:48] } ;
  assign flow_label$EN = WILL_FIRE_RL_action_l138c41 ;

  // register fragment_offset
  assign fragment_offset$D_IN = data[28:16] ;
  assign fragment_offset$EN = WILL_FIRE_RL_action_l100c41 ;

  // register hop_limit
  assign hop_limit$D_IN = data[23:16] ;
  assign hop_limit$EN = WILL_FIRE_RL_action_l138c41 ;

  // register i
  always@(WILL_FIRE_RL_action_l127c51 or
	  MUX_i$write_1__VAL_1 or
	  state_mkFSMstate or
	  MUX_i$write_1__VAL_2 or
	  start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_action_l127c51: i$D_IN = MUX_i$write_1__VAL_1;
      state_mkFSMstate == 4'd2: i$D_IN = MUX_i$write_1__VAL_2;
      start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56: i$D_IN = 4'd0;
      default: i$D_IN = 4'b1010 /* unspecified value */ ;
    endcase
  end
  assign i$EN =
	     WILL_FIRE_RL_action_l127c51 || state_mkFSMstate == 4'd2 ||
	     start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56 ;

  // register identification
  assign identification$D_IN = data[47:32] ;
  assign identification$EN = WILL_FIRE_RL_action_l100c41 ;

  // register ihl
  assign ihl$D_IN = versionIHL_v[11:8] ;
  assign ihl$EN = EN_versionIHL && versionIHL_v[15:12] == 4'd4 ;

  // register ip4_dst
  assign ip4_dst$D_IN = { temp, data[63:48] } ;
  assign ip4_dst$EN = state_mkFSMstate == 4'd3 ;

  // register ip4_src
  assign ip4_src$D_IN = data[47:16] ;
  assign ip4_src$EN = state_mkFSMstate == 4'd2 ;

  // register ip6_dst
  assign ip6_dst$D_IN = { ip6_temp, data[63:16] } ;
  assign ip6_dst$EN = state_mkFSMstate == 4'd9 ;

  // register ip6_src
  assign ip6_src$D_IN = { ip6_temp, data[63:16] } ;
  assign ip6_src$EN = state_mkFSMstate == 4'd7 ;

  // register ip6_temp
  assign ip6_temp$D_IN = { temp, data } ;
  assign ip6_temp$EN = state_mkFSMstate == 4'd8 || state_mkFSMstate == 4'd6 ;

  // register next_header
  assign next_header$D_IN = data[31:24] ;
  assign next_header$EN = WILL_FIRE_RL_action_l138c41 ;

  // register partial_flow_label
  assign partial_flow_label$D_IN = versionIHL_v[3:0] ;
  assign partial_flow_label$EN =
	     EN_versionIHL && versionIHL_v[15:12] == 4'd6 ;

  // register payload_length
  assign payload_length$D_IN = data[47:32] ;
  assign payload_length$EN = WILL_FIRE_RL_action_l138c41 ;

  // register proto
  assign proto$D_IN = data[7:0] ;
  assign proto$EN = WILL_FIRE_RL_action_l100c41 ;

  // register running
  assign running$D_IN = 1'd1 ;
  assign running$EN = MUX_start_reg$write_1__SEL_2 ;

  // register start_reg
  assign start_reg$D_IN = !WILL_FIRE_RL_fsm_start ;
  assign start_reg$EN =
	     WILL_FIRE_RL_fsm_start ||
	     abort_whas_AND_abort_wget_OR_state_mkFSMstate__ETC___d103 &&
	     !start_reg &&
	     !running ;

  // register start_reg_1
  assign start_reg_1$D_IN = start_wire$whas ;
  assign start_reg_1$EN = 1'd1 ;

  // register state_can_overlap
  assign state_can_overlap$D_IN = state_set_pw$whas || state_can_overlap ;
  assign state_can_overlap$EN = 1'd1 ;

  // register state_fired
  assign state_fired$D_IN = state_set_pw$whas ;
  assign state_fired$EN = 1'd1 ;

  // register state_mkFSMstate
  always@(start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56 or
	  WILL_FIRE_RL_action_l100c41 or
	  state_mkFSMstate or
	  WILL_FIRE_RL_action_l127c51 or WILL_FIRE_RL_action_l138c41)
  begin
    case (1'b1) // synopsys parallel_case
      start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56:
	  state_mkFSMstate$D_IN = 4'd1;
      WILL_FIRE_RL_action_l100c41: state_mkFSMstate$D_IN = 4'd2;
      state_mkFSMstate == 4'd2: state_mkFSMstate$D_IN = 4'd3;
      state_mkFSMstate == 4'd3: state_mkFSMstate$D_IN = 4'd4;
      WILL_FIRE_RL_action_l127c51: state_mkFSMstate$D_IN = 4'd5;
      WILL_FIRE_RL_action_l138c41: state_mkFSMstate$D_IN = 4'd6;
      state_mkFSMstate == 4'd6: state_mkFSMstate$D_IN = 4'd7;
      state_mkFSMstate == 4'd7: state_mkFSMstate$D_IN = 4'd8;
      state_mkFSMstate == 4'd8: state_mkFSMstate$D_IN = 4'd9;
      state_mkFSMstate == 4'd9: state_mkFSMstate$D_IN = 4'd10;
      default: state_mkFSMstate$D_IN = 4'b1010 /* unspecified value */ ;
    endcase
  end
  assign state_mkFSMstate$EN =
	     start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56 ||
	     WILL_FIRE_RL_action_l100c41 ||
	     state_mkFSMstate == 4'd2 ||
	     state_mkFSMstate == 4'd3 ||
	     WILL_FIRE_RL_action_l127c51 ||
	     WILL_FIRE_RL_action_l138c41 ||
	     state_mkFSMstate == 4'd6 ||
	     state_mkFSMstate == 4'd7 ||
	     state_mkFSMstate == 4'd8 ||
	     state_mkFSMstate == 4'd9 ;

  // register temp
  assign temp$D_IN = data[15:0] ;
  assign temp$EN =
	     state_mkFSMstate == 4'd7 || WILL_FIRE_RL_action_l138c41 ||
	     state_mkFSMstate == 4'd2 ;

  // register total_length
  assign total_length$D_IN = data[63:48] ;
  assign total_length$EN = WILL_FIRE_RL_action_l100c41 ;

  // register traffic_class
  assign traffic_class$D_IN = versionIHL_v[11:4] ;
  assign traffic_class$EN = EN_versionIHL && versionIHL_v[15:12] == 4'd6 ;

  // register ttl
  assign ttl$D_IN = data[15:8] ;
  assign ttl$EN = WILL_FIRE_RL_action_l100c41 ;

  // register ver
  assign ver$D_IN = versionIHL_v[15:12] ;
  assign ver$EN = EN_versionIHL ;

  // remaining internal signals
  assign abort_whas_AND_abort_wget_OR_state_mkFSMstate__ETC___d103 =
	     state_mkFSMstate == 4'd0 && (!start_reg_1 || state_fired) ;
  assign start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56 =
	     start_wire$whas && state_mkFSMstate == 4'd0 ||
	     ver != 4'd4 && ver != 4'd6 && state_mkFSMstate == 4'd1 ||
	     i == 4'd0 &&
	     (state_mkFSMstate == 4'd4 || state_mkFSMstate == 4'd5) ||
	     state_mkFSMstate == 4'd10 ;
  assign x__h32373 = { ihl[1:0], 2'd0 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        active <= `BSV_ASSIGNMENT_DELAY 1'd0;
	checksum <= `BSV_ASSIGNMENT_DELAY 16'h0;
	checksum_calc <= `BSV_ASSIGNMENT_DELAY 16'hFFFF;
	checksum_temp <= `BSV_ASSIGNMENT_DELAY 16'h0;
	data <= `BSV_ASSIGNMENT_DELAY 64'hAAAAAAAAAAAAAAAA;
	dscp <= `BSV_ASSIGNMENT_DELAY 6'b0;
	ecn <= `BSV_ASSIGNMENT_DELAY 2'b0;
	flag_df <= `BSV_ASSIGNMENT_DELAY 1'b0;
	flag_mf <= `BSV_ASSIGNMENT_DELAY 1'b0;
	flag_reserved <= `BSV_ASSIGNMENT_DELAY 1'b0;
	flow_label <= `BSV_ASSIGNMENT_DELAY 20'b0;
	fragment_offset <= `BSV_ASSIGNMENT_DELAY 13'b0;
	hop_limit <= `BSV_ASSIGNMENT_DELAY 8'h0;
	i <= `BSV_ASSIGNMENT_DELAY 4'h0;
	identification <= `BSV_ASSIGNMENT_DELAY 16'h0;
	ihl <= `BSV_ASSIGNMENT_DELAY 4'h0;
	ip4_dst <= `BSV_ASSIGNMENT_DELAY 32'h0;
	ip4_src <= `BSV_ASSIGNMENT_DELAY 32'h0;
	ip6_dst <= `BSV_ASSIGNMENT_DELAY 128'h0;
	ip6_src <= `BSV_ASSIGNMENT_DELAY 128'h0;
	ip6_temp <= `BSV_ASSIGNMENT_DELAY 80'h0;
	next_header <= `BSV_ASSIGNMENT_DELAY 8'h0;
	partial_flow_label <= `BSV_ASSIGNMENT_DELAY 4'h0;
	payload_length <= `BSV_ASSIGNMENT_DELAY 16'h0;
	proto <= `BSV_ASSIGNMENT_DELAY 8'h0;
	running <= `BSV_ASSIGNMENT_DELAY 1'd0;
	start_reg <= `BSV_ASSIGNMENT_DELAY 1'd0;
	start_reg_1 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	state_can_overlap <= `BSV_ASSIGNMENT_DELAY 1'd1;
	state_fired <= `BSV_ASSIGNMENT_DELAY 1'd0;
	state_mkFSMstate <= `BSV_ASSIGNMENT_DELAY 4'd0;
	temp <= `BSV_ASSIGNMENT_DELAY 16'h0;
	total_length <= `BSV_ASSIGNMENT_DELAY 16'h0;
	traffic_class <= `BSV_ASSIGNMENT_DELAY 8'h0;
	ttl <= `BSV_ASSIGNMENT_DELAY 8'h0;
	ver <= `BSV_ASSIGNMENT_DELAY 4'h0;
      end
    else
      begin
        if (active$EN) active <= `BSV_ASSIGNMENT_DELAY active$D_IN;
	if (checksum$EN) checksum <= `BSV_ASSIGNMENT_DELAY checksum$D_IN;
	if (checksum_calc$EN)
	  checksum_calc <= `BSV_ASSIGNMENT_DELAY checksum_calc$D_IN;
	if (checksum_temp$EN)
	  checksum_temp <= `BSV_ASSIGNMENT_DELAY checksum_temp$D_IN;
	if (data$EN) data <= `BSV_ASSIGNMENT_DELAY data$D_IN;
	if (dscp$EN) dscp <= `BSV_ASSIGNMENT_DELAY dscp$D_IN;
	if (ecn$EN) ecn <= `BSV_ASSIGNMENT_DELAY ecn$D_IN;
	if (flag_df$EN) flag_df <= `BSV_ASSIGNMENT_DELAY flag_df$D_IN;
	if (flag_mf$EN) flag_mf <= `BSV_ASSIGNMENT_DELAY flag_mf$D_IN;
	if (flag_reserved$EN)
	  flag_reserved <= `BSV_ASSIGNMENT_DELAY flag_reserved$D_IN;
	if (flow_label$EN)
	  flow_label <= `BSV_ASSIGNMENT_DELAY flow_label$D_IN;
	if (fragment_offset$EN)
	  fragment_offset <= `BSV_ASSIGNMENT_DELAY fragment_offset$D_IN;
	if (hop_limit$EN) hop_limit <= `BSV_ASSIGNMENT_DELAY hop_limit$D_IN;
	if (i$EN) i <= `BSV_ASSIGNMENT_DELAY i$D_IN;
	if (identification$EN)
	  identification <= `BSV_ASSIGNMENT_DELAY identification$D_IN;
	if (ihl$EN) ihl <= `BSV_ASSIGNMENT_DELAY ihl$D_IN;
	if (ip4_dst$EN) ip4_dst <= `BSV_ASSIGNMENT_DELAY ip4_dst$D_IN;
	if (ip4_src$EN) ip4_src <= `BSV_ASSIGNMENT_DELAY ip4_src$D_IN;
	if (ip6_dst$EN) ip6_dst <= `BSV_ASSIGNMENT_DELAY ip6_dst$D_IN;
	if (ip6_src$EN) ip6_src <= `BSV_ASSIGNMENT_DELAY ip6_src$D_IN;
	if (ip6_temp$EN) ip6_temp <= `BSV_ASSIGNMENT_DELAY ip6_temp$D_IN;
	if (next_header$EN)
	  next_header <= `BSV_ASSIGNMENT_DELAY next_header$D_IN;
	if (partial_flow_label$EN)
	  partial_flow_label <= `BSV_ASSIGNMENT_DELAY partial_flow_label$D_IN;
	if (payload_length$EN)
	  payload_length <= `BSV_ASSIGNMENT_DELAY payload_length$D_IN;
	if (proto$EN) proto <= `BSV_ASSIGNMENT_DELAY proto$D_IN;
	if (running$EN) running <= `BSV_ASSIGNMENT_DELAY running$D_IN;
	if (start_reg$EN) start_reg <= `BSV_ASSIGNMENT_DELAY start_reg$D_IN;
	if (start_reg_1$EN)
	  start_reg_1 <= `BSV_ASSIGNMENT_DELAY start_reg_1$D_IN;
	if (state_can_overlap$EN)
	  state_can_overlap <= `BSV_ASSIGNMENT_DELAY state_can_overlap$D_IN;
	if (state_fired$EN)
	  state_fired <= `BSV_ASSIGNMENT_DELAY state_fired$D_IN;
	if (state_mkFSMstate$EN)
	  state_mkFSMstate <= `BSV_ASSIGNMENT_DELAY state_mkFSMstate$D_IN;
	if (temp$EN) temp <= `BSV_ASSIGNMENT_DELAY temp$D_IN;
	if (total_length$EN)
	  total_length <= `BSV_ASSIGNMENT_DELAY total_length$D_IN;
	if (traffic_class$EN)
	  traffic_class <= `BSV_ASSIGNMENT_DELAY traffic_class$D_IN;
	if (ttl$EN) ttl <= `BSV_ASSIGNMENT_DELAY ttl$D_IN;
	if (ver$EN) ver <= `BSV_ASSIGNMENT_DELAY ver$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    active = 1'h0;
    checksum = 16'hAAAA;
    checksum_calc = 16'hAAAA;
    checksum_temp = 16'hAAAA;
    data = 64'hAAAAAAAAAAAAAAAA;
    dscp = 6'h2A;
    ecn = 2'h2;
    flag_df = 1'h0;
    flag_mf = 1'h0;
    flag_reserved = 1'h0;
    flow_label = 20'hAAAAA;
    fragment_offset = 13'h0AAA;
    hop_limit = 8'hAA;
    i = 4'hA;
    identification = 16'hAAAA;
    ihl = 4'hA;
    ip4_dst = 32'hAAAAAAAA;
    ip4_src = 32'hAAAAAAAA;
    ip6_dst = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    ip6_src = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    ip6_temp = 80'hAAAAAAAAAAAAAAAAAAAA;
    next_header = 8'hAA;
    partial_flow_label = 4'hA;
    payload_length = 16'hAAAA;
    proto = 8'hAA;
    running = 1'h0;
    start_reg = 1'h0;
    start_reg_1 = 1'h0;
    state_can_overlap = 1'h0;
    state_fired = 1'h0;
    state_mkFSMstate = 4'hA;
    temp = 16'hAAAA;
    total_length = 16'hAAAA;
    traffic_class = 8'hAA;
    ttl = 8'hAA;
    ver = 4'hA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_action_l100c41 &&
	  (state_mkFSMstate == 4'd2 || state_mkFSMstate == 4'd3 ||
	   WILL_FIRE_RL_action_l127c51 ||
	   WILL_FIRE_RL_action_l138c41 ||
	   state_mkFSMstate == 4'd6 ||
	   state_mkFSMstate == 4'd7 ||
	   state_mkFSMstate == 4'd8 ||
	   state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 100, column 41: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l100c41] and\n  [RL_action_l115c41, RL_action_l123c49, RL_action_l127c51, RL_action_l138c41,\n  RL_action_l149c41, RL_action_l153c41, RL_action_l158c50, RL_action_l160c49]\n  ) fired in the same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (state_mkFSMstate == 4'd2 &&
	  (state_mkFSMstate == 4'd3 || WILL_FIRE_RL_action_l127c51 ||
	   WILL_FIRE_RL_action_l138c41 ||
	   state_mkFSMstate == 4'd6 ||
	   state_mkFSMstate == 4'd7 ||
	   state_mkFSMstate == 4'd8 ||
	   state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 115, column 41: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l115c41] and\n  [RL_action_l123c49, RL_action_l127c51, RL_action_l138c41, RL_action_l149c41,\n  RL_action_l153c41, RL_action_l158c50, RL_action_l160c49] ) fired in the same\n  clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (state_mkFSMstate == 4'd3 &&
	  (WILL_FIRE_RL_action_l127c51 || WILL_FIRE_RL_action_l138c41 ||
	   state_mkFSMstate == 4'd6 ||
	   state_mkFSMstate == 4'd7 ||
	   state_mkFSMstate == 4'd8 ||
	   state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 123, column 49: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l123c49] and\n  [RL_action_l127c51, RL_action_l138c41, RL_action_l149c41, RL_action_l153c41,\n  RL_action_l158c50, RL_action_l160c49] ) fired in the same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_action_l127c51 &&
	  (WILL_FIRE_RL_action_l138c41 || state_mkFSMstate == 4'd6 ||
	   state_mkFSMstate == 4'd7 ||
	   state_mkFSMstate == 4'd8 ||
	   state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 127, column 51: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l127c51] and\n  [RL_action_l138c41, RL_action_l149c41, RL_action_l153c41, RL_action_l158c50,\n  RL_action_l160c49] ) fired in the same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_action_l138c41 &&
	  (state_mkFSMstate == 4'd6 || state_mkFSMstate == 4'd7 ||
	   state_mkFSMstate == 4'd8 ||
	   state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 138, column 41: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l138c41] and\n  [RL_action_l149c41, RL_action_l153c41, RL_action_l158c50, RL_action_l160c49]\n  ) fired in the same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (state_mkFSMstate == 4'd6 &&
	  (state_mkFSMstate == 4'd7 || state_mkFSMstate == 4'd8 ||
	   state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 149, column 41: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l149c41] and\n  [RL_action_l153c41, RL_action_l158c50, RL_action_l160c49] ) fired in the\n  same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (state_mkFSMstate == 4'd7 &&
	  (state_mkFSMstate == 4'd8 || state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 153, column 41: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l153c41] and\n  [RL_action_l158c50, RL_action_l160c49] ) fired in the same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (state_mkFSMstate == 4'd8 && state_mkFSMstate == 4'd9)
	$display("Error: \"IP.bsv\", line 158, column 50: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l158c50] and\n  [RL_action_l160c49] ) fired in the same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (start_wire_whas_AND_start_wire_wget_0_AND_abor_ETC___d56 &&
	  (WILL_FIRE_RL_action_l100c41 || state_mkFSMstate == 4'd2 ||
	   state_mkFSMstate == 4'd3 ||
	   WILL_FIRE_RL_action_l127c51 ||
	   WILL_FIRE_RL_action_l138c41 ||
	   state_mkFSMstate == 4'd6 ||
	   state_mkFSMstate == 4'd7 ||
	   state_mkFSMstate == 4'd8 ||
	   state_mkFSMstate == 4'd9))
	$display("Error: \"IP.bsv\", line 93, column 27: (R0001)\n  Mutually exclusive rules (from the ME sets [RL_action_l93c27] and\n  [RL_action_l100c41, RL_action_l115c41, RL_action_l123c49, RL_action_l127c51,\n  RL_action_l138c41, RL_action_l149c41, RL_action_l153c41, RL_action_l158c50,\n  RL_action_l160c49] ) fired in the same clock cycle.\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (running &&
	  abort_whas_AND_abort_wget_OR_state_mkFSMstate__ETC___d103 &&
	  !start_reg)
	$finish(32'd0);
  end
  // synopsys translate_on
endmodule  // mkIP
