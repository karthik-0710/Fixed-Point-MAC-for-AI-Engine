//Sign bit identification

module sign_bit(
output wire sign,
input wire[15:0] in1,
input wire[15:0] in2
);
xor(sign,in1[15],in2[15]);
endmodule

//Adding the exponents & subtracting the bias

module full_adder(
output wire sum,
output wire cout,
input wire in1,
input wire in2,
input wire cin
);
wire temp1;
wire temp2;
wire temp3;
xor(sum,in1,in2,cin);
and(temp1,in1,in2);
and(temp2,in1,cin);
and(temp3,in2,cin);
or(cout,temp1,temp2,temp3);
endmodule

//5 bit Ripple-carry adder
module ripple_5(
output wire[4:0] sum,
output wire cout,
input wire[4:0] in1,
input wire[4:0] in2,
input wire cin
);
wire c1,c2,c3,c4;
full_adder FA1(sum[0],c1,in1[0],in2[0],cin);
full_adder FA2(sum[1],c2,in1[1],in2[1],c1);
full_adder FA3(sum[2],c3,in1[2],in2[2],c2);
full_adder FA4(sum[3],c4,in1[3],in2[3],c3);
full_adder FA5(sum[4],cout,in1[4],in2[4],c4);
endmodule

// Subtraction of bias 

module full_subtractor_sub1(
output wire diff, //difference
output wire bout, //borrow out
input wire min, //minuend
input wire bin //borrow in
);
//Here, the subtrahend is always 1. We can implement it as:
xnor(diff,min,bin);
or(bout,min,bin);
endmodule

//1 bit subtractor with subtrahend = 0
module full_subtractor_sub0(
output wire diff, //difference
output wire bout, //borrow out
input wire min, //minuend
input wire bin //borrow in
);
//Here, the subtrahend is always 0.We can implement it as:
xor(diff,min,bin);
and(bout,min,bin);
endmodule

module subtractor_6(
output wire [5:0] diff,
output wire bout,
input wire [5:0] min,
input wire bin
);
wire b1,b2,b3,b4,b5;
full_subtractor_sub1 sub1(diff[0],b1,min[0],bin);
full_subtractor_sub1 sub2(diff[1],b2,min[1],b1);
full_subtractor_sub1 sub3(diff[2],b3,min[2],b2);
full_subtractor_sub1 sub4(diff[3],b4,min[3],b3);
full_subtractor_sub0 sub5(diff[4],bout,min[4],b4); //last most significand subtrahend is 0 in 01111.
endmodule

//MULTIPYING THE MANTISSA

module block(
output wire ppo, //output partial product term
output wire cout, //output carry out
output wire mout, //output multiplicand term
input wire min, //input multiplicand term
input wire ppi, //input partial product term
input wire q, //input multiplier term
input wire cin //input carry in
);
wire temp;
and(temp,min,q);
full_adder FA(ppo,cout,ppi,temp,cin);
or(mout,min,1'b0);
endmodule

module row(
output wire[10:0] ppo,
output wire[10:0] mout,
output wire sum,
input wire[10:0] min,
input wire[10:0] ppi,
input wire q
);
wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10;
block b1 (sum,c1,mout[0],min[0],ppi[0],q,1'b0);
block b2 (ppo[0], c2, mout[1], min[1], ppi[1], q, c1);
block b3 (ppo[1], c3, mout[2], min[2], ppi[2], q, c2);
block b4 (ppo[2], c4, mout[3], min[3], ppi[3], q, c3);
block b5 (ppo[3], c5, mout[4], min[4], ppi[4], q, c4);
block b6 (ppo[4], c6, mout[5], min[5], ppi[5], q, c5);
block b7 (ppo[5], c7, mout[6], min[6], ppi[6], q, c6);
block b8 (ppo[6], c8, mout[7], min[7], ppi[7], q, c7);
block b9 (ppo[7], c9, mout[8], min[8], ppi[8], q, c8);
block b10(ppo[8], c10, mout[9], min[9], ppi[9], q, c9);
block b11(ppo[9], ppo[10], mout[10], min[10], ppi[10], q, c10);
endmodule

module product(
output wire[21:0] sum,
input wire[10:0] min,
input wire[10:0]q
);
wire [10:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10; //diagonal m
wire [10:0] temp11;
wire [10:0] ptemp1,ptemp2,ptemp3,ptemp4,ptemp5,ptemp6,ptemp7,ptemp8,ptemp9,ptemp10;
//vertical p
row r1 (ptemp1, temp1, sum[0], min, 11'h0000, q[0]);
row r2 (ptemp2, temp2, sum[1], temp1, ptemp1, q[1]);
row r3 (ptemp3, temp3, sum[2], temp2, ptemp2, q[2]);
row r4 (ptemp4, temp4, sum[3], temp3, ptemp3, q[3]);
row r5 (ptemp5, temp5, sum[4], temp4, ptemp4, q[4]);
row r6 (ptemp6, temp6, sum[5], temp5, ptemp5, q[5]);
row r7 (ptemp7, temp7, sum[6], temp6, ptemp6, q[6]);
row r8 (ptemp8, temp8, sum[7], temp7, ptemp7, q[7]);
row r9 (ptemp9, temp9, sum[8], temp8, ptemp8, q[8]);
row r10(ptemp10, temp10, sum[9], temp9, ptemp9, q[9]);
row r11(sum[21:11], temp11, sum[10], temp10, ptemp10, q[10]);
endmodule

//NORMALISING THE MANTISSA

module normalize(
output wire[9:0] adj_mantissa, //adjusted mantissa (after extracting out required part)
output wire norm_flag,
input wire[22:0] prdt
); //returns norm =1 if normalization needs to be done.
and(norm_flag,prdt[22],1'b1); //sel = 1 if leading one is at 22... needs normalization
//if sel = 0, leading zero not at 22... no need of normalization
wire [1:0][9:0] results;
assign results[0] = prdt[20:10];
assign results[1] = prdt[21:11];
assign adj_mantissa = {results[norm_flag+0]};
endmodule

//Overflow & Underflow check and control module

//Control module to drive and regulate required modules in order
module control(
input wire[15:0] inp1,
input wire[15:0] inp2,
output wire[15:0] out,
output wire underflow,
output wire overflow
);
wire sign;
wire [4:0] exp1;
wire [4:0] exp2;
wire [4:0] exp_out;
wire [4:0] test_exp;
wire [9:0] mant1;
wire [9:0] mant2;
wire [9:0] mant_out;
sign_bit sign_bit1(sign,inp1,inp2);
wire [4:0]temp1;
wire dummy; //to connect unused cout ports of adder wire carry;
wire [5:0] sub_temp;
ripple_5 rip1(temp1,carry,inp1[14:10],inp2[14:10],1'b0);
subtractor_6 sub1(sub_temp,underflow,{carry,temp1},1'b0);
//if there is a carry out => underflow
and(overflow,sub_temp[5],1'b1); //if the exponent has more than 5 bits: overflow
//taking product of mantissa:
wire [21:0] prdt;
product p1(prdt,{1'b1,inp1[9:0]},{1'b1,inp2[9:0]});
wire norm_flag;
wire [9:0] adj_mantissa;
normalize norm1(adj_mantissa,norm_flag,prdt);
ripple_5 ripple_norm(test_exp,dummy,sub_temp[4:0],{4'b0,norm_flag},1'b0);
assign out[15] = sign;
assign out[14:10] = test_exp;
assign out[9:0] = adj_mantissa;
endmodule
