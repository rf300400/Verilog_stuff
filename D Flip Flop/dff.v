module dff(d,q,qb,clk,pre,clr);
input d , clk , clr , pre;
output q , qb;
wire d , clk , clr , pre ;
reg q , qb;
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
assign qb = ~q;
endmodule