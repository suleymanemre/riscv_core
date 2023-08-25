`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2023 10:52:15
// Design Name: 
// Module Name: cache_L1
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


module cache_L1(
    input clk,
    input reset,
    input [3:0] mem_write,
    input [31:0] write_data,
    input [31:0] alu_result,
    input save_to_cache,
    input [31:0] mainmem_result,
    output reg miss,
    output reg [31:0] read_data
    );
    
    reg [31:0] mem [31:0];
    reg [31:0] tag_array [31:0];
    integer i;
   
    
    always@(posedge clk)begin
        if (reset == 1) begin
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
            
            tag_array[0]=     0;            tag_array[16]=    0;        tag_array[8]=     0;            tag_array[24] =   0;                  
            tag_array[1]=     0;            tag_array[17]=    0;        tag_array[9]=     0;            tag_array[25] =   0;            
            tag_array[2]=     0;            tag_array[18] =   0;        tag_array[10]=    0;            tag_array[26] =   0;            
            tag_array[3]=     0;            tag_array[19] =   0;        tag_array[11]=    0;            tag_array[27] =   0;            
            tag_array[4]=     0;            tag_array[20] =   0;        tag_array[12]=    0;            tag_array[28] =   0;            
            tag_array[5]=     0;            tag_array[21] =   0;        tag_array[13] =   0;            tag_array[29] =   0;            
            tag_array[6]=     0;            tag_array[22] =   0;        tag_array[14] =   0;            tag_array[30] =   0;            
            tag_array[7]=     0;            tag_array[23] =   0;        tag_array[15] =   0;            tag_array[31] =   0;   
            
            miss = 0;
        end
        else begin
        
        end
    end
     reg [31:0] save_alu1,save_alu2,write_data1;
     
    always@(posedge clk) begin
       if (reset == 1) begin
            save_alu1 <= 0;
            save_alu2 <= 0;
            write_data1 <= 0;
       end
       else begin
            save_alu1 <= alu_result;
            save_alu2 <= save_alu1;
            write_data1 <= write_data;
       end
       
       if (save_to_cache) begin
            mem[save_alu1[6:2]] = write_data1 +10;
            tag_array[save_alu1[6:2]][24:0] = {save_alu1[31:7]};
            tag_array[save_alu1[6:2]][28:25] = 4'b1111;
       end
    end
     
    always@(*) begin
    if (save_to_cache == 1) begin        
        miss=0;
    end
    
    else begin
    case(mem_write)
            0: begin //yaz
                read_data = alu_result;
                miss= 0;
            end
            1: begin //tamamını yaz
                mem[alu_result[6:2]] = write_data;
                tag_array[alu_result[6:2]][24:0] = {alu_result[31:7]};
                tag_array[alu_result[6:2]][28:25] = 4'b1111;
            end
            2: begin //yarısını yaz
                case(alu_result[1:0])
                    2'b00: begin
                            mem[alu_result[6:2]][15:0] = {write_data[15:0]};
                            tag_array[alu_result[6:2]][24:0] = {alu_result[31:7]};
                            tag_array[alu_result[6:2]][26:25] = 2'b11;
                           end
                    2'b10: begin
                            mem[alu_result[6:2]][31:16] = {write_data[15:0]};
                            tag_array[alu_result[6:2]][24:0] = {alu_result[31:7]};
                            tag_array[alu_result[6:2]][28:27] = 2'b11;
                           end
                endcase
            end
            3: begin //çeyreğini yaz
                case (alu_result[1:0])
                    2'b00: begin
                            mem[alu_result[6:2]][7:0] = {write_data[7:0]};
                            tag_array[alu_result[6:2]][24:0] = {alu_result[31:7]};
                            tag_array[alu_result[6:2]][25] = 1'b1;
                           end
                    2'b01: begin
                            mem[alu_result[6:2]][15:8] = {write_data[7:0]};
                            tag_array[alu_result[6:2]][24:0] = {alu_result[31:7]};
                            tag_array[alu_result[6:2]][26] = 1'b1;
                           end
                    2'b10: begin
                            mem[alu_result[6:2]][23:16] = {write_data[7:0]};
                            tag_array[alu_result[6:2]][24:0] = {alu_result[31:7]};
                            tag_array[alu_result[6:2]][27] = 1'b1;
                           end
                    2'b11: begin
                            mem[alu_result[6:2]][31:24] = {write_data[7:0]};
                            tag_array[alu_result[6:2]][24:0] = {alu_result[31:7]};
                            tag_array[alu_result[6:2]][28] = 1'b1;
                           end
                endcase
            end
            4: begin //load word
                if (tag_array[alu_result[6:2]][28:25] == 4'b1111 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                    read_data =  mem[alu_result[6:2]][31:0];
                    miss = 0;
                end
                else begin // miss
                    miss = 1;
                end 
            end
            5: begin // load half signed
                case(alu_result[1:0])
                    2'b00: begin
                            if (tag_array[alu_result[6:2]][26:25] == 2'b11 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{16{1'b1}},mem[alu_result[6:2]][15:0]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end 
                           end
                    2'b10: begin
                            if (tag_array[alu_result[6:2]][28:27] == 2'b11 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{16{1'b1}},mem[alu_result[6:2]][31:16]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end 
                           end
                endcase
            end
            6: begin // load byte signed
                case(alu_result[1:0])
                    2'b00: begin
                            if (tag_array[alu_result[6:2]][25] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b1}},mem[alu_result[6:2]][7:0]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                    2'b01: begin
                            if (tag_array[alu_result[6:2]][26] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b1}},mem[alu_result[6:2]][15:8]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                    2'b10: begin
                            if (tag_array[alu_result[6:2]][27] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b1}},mem[alu_result[6:2]][23:16]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                    2'b11: begin
                            if (tag_array[alu_result[6:2]][28] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b1}},mem[alu_result[6:2]][31:24]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                endcase
            end
            7: begin // load byte unsigned
                case(alu_result[1:0])
                    2'b00: begin
                            if (tag_array[alu_result[6:2]][25] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b0}},mem[alu_result[6:2]][7:0]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                    2'b01: begin
                            if (tag_array[alu_result[6:2]][26] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b0}},mem[alu_result[6:2]][15:8]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                    2'b10: begin
                            if (tag_array[alu_result[6:2]][27] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b0}},mem[alu_result[6:2]][23:16]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                    2'b11: begin
                            if (tag_array[alu_result[6:2]][28] == 1'b1 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{24{1'b0}},mem[alu_result[6:2]][31:24]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end
                           end
                endcase
            end
            8: begin // load half unsigned
                case(alu_result[1:0])
                    2'b00: begin
                            if (tag_array[alu_result[6:2]][26:25] == 2'b11 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{16{1'b0}},mem[alu_result[6:2]][15:0]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end 
                           end
                    2'b10: begin
                            if (tag_array[alu_result[6:2]][28:27] == 2'b11 & tag_array[alu_result[6:2]][24:0] == {alu_result[31:7]})begin // hit
                                read_data = {{16{1'b0}},mem[alu_result[6:2]][31:16]};
                                miss = 0;
                            end
                            else begin // miss
                                miss = 1;
                            end 
                           end
                endcase
            end
        endcase
        end
    end
    
//    always@(*) begin
//    case(mem_write)
//            0: begin //yaz
//                read_data = alu_result;
//            end
//            1: begin //tamamını yaz
//                case(alu_result[1:0])
//                    2'b00: begin
//                            mem[alu_result[6:2]] = write_data;
//                            tag_array[alu_result[6:2]] = {1'b1,alu_result[31:7]};
//                           end
//                    2'b01: begin
//                            mem[alu_result[6:2]][31:8] = write_data [23:0];
//                            mem[alu_result[6:2]+1][7:0] = write_data[31:24];
//                           end
//                    2'b10: begin
//                            mem[alu_result[6:2]][31:16] = write_data[15:0];
//                            mem[alu_result[6:2]+1][15:0] = write_data[31:16];
//                           end
//                    2'b11: begin
//                            mem[alu_result[6:2]][31:24] = write_data[7:0];
//                            mem[alu_result[6:2]+1][23:0] = write_data[13:8];
//                           end
//                endcase
//            end
//            2: begin //yarısını yaz
//                case(alu_result[1:0])
//                    2'b00: begin
//                            mem[alu_result[6:2]][15:0] = {write_data[15:0]};
//                           end
//                    2'b01: begin 
//                            mem[alu_result[6:2]][23:8] = {write_data[15:0]};
//                           end
//                    2'b10: begin
//                            mem[alu_result[6:2]][31:16] = {write_data[15:0]};
//                           end
//                    2'b11: begin
//                           mem[alu_result[6:2]+1][7:0] = {write_data[15:8]};
//                           mem[alu_result[6:2]][31:16] = {write_data[7:0]};
//                           end
//                endcase
//            end
//            3: begin //çeyreğini yaz
//                case (alu_result[1:0])
//                    2'b00: begin
//                            mem[alu_result[6:2]][7:0] = {write_data[7:0]};
//                           end
//                    2'b01: begin
//                            mem[alu_result[6:2]][15:8] = {write_data[7:0]};
//                           end
//                    2'b10: begin
//                            mem[alu_result[6:2]][23:16] = {write_data[7:0]};
//                           end
//                    2'b11: begin
//                            mem[alu_result[6:2]][31:24] = {write_data[7:0]};
//                           end
//                endcase
//            end
//            4: begin //load word
//                case(alu_result[1:0])
//                    2'b00:begin
//                            read_data =  mem[alu_result[6:2]][31:0];
//                          end
//                    2'b01: begin
//                            read_data = {mem[alu_result[6:2]+1][7:0],mem[alu_result[6:2]][31:8]};
//                           end
//                    2'b10: begin
//                            read_data = {mem[alu_result[6:2]+1][15:0],mem[alu_result[6:2]][31:16]};
//                           end
//                    2'b11: begin
//                            read_data = {mem[alu_result[6:2]+1][23:0],mem[alu_result[6:2]][31:24]};
//                           end
//                endcase
//            end
//            5: begin // load half signed
//                case(alu_result[1:0])
//                    2'b00: begin
//                            read_data = {{16{1'b1}},mem[alu_result[6:2]][15:0]};
//                           end
//                    2'b01: begin
//                            read_data = {{16{1'b1}},mem[alu_result[6:2]][23:8]};
//                           end
//                    2'b10: begin
//                            read_data = {{16{1'b1}},mem[alu_result[6:2]][31:16]};
//                           end
//                    2'b11: begin
//                            read_data = {{16{1'b1}},mem[alu_result[6:2]+1][7:0],mem[alu_result[6:2]][31:24]};
//                           end
//                endcase
//            end
//            6: begin // load byte signed
//                case(alu_result[1:0])
//                    2'b00: begin
//                            read_data = {{24{1'b1}},mem[alu_result[6:2]][7:0]};
//                           end
//                    2'b01: begin
//                            read_data = {{24{1'b1}},mem[alu_result[6:2]][15:8]};
//                           end
//                    2'b10: begin
//                            read_data = {{24{1'b1}},mem[alu_result[6:2]][23:16]};
//                           end
//                    2'b11: begin
//                            read_data = {{24{1'b1}},mem[alu_result[6:2]][31:24]};
//                           end
//                endcase
//            end
//            7: begin // load byte unsigned
//                case(alu_result[1:0])
//                    2'b00: begin
//                            read_data = {{24{1'b0}},mem[alu_result[6:2]][7:0]};
//                           end
//                    2'b01: begin
//                            read_data = {{24{1'b0}},mem[alu_result[6:2]][15:8]};
//                           end
//                    2'b10: begin
//                            read_data = {{24{1'b0}},mem[alu_result[6:2]][23:16]};
//                           end
//                    2'b11: begin
//                            read_data = {{24{1'b0}},mem[alu_result[6:2]][31:24]};
//                           end
//                endcase
//            end
//            8: begin // load half unsigned
//                case(alu_result[1:0])
//                    2'b00: begin
//                            read_data = {{16{1'b0}},mem[alu_result[6:2]][15:0]};
//                           end
//                    2'b01: begin
//                            read_data = {{16{1'b0}},mem[alu_result[6:2]][23:8]};
//                           end
//                    2'b10: begin
//                            read_data = {{16{1'b0}},mem[alu_result[6:2]][31:16]};
//                           end
//                    2'b11: begin
//                            read_data = {{16{1'b0}},mem[alu_result[6:2]+1][7:0],mem[alu_result[6:2]][31:24]};
//                           end
//                endcase
//            end
//        endcase
//    end
endmodule
