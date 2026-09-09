module ha(input a,b,output sum,cout); 
assign {cout,sum} = a+b;
endmodule 

module fa(input a,b,cin,output sum,cout);
assign {cout,sum} = a+b+cin; 
endmodule 

module main(input [6:0] a ,input [4:0] b, output [11:0] z); 
wire [33:0] p; 
wire [27:0] c; 
wire [18:0] s; 

and(z[0],a[0],b[0]);
and(p[0],a[1],b[0]); 
and(p[1],a[0],b[1]); 
and(p[2],a[2],b[0]); 
and(p[3],a[1],b[1]); 
and(p[4],a[3],b[0]); 
and(p[5],a[2],b[1]); 
and(p[6],a[4],b[0]); 
and(p[7],a[3],b[1]); 
and(p[8],a[5],b[0]); 
and(p[9],a[4],b[1]); 
and(p[10],a[0],b[2]); 
and(p[11],a[1],b[2]); 
and(p[12],a[2],b[2]); 
and(p[13],a[3],b[2]); 
and(p[14],a[6],b[0]); 
and(p[15],a[0],b[3]); 
and(p[16],a[1],b[3]); 
and(p[17],a[2],b[3]); 
and(p[18],a[5],b[1]); 
and(p[19],a[6],b[1]); 
and(p[20],a[0],b[4]); 
and(p[21],a[1],b[4]); 
and(p[22],a[4],b[2]); 
and(p[23],a[5],b[2]); 
and(p[24],a[6],b[2]); 
and(p[25],a[3],b[3]); 
and(p[26],a[4],b[3]); 
and(p[27],a[5],b[3]); 
and(p[28],a[6],b[3]); 
and(p[29],a[2],b[4]); 
and(p[30],a[3],b[4]); 
and(p[31],a[4],b[4]); 
and(p[32],a[5],b[4]); 
and(p[33],a[6],b[4]); 

//row 1 
ha h1(p[0], p[1], z[1], c[0]);
fa f1(p[2], p[3], c[0], s[0], c[1]); 
fa f2(p[4], p[5], c[1], s[1], c[2]); 
fa f3(p[6], p[7], c[2], s[2], c[3]); 
fa f4(p[8], p[9], c[3], s[3], c[4]); 

//row 2 
ha h2(p[10], s[0], z[2], c[5]); 
fa f5(p[11], s[1], c[5], s[4], c[6]); 
fa f6(p[12], s[2], c[6], s[5], c[7]); 
fa f7(p[13], s[3], c[7], s[6], c[8]); 
fa f8(p[14], c[4], c[8], s[7], c[9]); 


//row 3 
ha h3(p[15], s[4], z[3], c[10]); 
fa f9(p[16],s[5],c[10], s[8], c[11]); 
fa f10(p[17], s[6],c[11], s[9], c[12]); 
fa f11(p[18],s[7],c[12], s[10], c[13]); 
fa f12(p[19], c[9], c[13], s[11], c[14]); 

//row 4 
ha h4(p[20], s[8], z[4], c[15]); 
fa f13(p[21], s[9], c[15], z[5], c[16]); 
fa f14(p[22], s[10], c[16], s[12], c[17]); 
fa f15(p[23], s[11], c[17], s[13], c[18]); 
fa f16(p[24], c[14], c[18], s[14], c[19]); 


//row 5 
ha h5(p[25], s[12], s[15], c[20]); 
fa f17(p[26], s[13], c[20], s[16], c[21]); 
fa f18(p[27], s[14], c[21], s[17], c[22]); 
fa f19(p[28], c[19], c[22], s[18], c[23]); 


//row 6 
ha h6(p[29], s[15], z[6], c[24]); 
fa f20(p[30], s[16], c[24], z[7], c[25]); 
fa f21(p[31], s[17], c[25], z[8], c[26]); 
fa f22(p[32], s[18], c[26], z[9], c[27]); 
fa f23(p[33], c[23], c[27], z[10], z[11]);


endmodule

module tb;
  reg [6:0] A;
  reg [4:0] B;
  wire [11:0]Z;
  
  main main(A,B,Z);
  
  initial begin
    $monitor("A = %b: B = %b : z -> %b", A, B,Z);
    A = 7'b0010000; B =5'b00100; #30;
    A = 7'b0010010; B =5'b00110; #30;
    A = 7'b1110010; B =5'b00101; #30;
    A = 7'b0110110; B =5'b10111; #30;
    A = 7'b0100010; B =5'b01100; #30;
    A = 7'b1100100; B =5'b01110;
    
  end
endmodule


