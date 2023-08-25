`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2023 10:36:45
// Design Name: 
// Module Name: instruction_decoder
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


module instruction_decoder(
    input [31:0] instr,
    input compressed_or_not,
    output reg [31:0] instr_o
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
    
    
    always@(*)begin
        if (compressed_or_not == 0) begin //not compressed
            instr_o = instr;
        end
        else begin //compressed
            instr_o = 1;
            case(instr[1:0])
                2'b00:begin //CIW CL CS
                    case(instr[15:13])
                        3'b000: begin //addi rd' sp(x2)
                            instr_o = {{{2'b00},{instr[12:5]},{2'b00}},{reg02},{3'b000},{{2'b01},{instr[4:2]}},{opi}};
                        end
                        3'b001: begin //fld
                        
                        end
                        3'b010: begin //lw
                            instr_o = {{{5'b00000},{instr[12:10],instr[6:5]},{2'b00}},{{2'b01},{instr[9:7]}},{3'b010},{{2'b01},{instr[4:2]}},{opl}};
                        end
                        3'b011: begin //flw
                        
                        end
                        3'b101: begin //fsd
                        
                        end
                        3'b110: begin //sw
                            instr_o = {{{instr[12:10],instr[6:5]},{2'b00}},{{2'b01},{instr[4:2]}},{{2'b01},{instr[9:7]}},{3'b010},{5'b00000},{ops}};
                        end
                        3'b111: begin //fsw
                        
                        end
                    endcase
                end
                
                2'b01: begin //CI CB' CS' CJ CB
                    case(instr[15:13])
                        3'b000:begin
                            case(instr[12:10])
                                3'b000: begin //nop
                                    instr_o = {{12'b000000000000},{reg00},{3'b000},{reg00},{7'b0000000}};
                                end
                                default: begin //addi rd rd
//                                    instr_o = {{{6'b000000},{instr[12]},{instr[6:2]}},{instr[11:7]},{3'b000},{instr[11:7]},{opi}};
                                    instr_o = {{{6{instr[12]}},{instr[12]},{instr[6:2]}},{instr[11:7]},{3'b000},{instr[11:7]},{opi}};
                                end    
                            endcase 
                        end
                        3'b001:begin //jal
//                            instr_o = {{8'b00000000},{instr[12:2],{1'b0}},{reg01},{jal}};
                            instr_o = {{{instr[12]},{instr[12:2]}},{8{instr[12]}},{reg01},{jal}};

//                            instr_o = {{9'b000000000},{instr[12:2]},{reg01},{jal}};
                        end
                        3'b010:begin //addi rd x0
//                            instr_o = {{{6'b000000},{instr[12]},{instr[6:2]}},{instr[11:7]},{3'b000},{reg00},{opi}};
//                            instr_o = {{{6'b000000},{instr[12]},{instr[6:2]}},{instr[11:7]},{3'b000},{instr[11:7]},{opi}};
                            instr_o = {{{7{instr[12]}},{instr[6:2]}},{reg00},{3'b000},{instr[11:7]},{opi}}; // 1861 için değişti
                        end
                        3'b011:begin //lui   //addi sp sp
//                            case(instr[12])
//                                0: begin //lui
//                                    instr_o = {{{14{instr[12]}},{instr[12]},{instr[6:2]}},{instr[11:7]},{lui}};
//                                end
//                                1: begin //addi sp sp
                                    instr_o = {{{2'b00},{instr[12]},{instr[6:2]},{4'b0000}},{reg02},{3'b000},{reg02},{opi}};
//                                end
//                            endcase
                        end
                        3'b100:begin //srli srai andi
                            case(instr[11:10])
                                2'b00: begin //srli
                                    instr_o = {{6'b000000},{{instr[12]},{instr[6:2]}},{{2'b01},{instr[9:7]}},{3'b101},{{2'b01},{instr[9:7]}},{opi}};
                                end
                                2'b01: begin //srai
                                    instr_o = {{6'b010000},{{instr[12]},{instr[6:2]}},{{2'b01},{instr[9:7]}},{3'b101},{{2'b01},{instr[9:7]}},{opi}};
                                end
                                2'b01: begin //andi
                                    instr_o = {{6'b000000},{{instr[12]},{instr[6:2]}},{{2'b01},{instr[9:7]}},{3'b111},{{2'b01},{instr[9:7]}},{opi}};
                                end
                                2'b11: begin //sub xor or and
                                    case(instr[6:5])
                                        2'b00: begin //sub
                                            instr_o = {{7'b0100000},{{2'b01},{instr[4:2]}},{{2'b01},{instr[9:7]}},{3'b000},{{2'b01},{instr[9:7]}},{opz}};
                                        end                                         
                                        2'b01: begin //xor                          
                                            instr_o = {{7'b0000000},{{2'b01},{instr[4:2]}},{{2'b01},{instr[9:7]}},{3'b100},{{2'b01},{instr[9:7]}},{opz}};
                                        end                                         
                                        2'b10: begin //or                           
                                            instr_o = {{7'b0000000},{{2'b01},{instr[4:2]}},{{2'b01},{instr[9:7]}},{3'b110},{{2'b01},{instr[9:7]}},{opz}};
                                        end                                         
                                        2'b11: begin //and                          
                                            instr_o = {{7'b0000000},{{2'b01},{instr[4:2]}},{{2'b01},{instr[9:7]}},{3'b111},{{2'b01},{instr[9:7]}},{opz}}; 
                                        end
                                    endcase 
                                end
                           endcase
                        end
                        3'b101:begin //jal x0 label (text indicating instruction address) // pc  =label
//                            instr_o = {{8'b00000000},{instr[12:2],{1'b0}},{reg00},{jal}};
//                            instr_o = {{8{instr[12]}},{instr[12:2],{1'b0}},{reg00},{jal}};
//                            instr_o = {{9{instr[12]}},{instr[12:2]},{reg00},{jal}};
                            
                            instr_o = {{{instr[12]},{instr[12:2]}},{8{instr[12]}},{reg00},{jal}};
                        end
                        3'b110:begin //beq
                            instr_o = {{1'b0},{instr[6:2],{1'b0}},{{2'b01},{instr[9:7]}},{reg00},{3'b000},{{2'b01},{instr[12:10]}},{opb}};
                        end
                        3'b111:begin //bne
                            instr_o = {{1'b0},{instr[6:2],{1'b0}},{{2'b01},{instr[9:7]}},{reg00},{3'b001},{{2'b01},{instr[12:10]}},{opb}};
                        end
                    endcase
                end
                
                2'b10: begin
                    case(instr[15:13])
                        3'b000: begin //slli
                            instr_o = {{6'b000000},{{instr[12]},{instr[6:2]}},{instr[11:7]},{3'b001},{instr[11:7]},{opi}};
                        end
                        3'b001: begin //fldsp
                            
                        end
                        3'b010: begin //lwsp
                            instr_o = {{4'b0000},{{instr[12]},{instr[6:2],{2'b00}}},{reg02},{3'b010},{instr[11:7]},{7'b0000011}};
                        end
                        3'b011: begin //flwsp
                        
                        end
                        3'b100: begin //jr mv ebreak jalr add 
                            case(instr[12])
                                0: begin
                                    if (instr[11:7] != 0 & instr[6:2] == 0) begin //jalr x0 rs1 0
                                        instr_o = {{12'b000000000000},{instr[11:7]},{3'b000},{reg00},{jlr}};
                                    end
                                    else if(instr[11:7] != 0 & instr[6:2] != 0)begin //add rd x0 rs2
                                        instr_o = {{7'b0000000},{instr[6:2]},{reg00},{3'b000},{{2'b01},{instr[9:7]}},{opz}};
                                    end
                                end
                                1: begin
                                    if (instr[11:7] == 0 & instr[6:2] == 0) begin //ebreak
                                    
                                    end
                                    else if(instr[11:7] != 0 & instr[6:2] == 0)begin //jalr ra rs1 0
                                        instr_o = {{12'b000000000000},{instr[11:7]},{3'b000},{reg01},{jlr}};
                                    end
                                    else if(instr[11:7] != 0 & instr[6:2] != 0)begin // add rd rd rs2
//                                        instr_o = {{7'b0000000},{instr[6:2]},{instr[6:2]},{3'b000},{{instr[11:7]}},{opz}};
                                        instr_o = {{7'b0000000},{instr[6:2]},{instr[11:7]},{3'b000},{{instr[11:7]}},{opz}};
                                    end
                                end
                            endcase
                        end
                        3'b101: begin //fsdsp
                        
                        end
                        3'b110: begin //swsp
                            instr_o = {{{4'b0000},{instr[12:7]},{2'b00}},{reg02},{3'b010},{instr[6:2]},{ops}};
                        end
                        3'b111: begin //fswsp
                        
                        end
                    endcase
                end
            endcase
        end
    end
endmodule
