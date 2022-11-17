
module FloatingPointMAC(
input Reset,
input Clock, 
input [3:0] RowIn, 
output [3:0] ColOut,  
output reg [3:0] seg, 
output reg KeyRdy, 
input KeyRd,
output reg [7:0] disp0,disp1,disp2,disp3,disp4,disp5,
output reg [8:0] led,
output reg [3:0] lcdout,
//output reg [7:0] prod1 , prod2 , prod3,
input nxtstbutton,
input press,
output reg [2:0] led_pin
);

reg [15:0] prod1 , prod2 , prod3; 
parameter Scan=3'b000, CalculateKeypad=3'b001, Analyze=3'b010, WaitForRead=3'b011; 
parameter WaitForButton=3'b100,Multiply=3'b101;
reg [1:0]showoutput;
reg [1:0] sp;
reg [3:0] State;
reg [15:0] Data;
reg [3:0] Col;
reg [3:0] Sum;
reg waitbit;
reg [2:0] counter;
reg [1:0]inputno;
reg [2:0] index;
reg [15:0]data_reg;
reg [15:0]weight_reg;
assign ColOut[0] = Col[0] ? 1'bz : 1'b0; 
assign ColOut[1] = Col[1] ? 1'bz : 1'b0; 
assign ColOut[2] = Col[2] ? 1'bz : 1'b0; 
assign ColOut[3] = Col[3] ? 1'bz : 1'b0;
reg [31:0] clkcnt;
reg clk_out; 
reg Cs_b;
reg We_b;
reg Oe_b;
reg[7:0] Address;
wire [7:0] IO;
reg [3:0] Ard_in;
reg[15:0] inp1,display_input, display_input1,display_input2,display_input3;
reg[15:0] inp2;
wire[15:0] out;
wire underflow;
wire overflow;
wire [7:0] d0,d1,d2,d3;
wire slow_clk;
reg[15:0] arr[9];
reg[15:0] val;
reg enable = 1;
//reg temp = 0;
 
//assign display_input = 4'h1244;

 
 always@(*)begin
  disp0 = d0;
  disp1 = d1;
  disp2 = d2;
  disp3 = d3;
 end
 
 
 
clock_div1 c1(Clock,slow_clk);
segdisplay SD(display_input,d0,d1,d2,d3);
reg [3:0] i=0;
initial begin
	val 	 =  16'hF9B7;
	arr[0]=   16'hB78E;
	arr[1] =  16'hB78E;
	arr[2] =  16'hB78E;
	arr[3] =  16'hB78E;
	arr[4] =  16'hB78E;
	arr[5] =  16'hB78E;
	arr[6] =  16'hB78E;
	arr[7] =  16'hB78E;
	arr[8] =  16'hB78E;
	//arr[8] =  16'h482B;
end


and(ao,slow_clk,enable);



always @(posedge ao) begin
		disp4 <= 8'b11111111;
		disp5 <= 8'b11111111;
		display_input <= val;
		led[8] = 1'b1;
      led[7] = 1'b1;
		if(press==1'b1) begin
		/*temp<=1'b1;
		if(temp==1'b1)begin*/
		//led[5] <= 1'b0;
		display_input <= arr[i];
		i = i+1;
		if(i==9)
		enable =0;
		end


end
endmodule



/*module clock_div(input Clk, output reg SlowClock);
parameter clock_threshold = 2500000;
reg [23:0] clk_counter;

always @(posedge Clk ) begin 

   if (clk_counter == clock_threshold) 
	begin 
			clk_counter <= 0;
			SlowClock <= ~SlowClock; 
	end
		else 
					clk_counter <= clk_counter+1;
		end
endmodule*/


module clock_div1(input Clk, output reg SlowClock);
parameter clock_threshold = 50000000;
reg [27:0] clk_counter;

always @(posedge Clk ) begin 

   if (clk_counter == clock_threshold) 
	begin 
			clk_counter <= 0;
			SlowClock <= ~SlowClock; 
	end
		else 
					clk_counter <= clk_counter+1;
		end
endmodule