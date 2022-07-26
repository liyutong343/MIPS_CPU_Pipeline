`timescale 1ns / 1ps

module test_cpu();
	
	reg reset;
	reg system_clk;
	wire [3:0] AN;
	wire [7:0] BCD;
	wire [7:0] small_pc;
	
	CPU cpu1(reset, system_clk, AN, BCD, small_pc);
	
	initial begin
		reset = 1;
		system_clk = 1;
		#5 reset = 0;
	end
	
	always #5 system_clk = ~system_clk;
		
endmodule
