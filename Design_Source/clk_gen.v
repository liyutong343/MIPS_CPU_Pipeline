`timescale 1ns / 1ps
module clk_gen(
    input wire reset,
    input wire system_clk,
    output reg clk
);

parameter   CNT = 2'd2;

reg     [1:0]  count;

initial begin
    count <= 2'd0;
    clk <= 1'b0;
end

always @(posedge system_clk or posedge reset)
begin
    if(reset) begin
        clk <= 1'b0;
        count <= 2'd0;
    end
    else begin
        count <= (count==CNT-2'd1) ? 2'd0 : count + 2'd1;
        clk <= (count==2'd0) ? ~clk : clk;
    end
end

endmodule
