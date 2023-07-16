module dff_TB();
reg d , clk , clr , pre;
wire q , qb;
dff d1(d,q,qb,clk,pre,clr);
initial begin
    clk = 1'b0;
    clr = 1'b1;
    pre = 1'b1;
    d = 1'b0;
end
always begin
    #5
    clk = ~clk;
end
always begin
    #10
    d = ~d;
end
always begin
    #60
    pre = ~pre;
end
always begin
    #120
    clr = ~clr;
end
always begin
    #240
    $finish;
end
endmodule