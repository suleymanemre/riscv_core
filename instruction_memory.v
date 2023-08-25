`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2023 08:34:26
// Design Name: 
// Module Name: extend
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


module instruction_memory(
//compulsory input
    input [31:0]pc,
    input clk,
//compulsory output
    output reg [31:0] instr,
    output reg compressed_or_not,
    output reg instruction_pointer,
// my inout
    input reset
    );
    parameter reg00 = 5'b00000; parameter reg01 = 5'b00001; parameter reg02 = 5'b00010; parameter reg03 = 5'b00011;
    parameter reg04 = 5'b00100; parameter reg05 = 5'b00101; parameter reg06 = 5'b00110; parameter reg07 = 5'b00111;
    parameter reg08 = 5'b01000; parameter reg09 = 5'b01001; parameter reg10 = 5'b01010; parameter reg11 = 5'b01011;
    parameter reg12 = 5'b01100; parameter reg13 = 5'b01101; parameter reg14 = 5'b01110; parameter reg15 = 5'b01111;
    parameter reg16 = 5'b10000; parameter reg17 = 5'b10001; parameter reg18 = 5'b10010; parameter reg19 = 5'b10011;
    parameter reg20 = 5'b10100; parameter reg21 = 5'b10101; parameter reg22 = 5'b10110; parameter reg23 = 5'b10111;
    parameter reg24 = 5'b11000; parameter reg25 = 5'b11001; parameter reg26 = 5'b11010; parameter reg27 = 5'b11011;
    parameter reg28 = 5'b11100; parameter reg29 = 5'b11101; parameter reg30 = 5'b11110; parameter reg31 = 5'b11111;
    
    parameter opb = 7'b1100011; //branch operation
    parameter ops = 7'b0100011; //store operation
    parameter opl = 7'b0000011; //load operation
    parameter opz = 7'b0110011; //add sub vesaire
    parameter opi = 7'b0010011; //addi subi immediate için
    parameter jlr = 7'b1100111; //jalr
    parameter jal = 7'b1101111; //jal
    parameter lui = 7'b0110111; //lui
    parameter aui = 7'b0010111; //auipc
    
    parameter op00 = 2'b00;
    parameter op01 = 2'b01;
    parameter op10 = 2'b10;
    
    parameter total_mem_size = 1904;
    parameter pc_size = $clog2(total_mem_size)+2;
    parameter nof_zero = 34 - pc_size;
    parameter [31:0] start_point = 32'h8000006c;
   
    
    reg [31:0] mem [total_mem_size:0];
    reg [1:0] instr_pointer;
    reg [31:0] holdern;
    
    integer i=0;
    integer outfile;

    
    initial begin
        outfile = $fopen("./../../../../../Desktop/instr_hexadecimal.txt","w");
        $readmemh ("./../../../../../Desktop/test_hex.txt", mem,start_point[pc_size:2],total_mem_size);       
    end
    
    always @(posedge clk)begin
        holdern = {{nof_zero{1'b0}},pc[pc_size:2]};
        if (reset == 1) begin
        
        end
        else begin
            
            
        end
    end
    reg [29:0] holder,holder1,holder2,holder3;
    
    
    always @(*) begin //V3
        holder = pc[pc_size:2];
        if (reset ==1) begin
            instr = 0;
            compressed_or_not = 0;
        end
        else begin
            if (pc[1] == 0)begin // 4 ün katý
                if (mem[{{nof_zero{1'b0}},pc[pc_size:2]}][1:0] == 3) begin //32 bit 
                    instr = mem[{2'b00,pc[pc_size:2]}];
                    compressed_or_not = 0;
                end
                else begin // 16 bit
                    instr = {{16{1'b0}},mem[{{nof_zero{1'b0}},pc[pc_size:2]}][15:0]};
                    compressed_or_not = 1;
                end
            end
            else if (pc[1] == 1) begin // 4n+2  ara deðer
                if (mem[{{nof_zero{1'b0}},pc[pc_size:2]}][17:16] == 3) begin //32 bit 
                    instr = {mem[{{nof_zero{1'b0}},pc[pc_size:2]}+1][15:0],mem[{{nof_zero{1'b0}},pc[pc_size:2]}][31:16]};
                    compressed_or_not = 0;
                end
                else begin // 16 bit
                    instr = {{16{1'b0}},mem[{{nof_zero{1'b0}},pc[pc_size:2]}][31:16]};
                    compressed_or_not = 1;
                end
            end
        end
    end
    
    
    
    
    
    
    
    
//    always @(*) begin //V2
//        holder = mem[pc][1:0];
//        holder2 = mem[pc-2][1:0];
//        holder1 = mem[pc][17:16];
//        holder3 = mem[pc-2][17:16];
//        if (reset ==1) begin
//            instr = 0;
//            compressed_or_not = 0;
//        end
//        else begin
//            if (pc[1] == 0)begin // 4 ün katý
//                if (mem[pc][1:0] == 3) begin //32 bit 
//                    instr = mem[pc];
//                    compressed_or_not = 0;
//                end
//                else begin // 16 bit
//                    instr = {{16{1'b0}},mem[pc][15:0]};
//                    compressed_or_not = 1;
//                end
//            end
//            else if (pc[1] == 1) begin //4 ün katý deðil
//                if (mem[pc-2][17:16] == 3) begin //32 bit 
//                    instr = {mem[pc+2][15:0],mem[pc-2][31:16]};
//                    compressed_or_not = 0;
//                end
//                else begin // 16 bit
//                    instr = {{16{1'b0}},mem[pc-2][31:16]};
//                    compressed_or_not = 1;
//                end
//            end
//        end
//    end

endmodule