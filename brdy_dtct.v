module brdy_dtct (
    input           sys_clk,
    input           sys_rst_n,
    input [3:0]     brdy_in,

    output reg      isBrdy
);

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        isBrdy <= 1'b0;
    else if (brdy_in == 4'h7)
        isBrdy <= 1'b1;
    else
        isBrdy <= 1'b0;  
end 

endmodule