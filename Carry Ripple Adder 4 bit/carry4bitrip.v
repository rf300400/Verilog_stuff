module carry4bitrip(n1 , n2 , outy);
input[3:0] n1;
input[3:0] n2;
output[3:0] outy;
wire car0 , car1 , car2 , car3 , car4;
assign car0 = 1'b0 ;
fullad fd0(n1[0],n2[0],car0,car1,outy[0]);
fullad fd1(n1[1],n2[1],car1,car2,outy[1]);
fullad fd2(n1[2],n2[2],car2,car3,outy[2]);
fullad fd3(n1[3],n2[3],car3,car4,outy[3]);
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