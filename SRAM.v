module SRAM (Cs_b, We_b, Oe_b, Address, IO);
input Cs_b;
input We_b;
input Oe_b;
input[7:0] Address;
inout[7:0] IO;
reg[15:0] RAM1[7:0];
assign IO = (Cs_b == 1'b1 | We_b == 1'b0 | Oe_b == 1'b1) ?
8'bZZZZZZZZ : RAM1[Address] ; // read from RAM
always @(We_b, Cs_b)
begin
@(posedge We_b) //rising edge of We_b
if(Cs_b == 1'b0)
begin
RAM1[Address] <= IO ; // write to RAM
end
end
endmodule