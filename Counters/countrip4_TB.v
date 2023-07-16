module countrip4_TB();
reg clk;
wire[3:0] q ;
count4rip c1 (clk , q);
initial begin
    clk = 1'b0;
end
always begin
    #5
    clk = ~clk;
end
always begin
    #60
    $finish;
end
endmodule