`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2023 10:48:13
// Design Name: 
// Module Name: cache_que_register
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


module cache_que_register(
    input clk,
    input reset,
    input [31:0] address,
    input call_from_memory,
    input done,
    
    output reg [31:0] call_any,
    output reg [4:0] rs1
    );
    reg [31:0] mem [3:0];
    integer i;
    reg counter;
    reg read_pointer;
    
    always@(posedge clk) begin
        if(reset == 1) begin
            for(i=0; i<4; i= i+1)begin
                mem[i] <= 0;
            end
            rs1 <= 0;
            call_any <= 0;
            counter <= 0;
            read_pointer <= 0;
        end
        else begin
            call_any <= mem[read_pointer];
            rs1 <= mem[read_pointer][6:2]; 
            
            if(call_from_memory == 1) begin
                mem[counter] <= address;
                counter <= counter + 1;
            end
            
            if (done == 1) begin
                mem[read_pointer] <= 0;
                read_pointer <= read_pointer + 1;
            end
        end
    end
endmodule
