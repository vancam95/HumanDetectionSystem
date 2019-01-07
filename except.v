`timescale 1ns / 100ps


module except(	clk, opa, opb, inf, ind, qnan, snan, opa_nan, opb_nan,
		opa_00, opb_00, opa_inf, opb_inf, opa_dn, opb_dn);
input		clk;
input	[31:0]	opa, opb;
output		inf, ind, qnan, snan, opa_nan, opb_nan;
output		opa_00, opb_00;
output		opa_inf, opb_inf;
output		opa_dn;
output		opb_dn;

////////////////////////////////////////////////////////////////////////
//
// Local Wires and registers
//

wire	[7:0]	expa, expb;		// alias to opX exponent
wire	[22:0]	fracta, fractb;		// alias to opX fraction
reg		expa_ff, infa_f_r, qnan_r_a, snan_r_a;
reg		expb_ff, infb_f_r, qnan_r_b, snan_r_b;
reg		inf, ind, qnan, snan;	// Output registers
reg		opa_nan, opb_nan;
reg		expa_00, expb_00, fracta_00, fractb_00;
reg		opa_00, opb_00;
reg		opa_inf, opb_inf;
reg		opa_dn, opb_dn;

////////////////////////////////////////////////////////////////////////
//
// Aliases
//

assign   expa = opa[30:23];
assign   expb = opb[30:23];
assign fracta = opa[22:0];
assign fractb = opb[22:0];

////////////////////////////////////////////////////////////////////////
//
// Determine if any of the input operators is a INF or NAN or any other special number
//

always @(posedge clk)
	expa_ff <= #1 &expa;

always @(posedge clk)
	expb_ff <= #1 &expb;
	
always @(posedge clk)
	infa_f_r <= #1 !(|fracta);

always @(posedge clk)
	infb_f_r <= #1 !(|fractb);

always @(posedge clk)
	qnan_r_a <= #1  fracta[22];

always @(posedge clk)
	snan_r_a <= #1 !fracta[22] & |fracta[21:0];
	
always @(posedge clk)
	qnan_r_b <= #1  fractb[22];

always @(posedge clk)
	snan_r_b <= #1 !fractb[22] & |fractb[21:0];

always @(posedge clk)
	ind  <= #1 (expa_ff & infa_f_r) & (expb_ff & infb_f_r);

always @(posedge clk)
	inf  <= #1 (expa_ff & infa_f_r) | (expb_ff & infb_f_r);

always @(posedge clk)
	qnan <= #1 (expa_ff & qnan_r_a) | (expb_ff & qnan_r_b);

always @(posedge clk)
	snan <= #1 (expa_ff & snan_r_a) | (expb_ff & snan_r_b);

always @(posedge clk)
	opa_nan <= #1 &expa & (|fracta[22:0]);

always @(posedge clk)
	opb_nan <= #1 &expb & (|fractb[22:0]);

always @(posedge clk)
	opa_inf <= #1 (expa_ff & infa_f_r);

always @(posedge clk)
	opb_inf <= #1 (expb_ff & infb_f_r);

always @(posedge clk)
	expa_00 <= #1 !(|expa);

always @(posedge clk)
	expb_00 <= #1 !(|expb);

always @(posedge clk)
	fracta_00 <= #1 !(|fracta);

always @(posedge clk)
	fractb_00 <= #1 !(|fractb);

always @(posedge clk)
	opa_00 <= #1 expa_00 & fracta_00;

always @(posedge clk)
	opb_00 <= #1 expb_00 & fractb_00;

always @(posedge clk)
	opa_dn <= #1 expa_00;

always @(posedge clk)
	opb_dn <= #1 expb_00;

endmodule