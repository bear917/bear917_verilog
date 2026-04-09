module bounce_sequence (
    input           sys_clk,
    input           sys_rst_n,

    output          CA,
    output          CB,
    output          CC,
    output          CD,
    output          CE,
    output          CF,
    output          CG,
    output          DP,

    output  [7:0]   AN,

    output          isBrdy_check,
    output          toggle_check
);

wire [3:0]  cnt_out;
wire        isBrdy_wire;
wire        toggle_wire;
wire        div_1s_wire;

assign isBrdy_check =  isBrdy_wire;
assign toggle_check = toggle_wire;

cntr_4bit cntr_4bit_0 (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .isUP(toggle_wire),   // count down
    .div_1s(div_1s_wire),
    .out(cnt_out)
);

brdy_dtct brdy_dtct_0 (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .brdy_in(cnt_out),
    .isBrdy(isBrdy_wire)
);

toggle_ckt toggle_ckt_0 (
    .clk_in(div_1s_wire),
    .sys_rst_n(sys_rst_n),
    .toggle_in(isBrdy_wire),
    .toggle_out(toggle_wire)
);

svn_dcdr svn_dcdr_0 (
    .in(cnt_out),      // display the count
    .dp_in(1'b0),   // turn off the decimal point
    .AN_in(8'hFE),   // turn one digits
    .CA(CA),
    .CB(CB),
    .CC(CC),
    .CD(CD),
    .CE(CE),
    .CF(CF),
    .CG(CG),
    .DP(DP),
    .AN(AN)
);

endmodule
