module carry4bitrip_TB();
reg[3:0] n1;
reg[3:0] n2;
wire[3:0] outy ;
carry4bitrip c1(n1,n2,outy);
initial begin
    n1 = 4'b0000;
    n2 = 4'b0000;
    #5
    n1 = 4'b0010;
    n2 = 4'b0011;
    #5
    n1 = 4'b1010;
    n2 = 4'b0111;
    #5
    n1 = 4'b0111;
    n2 = 4'b1010;
    #5
    n1 = 4'b1111;
    n2 = 4'b1111;
    #5
    n1 = 4'b1001;
    n2 = 4'b1001;
    #5
    n1 = 4'b0110;
    n2 = 4'b0110;
end
always begin
    #35
    $finish;
end
endmodule