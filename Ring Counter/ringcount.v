module ringcount(clk,ori,q);
input clk , ori ;
output[2:0] q ;
/*reg[2:0] q;
wire[2:0] qf ;
initial begin
    q = {1'b0,1'b0,1'b0,1'b0};
    qf[2:0] = q[2:0];
end*/
dff d0(q[2],q[0],clk,ori,1'b1);
dff d1(q[0],q[1],clk,1'b1,ori);
dff d2(q[1],q[2],clk,1'b1,ori);
endmodule

module dff(d,q,clk,pre,clr);
input d , clk , clr , pre;
output q ;
wire d , clk , clr , pre ;
reg q ; 
always @(posedge clk) begin
    case(d)
    1'b1: q = 1'b1;
    1'b0: q = 1'b0;
    default: q = q ;
    endcase
    case({pre,clr})
    {1'b1,1'b1}: q = q;
    {1'b0,1'b1}: q = 1'b1;
    {1'b1,1'b0}: q = 1'b0;
    {1'b0,1'b0}: q = 1'bx;
    default: q = q ;
    endcase
end
endmodule