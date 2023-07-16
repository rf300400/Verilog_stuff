module ALU(tin,pin,uacc,inmode,outmode,cmode,clk,bus,flgs);
input[3:0] tin , pin;
input[1:0] cmode;
input clk , uacc , inmode , outmode;
output[3:0] bus;
output[2:0] flgs;
wire[2:0] flgregin;
wire[3:0] aluout , aluin , tout;
acc a0(aluout, pin , inmode , outmode , bus , aluin , clk , uacc);
treg t0(tin,tout,clk);
calc c0(tin,aluin,cmode,aluout,flgregin);
flgregs f0(flgregin,flgs,clk,uacc);
endmodule

module flgregs(in,out,clk,uflg);
input[3:0] in;
input clk , uflg;
output[3:0] out;
wire clkreal = clk & uflg;
dff d0(in[0],out[0],clkreal);
dff d1(in[1],out[1],clkreal);
dff d2(in[2],out[2],clkreal);
dff d3(in[3],out[3],clkreal);
endmodule

module calc(tin,accin,mode,accout,fout);
input[3:0] tin , accin;
input[1:0] mode ;
output[3:0] accout;
output[2:0] fout;
wire[3:0] oad , oand , oor , oxor ,omux;
wire carbit ;
carry4bitrip c0(accin,tin,oad,carbit);
and4 an0(accin,tin,oand);
or4 oro0(accin,tin,oor);
xor4 xo0(accin,tin,oxor);
mux4 m0(oad,oand,oor,oxor,mode,omux);
assign accout = omux;
flagsetter f0(omux,fout,carbit);
endmodule

module flagsetter(in,out,carbit);
input[3:0] in;
input carbit;
output[2:0] out;//Zero,Parity,Carry
assign out[0] = ~((in[0] & 1'b1) | (in[1] & 1'b1) | (in[2] & 1'b1) | (in[3] & 1'b1));
assign out[1] = in[0] ^ in[1] ^ in[2] ^ in[3];
assign out[2] = carbit;
endmodule

module carry4bitrip(n1 , n2 , outy , carbit);
input[3:0] n1;
input[3:0] n2;
output[3:0] outy;
output carbit;
wire car0 , car1 , car2 , car3 , car4;
assign car0 = 1'b0 ;
fullad fd0(n1[0],n2[0],car0,car1,outy[0]);
fullad fd1(n1[1],n2[1],car1,car2,outy[1]);
fullad fd2(n1[2],n2[2],car2,car3,outy[2]);
fullad fd3(n1[3],n2[3],car3,car4,outy[3]);
assign carbit = car4 ;
endmodule

module halfad(n1 , n2 , car , sumy);
input n1 , n2 ;
output car , sumy ;
assign car = n1 & n2 ;
assign sumy = n1 ^ n2 ;
endmodule

module fullad(n1 , n2 , carin , carout , sumy);
input n1 , n2 , carin ;
output carout , sumy ;
wire nsum , ncar1 , ncar2;
halfad h1(n1,n2,ncar1,nsum);
halfad h2(carin,nsum,ncar2,sumy);
assign carout = ncar1 | ncar2 ;
endmodule

module and4(n1 , n2 , outy);
input[3:0] n1;
input[3:0] n2;
output[3:0] outy;
and(outy[0],n1[0],n2[0]);
and(outy[1],n1[1],n2[1]);
and(outy[2],n1[2],n2[2]);
and(outy[3],n1[3],n2[3]);
endmodule

module or4(n1 , n2 , outy);
input[3:0] n1;
input[3:0] n2;
output[3:0] outy;
or(outy[0],n1[0],n2[0]);
or(outy[1],n1[1],n2[1]);
or(outy[2],n1[2],n2[2]);
or(outy[3],n1[3],n2[3]);
endmodule

module xor4(n1 , n2 , outy);
input[3:0] n1;
input[3:0] n2;
output[3:0] outy;
xor(outy[0],n1[0],n2[0]);
xor(outy[1],n1[1],n2[1]);
xor(outy[2],n1[2],n2[2]);
xor(outy[3],n1[3],n2[3]);
endmodule

module treg(in,out,clk);
input[3:0] in ;
input clk ;
output[3:0] out;
dff d0(in[0],out[0],clk);
dff d1(in[1],out[1],clk);
dff d2(in[2],out[2],clk);
dff d3(in[3],out[3],clk);
endmodule

module acc(alu , memreg , inmode , outmode , bus , aluin , clk , uacc);
input[3:0] alu , memreg ;
input clk , uacc , inmode , outmode ;
output[3:0] bus , aluin;
wire uclk ;
assign uclk = clk & uacc;
wire[3:0] accin , accout ;
mux2 m0(alu,memreg,inmode,accin);
regacc r0(accin,accout,uclk);
demux2 dm0(accout,outmode,bus,aluin);
endmodule

module regacc(in , out , clk);
input[3:0] in ;
input clk;
output[3:0] out;
dff d0(in[0],out[0],clk);
dff d1(in[1],out[1],clk);
dff d2(in[2],out[2],clk);
dff d3(in[3],out[3],clk);
endmodule

module mux2(in1,in2,s,out);
input[3:0] in1, in2 ;
input s ;
output[3:0] out ;
assign out[0] = (in1[0] & (~s)) | (in2[0] & s);
assign out[1] = (in1[1] & (~s)) | (in2[1] & s);
assign out[2] = (in1[2] & (~s)) | (in2[2] & s);
assign out[3] = (in1[3] & (~s)) | (in2[3] & s);
endmodule

module mux4(in1,in2,in3,in4,s,out);
input[3:0] in1, in2 , in3 , in4;
input[1:0] s ;
output[3:0] out ;
assign out[0] = (in1[0] & (~s[0]) & (~s[1])) | (in2[0] & (s[0]) & (~s[1])) | (in3[0] & (~s[0]) & (s[1])) | (in4[0] & (s[0]) & (s[1]));
assign out[1] = (in1[1] & (~s[0]) & (~s[1])) | (in2[1] & (s[0]) & (~s[1])) | (in3[1] & (~s[0]) & (s[1])) | (in4[1] & (s[0]) & (s[1]));
assign out[2] = (in1[2] & (~s[0]) & (~s[1])) | (in2[2] & (s[0]) & (~s[1])) | (in3[2] & (~s[0]) & (s[1])) | (in4[2] & (s[0]) & (s[1]));
assign out[3] = (in1[3] & (~s[0]) & (~s[1])) | (in2[3] & (s[0]) & (~s[1])) | (in3[3] & (~s[0]) & (s[1])) | (in4[3] & (s[0]) & (s[1]));
endmodule

module demux2(in,s,o1,o2);
input[3:0] in;
input s ;
output[3:0] o1 , o2  ;
assign o1[0] = in[0] & (~s);
assign o1[1] = in[1] & (~s);
assign o1[2] = in[2] & (~s);
assign o1[3] = in[3] & (~s);
assign o2[0] = in[0] & s;
assign o2[1] = in[1] & s;
assign o2[2] = in[2] & s;
assign o2[3] = in[3] & s;
endmodule

module dff(d,q,clk);
input d , clk ;
output q ;
reg q ;
initial begin
    q = 1'b0;
end
always @(posedge clk) begin
    case(d)
    1'b0: q = 1'b0;
    1'b1: q = 1'b1;
    default: q = 1'b0;
    endcase
end
endmodule