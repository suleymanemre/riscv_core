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


module data_memory(
//compulsory input
    input [31:0] alu_result,
    input [31:0] write_data,
    input [3:0] mem_write,
//compulsory output
    output reg [31:0] read_data,
// my inout
    input clk,
    input reset
    );
    reg [31:0] mem [31:0];
    reg [31:0] holder1;
    
    always @(posedge reset) begin
        mem[0]=     0;          // 5;
        mem[1]=     0;          // 1;
        mem[2]=     0;          // 2;
        mem[3]=     0;          // 3;
        mem[4]=     0;          // 4;
        mem[5]=     0;          // 5;
        mem[6]=     0;          // 6;
        mem[7]=     0;          // 7;
        mem[8]=     0;          // 8;
        mem[9]=     0;          // 9;
        mem[10]=    0;          // 10;
        mem[11]=    0;          // 32'h10101011;
        mem[12]=    0;          // 32'h10101111;
        mem[13] =   0;          // 13;
        mem[14] =   0;          // 14;
        mem[15] =   0;          // 15;
        mem[16]=    0;          // 32'h10101010;
        mem[17]=    0;          // 3;
        mem[18] =   0;          // 18;
        mem[19] =   0;          // 19;
        mem[20] =   0;          // 20;
        mem[21] =   0;          // 21;
        mem[22] =   0;          // 22;
        mem[23] =   0;          // 23;
        mem[24] =   0;          // 24;
        mem[25] =   0;          // 25;
        mem[26] =   0;          // 26;
        mem[27] =   0;          // 27;
        mem[28] =   0;          // 28;
        mem[29] =   0;          // 29;
        mem[30] =   0;          // 30;
        mem[31] =   0;          // 31;
    end
    
    always @(*)begin //kaydýrmalý yazdýrma eklendi
        case(mem_write)
            0: begin //yaz
                read_data = alu_result;
            end
            1: begin //tamamýný yaz
                case(alu_result[1:0])
                    2'b00:  mem[alu_result[6:2]] = write_data;
                    2'b01: begin
                            mem[alu_result[6:2]][31:8] = write_data [23:0];
                            mem[alu_result[6:2]+1][7:0] = write_data[31:24];
                           end
                    2'b10: begin
                            mem[alu_result[6:2]][31:16] = write_data[15:0];
                            mem[alu_result[6:2]+1][15:0] = write_data[31:16];
                           end
                    2'b11: begin
                            mem[alu_result[6:2]][31:24] = write_data[7:0];
                            mem[alu_result[6:2]+1][23:0] = write_data[13:8];
                           end
                endcase
            end
            2: begin //yarýsýný yaz
                case(alu_result[1:0])
                    2'b00: mem[alu_result[6:2]][15:0] = {write_data[15:0]};
                    2'b01: mem[alu_result[6:2]][23:8] = {write_data[15:0]};
                    2'b10: mem[alu_result[6:2]][31:16] = {write_data[15:0]};
                    2'b11: begin
                           mem[alu_result[6:2]+1][7:0] = {write_data[15:8]};
                           mem[alu_result[6:2]][31:16] = {write_data[7:0]};
                           end
                endcase
            end
            3: begin //çeyreðini yaz
                case (alu_result[1:0])
                    2'b00: mem[alu_result[6:2]][7:0] = {write_data[7:0]};
                    2'b01: mem[alu_result[6:2]][15:8] = {write_data[7:0]};
                    2'b10: mem[alu_result[6:2]][23:16] = {write_data[7:0]};
                    2'b11: mem[alu_result[6:2]][31:24] = {write_data[7:0]};
                endcase
            end
            4: begin //load word
                case(alu_result[1:0])
                    2'b00:read_data = mem[alu_result[6:2]];
                    2'b01:read_data = {mem[alu_result[6:2]+1][7:0],mem[alu_result[6:2]][31:8]};
                    2'b10:read_data = {mem[alu_result[6:2]+1][15:0],mem[alu_result[6:2]][31:16]};
                    2'b11:read_data = {mem[alu_result[6:2]+1][23:0],mem[alu_result[6:2]][31:24]};
                endcase
            end
            5: begin // load half signed
                case(alu_result[1:0])
                    2'b00: read_data = {{16{1'b1}},mem[alu_result[6:2]][15:0]};
                    2'b01: read_data = {{16{1'b1}},mem[alu_result[6:2]][23:8]};
                    2'b10: read_data = {{16{1'b1}},mem[alu_result[6:2]][31:16]};
                    2'b11: read_data = {{16{1'b1}},mem[alu_result[6:2]+1][7:0],mem[alu_result[6:2]][31:24]};
                endcase
            end
            6: begin // load byte signed
                case(alu_result[1:0])
                    2'b00: read_data = {{24{1'b1}},mem[alu_result[6:2]][7:0]};
                    2'b01: read_data = {{24{1'b1}},mem[alu_result[6:2]][15:8]};
                    2'b10: read_data = {{24{1'b1}},mem[alu_result[6:2]][23:16]};
                    2'b11: read_data = {{24{1'b1}},mem[alu_result[6:2]][31:24]};
                endcase
            end
            7: begin // load byte unsigned
                case(alu_result[1:0])
                    2'b00: read_data = {{24{1'b0}},mem[alu_result[6:2]][7:0]};
                    2'b01: read_data = {{24{1'b0}},mem[alu_result[6:2]][15:8]};
                    2'b10: read_data = {{24{1'b0}},mem[alu_result[6:2]][23:16]};
                    2'b11: read_data = {{24{1'b0}},mem[alu_result[6:2]][31:24]};
                endcase
            end
            8: begin // load half unsigned
                case(alu_result[1:0])
                    2'b00: read_data = {{16{1'b0}},mem[alu_result[6:2]][15:0]};
                    2'b01: read_data = {{16{1'b0}},mem[alu_result[6:2]][23:8]};
                    2'b10: read_data = {{16{1'b0}},mem[alu_result[6:2]][31:16]};
                    2'b11: read_data = {{16{1'b0}},mem[alu_result[6:2]+1][7:0],mem[alu_result[6:2]][31:24]};
                endcase
            end
        endcase
    end
    
//    always @(*)begin //V1 kaydýrarak yazma yok
//        holder1 = mem[alu_result[4:0]];
        
//        case(mem_write)
//            0: begin //yaz
//                read_data = alu_result;
//            end
//            1: begin //tamamýný yaz
//                mem[alu_result[4:0]] = write_data;
//            end
//            2: begin //yarýsýný yaz
//                mem[alu_result[4:0]] = {holder1[31:16],write_data[15:0]};
//            end
//            3: begin //çeyreðini yaz
//                mem[alu_result[4:0]] = {holder1[31:8],write_data[7:0]};
//            end
//            4: begin //load word
//                read_data = mem[alu_result[4:0]];
//            end
//            5: begin // load half
//                read_data = {{holder1[31]},{15{1'b0}},holder1[15:0]};
//            end
//            6: begin // load byte
//                read_data = {{holder1[31]},{23{1'b0}},holder1[7:0]};
//            end
//            7: begin // load byte unsigned
//                read_data = {{24{1'b0}},holder1[7:0]};
//            end
//            8: begin // load half unsigned
//                read_data = {{16{1'b0}},holder1[15:0]};
//            end
//        endcase
//    end
endmodule