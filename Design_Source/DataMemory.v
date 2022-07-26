// module DataMemory(reset, 
// clk, Address, Write_data, Read_data, MemRead, 
// MemWrite, DisplaySignal);
// 	input reset, clk;
// 	input [31:0] Address, Write_data;
// 	input MemRead, MemWrite;
// 	output [31:0] Read_data;
// 	input [11:0] DisplaySignal;
	
// 	parameter RAM_SIZE = 256;
// 	parameter RAM_SIZE_BIT = 8;
	
// 	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
// 	assign Read_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
// 	integer i;
// 	always @(posedge reset or posedge clk)
// 		if (reset)
// 			for (i = 0; i < RAM_SIZE; i = i + 1)
// 				RAM_data[i] <= 32'h00000000;
// 		else if (MemWrite)
// 			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
	
// 	assign DisplaySignal = 
			
// endmodule
`timescale 1ns / 1ps
module DataMemory(
	input wire reset,
	input wire clk,
	input wire [31:0] Address,
	input wire [31:0] WriteData,
	output wire [31:0] ReadData,
	input wire MemRead,
	input wire MemWrite,
	output reg [3:0] AN,
	output reg [7:0] BCD,
	output reg [7:0] leds
);

parameter RAM_SIZE = 256;
reg [31:0] RAM_data[RAM_SIZE - 1: 0];

integer j;
initial begin
		AN <= 4'b1110;
		BCD <= 8'b11111111;
		leds <= 8'b0;
		for (j = 0; j < RAM_SIZE; j = j + 1)
 			RAM_data[j] <= 32'h00000000;
end

// Read data
assign ReadData = MemRead == 1'b0 ? 32'h0 : 
				Address == 32'h4000000c ? {24'b0, leds} : 
				Address == 32'h40000010 ? {20'h0, AN, BCD} : RAM_data[Address[9:2]]; 

// Write data
integer i;
always @* begin
	if(reset) begin
		AN <= 4'b1110;
		BCD <= 8'b11111111;
		leds <= 8'b0;
		RAM_data[0] <= 32'd32;
		RAM_data[1] <= 32'd117;
		RAM_data[2] <= 32'd110;
		RAM_data[3] <= 32'd105;
		RAM_data[4] <= 32'd120;
		RAM_data[5] <= 32'd32;
		RAM_data[6] <= 32'd105;
		RAM_data[7] <= 32'd115;
		RAM_data[8] <= 32'd32;
		RAM_data[9] <= 32'd110;
		RAM_data[10] <= 32'd111;
		RAM_data[11] <= 32'd116;
		RAM_data[12] <= 32'd32;
		RAM_data[13] <= 32'd117;
		RAM_data[14] <= 32'd110;
		RAM_data[15] <= 32'd105;
		RAM_data[16] <= 32'd120;
		RAM_data[17] <= 32'd32;
		RAM_data[18] <= 32'd105;
		RAM_data[19] <= 32'd115;
		RAM_data[20] <= 32'd32;
		RAM_data[21] <= 32'd110;
		RAM_data[22] <= 32'd111;
		RAM_data[23] <= 32'd116;
		RAM_data[24] <= 32'd32;
		RAM_data[25] <= 32'd117;
		RAM_data[26] <= 32'd110;
		RAM_data[27] <= 32'd105;
		RAM_data[28] <= 32'd120;

		RAM_data[128] <= 32'd117;
		RAM_data[129] <= 32'd110;
		RAM_data[130] <= 32'd105;
		RAM_data[131] <= 32'd120;

		for (i = 29; i < 128; i = i + 1)
 			RAM_data[i] <= 32'h0;
		
		for (i = 132; i < RAM_SIZE; i = i + 1)
			RAM_data[i] <= 32'h0;
	end
	else if(MemWrite) begin
		if(Address == 32'h40000010) begin
			AN <= WriteData[11:8];
			BCD <= WriteData[7:0];
			leds <= leds;
			for(i = 0; i < RAM_SIZE; i = i + 1) RAM_data[i] <= RAM_data[i];
		end
		else if(Address == 32'h4000000c) begin
			leds <= WriteData[7:0];
			AN <= AN;
			BCD <= BCD;
			for(i = 0; i < RAM_SIZE; i = i + 1) RAM_data[i] <= RAM_data[i];
		end
		else begin
		    AN <= AN;
            BCD <= BCD;
            leds <= leds;
            for(i = 0; i < RAM_SIZE; i = i + 1) begin
                if(i == Address[9:2]) begin
                    RAM_data[i] <= WriteData;
                end
                else begin
                    RAM_data[i] <= RAM_data[i];
                end
            end
		end
	end
end

endmodule