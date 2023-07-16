module ringcount_TB();
reg clk , ori ;
wire[2:0] q;
ringcount r1(clk,ori,q);
initial begin
    clk = 1'b0;
    ori = 1'b0;
    #10
    ori = 1'b1;
    #40
    ori = 1'b0;
    #50
    ori = 1'b1;
end
always begin
    #5
    clk = ~clk;
end
always begin
    #200
    $finish;
end
endmodule