`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2023 10:52:52
// Design Name: 
// Module Name: main_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_memory(
    input clk,
    input reset,
    input [31:0] alu_result,
    input [3:0] mem_write,
    input [31:0] write_data,
    output reg [31:0] out
    );
    reg [31:0] mem [127:0];
    integer i;
    reg [31:0] write_data1, alu_result1;
    reg [3:0] mem_write1;
    reg [6:0] holder;
    initial begin
        for (i=0; i<128; i= i+1) begin
            mem[i] = i + 12;
        end
    end
    
    always@(posedge clk) begin
        if (reset == 1) begin
            out <= 0;
            write_data1 <= 0;
            alu_result1 <= 0;
            mem_write1 <= 0;
            holder <= 0;
        end
        else begin
            write_data1 <= write_data;
            alu_result1 <= alu_result;
            mem_write1 <= mem_write;
            holder <= alu_result[8:2];
            
            case(mem_write1)
                1: begin
                    mem[alu_result1[8:2]] <= write_data1;
                end    
                2: begin
                    mem[alu_result1[8:2]] <= {{16{1'b0}}, write_data1[15:0]};
                end
                3: begin
                    mem[alu_result1[8:2]] <= {{24{1'b0}},write_data1[7:0]};
                end 
            endcase
            
            out <= mem[alu_result[8:2]]; 
        end
    end
    
endmodule
