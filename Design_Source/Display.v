module Display(
    input wire reset;
    input wire clk_1K;
    input wire DisplayEnable;
    input wire [15:0] Number;
    output reg [11:0] DisplaySignal;
);

    initial begin
        DisplaySignal <= 16'b0;
    end

    reg [3:0] Num;

    always @(posedge reset or posedge clk_1K) begin
        if(reset) begin
            DisplaySignal <= 12'b0;
        end
        else if(DisplayEnable) begin
            case(DisplaySignal[11:8])
                4'b0001: begin
                    DisplaySignal[11:8] <= 4'b0010;
                    Num <= Number[7:4];
                end
                4'b0010: begin
                    DisplaySignal[11:8] <= 4'b0100;
                    Num <= Number[11:8];
                end
                4'b0100: begin
                    DisplaySignal[11:8] <= 4'b1000;
                    Num <= Number[15:12];
                end
                4'b1000: begin
                    DisplaySignal[11:8] <= 4'b0001;
                    Num <= Number[3:0];
                end
                default : begin
                    DisplaySignal[11:8] <= 4'b0001;
                    Num <= Number[3:0];
                end
            endcase
        end

    end

    always@* begin
        case(Num) 
            4'h0: begin
                DisplaySignal[7:0] <= 8'b11000000;// c0
            end
            4'h1: begin
                DisplaySignal[7:0] <= 8'b11111001;// f9
            end
            4'h2: begin
                DisplaySignal[7:0] <= 8'b10100100;// a4
            end
            4'h3: begin
                DisplaySignal[7:0] <= 8'b10110000;// b0
            end
            4'h4: begin
                DisplaySignal[7:0] <= 8'b10011001;// 99
            end
            4'h5: begin
                DisplaySignal[7:0] <= 8'b10010010; //92
            end
            4'h6: begin
                DisplaySignal[7:0] <= 8'b10000010;//82
            end
            4'h7: begin
                DisplaySignal[7:0] <= 8'b11111000;//f8
            end
            4'h8: begin
                DisplaySignal[7:0] <= 8'b10000000;//80
            end
            4'h9: begin
                DisplaySignal[7:0] <= 8'b10010000;//90
            end
            4'ha: begin
                DisplaySignal[7:0] <= 8'b10001000;//88
            end
            4'hb: begin
                DisplaySignal[7:0] <= 8'b10000011;//83
            end
            4'hc: begin
                DisplaySignal[7:0] <= 8'b11000110;//c6
            end
            4'hd: begin
                DisplaySignal[7:0] <= 8'b10100001;//a1
            end
            4'he: begin
                DisplaySignal[7:0] <= 8'b10000100;//84
            end
            4'hf: begin
                DisplaySignal[7:0] <= 8'b10001110;//8e
            end
            default: begin
                DisplaySignal[7:0] <= 8'b11111111;//ff
            end
        endcase
    end
    

endmodule