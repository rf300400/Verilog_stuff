module ALU_TB();
reg[3:0] tin , pin;
reg[1:0] cmode;
reg clk , uacc , inmode , outmode;
wire[3:0] bus;
wire[2:0] flgs;
ALU a0(tin,pin,uacc,inmode,outmode,cmode,clk,bus,flgs);
initial begin
    tin = 4'b0000;//Temporary reg
    pin = 4'b0000;//Accumulator input from reg and mem
    inmode = 1'b1;//Mode 0 = ALU 1 = reg/mem
    outmode = 1'b0;//Mode 0 = Bus 1 = ALU
    cmode = 2'b00;//00 = add 01 = and 10 = or 11 = xor
    clk = 1'b0;
    uacc = 1'b0;//1 for 2 time units to update accumulator
    #2//2
    pin = 4'b0010;
    tin = 4'b0001;
    uacc = 1'b1;
    #2//4
    uacc = 1'b0;
    outmode = 1'b1;//ALU
    #2//6
    inmode = 1'b0;//ALU
    uacc = 1'b1;
    #1//7
    uacc = 1'b0;
    #2//9
    outmode = 1'b0;//Bus
    //1st Calc over==========================================================
    #2//11
    cmode = 2'b01;//And
    inmode = 1'b1;//Pin
    pin = 4'b1110;
    #2//13
    uacc = 1'b1;
    #1//14
    uacc = 1'b0;
    outmode = 1'b1;//ALU
    inmode = 1'b0;//ALU
    #2//16
    uacc = 1'b1;
    #1//17
    uacc = 1'b0;
    outmode = 1'b0;//Bus
    //2nd Calc over=============================================
    #2//19
    tin = 4'b1111;
    outmode = 1'b1;//ALU
    cmode = 2'b00;//Addition
    #2//21
    uacc = 1'b1;
    #3
    uacc = 1'b0;
    outmode = 1'b0;//Bus
end
always begin
    #1
    clk = ~clk;
end
always begin
    #50
    $finish;
end
endmodule