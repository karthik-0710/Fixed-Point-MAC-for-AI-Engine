module segdisplay(number,d0,d1,d2,d3);
input [15:0]number;
output reg [7:0]d0,d1,d2,d3;
always @(*) begin

case(number[3:0])
	4'd0 :   d0 <= 8'hC0;
	4'd1 :   d0 <= 8'hF9;
	4'd2 :   d0 <= 8'hA4;
	4'd3 :   d0 <= 8'hB0;
	4'd4 :   d0 <= 8'h99;
	4'd5 :   d0 <= 8'h92;
	4'd6 :   d0 <= 8'h82;
	4'd7 :   d0 <= 8'hF8;
	4'd8 :   d0 <= 8'h80;
	4'd9 :   d0 <= 8'h90;
	4'd10 :   d0 <= 8'h88;
	4'd11 :   d0 <= 8'h83;
	4'd12 :   d0 <= 8'hC6;
	4'd13 :   d0 <= 8'hA1;
	4'd14 :   d0 <= 8'h86;
	4'd15 :   d0 <= 8'h8E;
   default : d0 <= 8'h00;
	endcase 
	
case(number[7:4])
	4'd0 :   d1 <= 8'hC0;
	4'd1 :   d1 <= 8'hF9;
	4'd2 :   d1 <= 8'hA4;
	4'd3 :   d1 <= 8'hB0;
	4'd4 :   d1 <= 8'h99;
	4'd5 :   d1 <= 8'h92;
	4'd6 :   d1 <= 8'h82;
	4'd7 :   d1 <= 8'hF8;
	4'd8 :   d1 <= 8'h80;
	4'd9 :   d1 <= 8'h90;
	4'd10 :   d1 <= 8'h88;
	4'd11 :   d1 <= 8'h83;
	4'd12 :   d1 <= 8'hC6;
	4'd13 :   d1 <= 8'hA1;
	4'd14 :   d1 <= 8'h86;
	4'd15 :   d1 <= 8'h8E;
   default : d1 <= 8'h00;
	endcase 
	
case(number[11:8])
	4'd0 :   d2 <= 8'hC0;
	4'd1 :   d2 <= 8'hF9;
	4'd2 :   d2 <= 8'hA4;
	4'd3 :   d2 <= 8'hB0;
	4'd4 :   d2 <= 8'h99;
	4'd5 :   d2 <= 8'h92;
	4'd6 :   d2 <= 8'h82;
	4'd7 :   d2 <= 8'hF8;
	4'd8 :   d2 <= 8'h80;
	4'd9 :   d2 <= 8'h90;
	4'd10 :   d2 <= 8'h88;
	4'd11 :   d2 <= 8'h83;
	4'd12 :   d2 <= 8'hC6;
	4'd13 :   d2 <= 8'hA1;
	4'd14 :   d2 <= 8'h86;
	4'd15 :   d2 <= 8'h8E;
   default : d2 <= 8'h00;
	endcase 

	
case(number[15:12])
	4'd0 :   d3 <= 8'hC0;
	4'd1 :   d3 <= 8'hF9;
	4'd2 :   d3 <= 8'hA4;
	4'd3 :   d3 <= 8'hB0;
	4'd4 :   d3 <= 8'h99;
	4'd5 :   d3 <= 8'h92;
	4'd6 :   d3 <= 8'h82;
	4'd7 :   d3 <= 8'hF8;
	4'd8 :   d3 <= 8'h80;
	4'd9 :   d3 <= 8'h90;
	4'd10 :   d3 <= 8'h88;
	4'd11 :   d3 <= 8'h83;
	4'd12 :   d3 <= 8'hC6;
	4'd13 :   d3 <= 8'hA1;
	4'd14 :   d3 <= 8'h86;
	4'd15 :   d3 <= 8'h8E;
   default : d3 <= 8'h00;
	endcase 
	

end	
endmodule
 