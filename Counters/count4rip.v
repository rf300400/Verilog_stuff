module count4rip(clk , q);
input clk;
output[3:0] q;
wire[3:0] qb ;
tff t0(1'b1,q[0],qb[0],clk,1'b1,1'b1);
tff t1(1'b1,q[1],qb[1],q[0],1'b1,1'b1);
tff t2(1'b1,q[2],qb[2],q[1],1'b1,1'b1);
tff t3(1'b1,q[3],qb[3],q[2],1'b1,1'b1);
endmodule

module tff(t,q,qb,clk,pre,clr);
input t , clk , clr , pre;
output q , qb;
wire t , clk , clr , pre ;
reg q , qb;
always @(posedge clk) begin
    case(t)
    1'b1: q = 1'b0;
    1'b0: q = 1'b1;
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
assign qb = ~q;
endmodule