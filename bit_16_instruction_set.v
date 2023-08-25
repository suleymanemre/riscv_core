`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2023 14:12:16
// Design Name: 
// Module Name: bit_16_instruction_set
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


module bit_16_instruction_set(

    );
    reg [15:0] mem [511:0];
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
    
    initial begin
        // CIW        func      imm          rd'          op
        mem [ 0] = {{3'b000},{8'b00000000},{3'b000},{op00}}; //c.addi4spn
        
        // CL         func      imm      rs1'   imm      rd'     op
        mem [ 8] = {{3'b010},{3'b000},{3'b000},{2'b00},{3'b000},{op00}}; //c.lw
        
        // CS         func      imm      rs1'   imm      rs2'     op
        mem [20] = {{3'b110},{3'b000},{3'b000},{2'b00},{3'b000},{op00}}; //c.sw
        
        // CI         func    imm     rs1/rd        imm       op
        mem [28] = {{3'b000},{1'b0},{5'b00000},{5'b00000},{op01}}; //c.nop
        mem [32] = {{3'b000},{1'b0},{5'b01000},{5'b00000},{op01}}; //c.addi rd imm
        mem [40] = {{3'b010},{1'b0},{5'b00000},{5'b00000},{op01}}; //c.li
        mem [44] = {{3'b011},{1'b0},{5'b00000},{5'b00000},{op01}}; //c.lui
        mem [48] = {{3'b011},{1'b0},{5'b00000},{5'b00000},{op01}}; //c.addi16sp
        
        mem [92] = {{3'b000},{1'b0},{5'b00000},{5'b00000},{op10}}; //c.slli
        mem [96] = {{3'b010},{1'b0},{5'b00000},{5'b00000},{op10}}; //c.lwsp
        
        //CJ          func         imm           op
        mem [36] = {{3'b001},{11'b00000000000},{op01}}; //c.jal label
        mem [80] = {{3'b101},{11'b00000000000},{op01}}; //c.j label
        
        //CB'         func    imm    func    rd'/rs1'    imm     op
        mem [52] = {{3'b100},{1'b0},{2'b00},{3'b000},{5'b00000},{op01}}; //c.srli
        mem [56] = {{3'b100},{1'b0},{2'b01},{3'b000},{5'b00000},{op01}}; //c.srai
        mem [60] = {{3'b100},{1'b0},{2'b10},{3'b000},{5'b00000},{op01}}; //c.andi
        
        //CS'         funct6    rd'/rs1'  funct2   rs2'     op                                              
        mem [64] = {{6'b000000},{3'b000},{2'b00},{3'b000},{op01}}; //c.sub
        mem [68] = {{6'b000001},{3'b000},{2'b01},{3'b000},{op01}}; //c.xor
        mem [72] = {{6'b000010},{3'b000},{2'b10},{3'b000},{op01}}; //c.or
        mem [76] = {{6'b000011},{3'b000},{2'b11},{3'b000},{op01}}; //c.and
        
        //CB          func     imm      rs1'      imm       op
        mem [84] = {{3'b110},{3'b000},{3'b000},{5'b00000},{op01}}; //c.beqz
        mem [88] = {{3'b111},{3'b000},{3'b000},{5'b00000},{op01}}; //c.bnez
        
        //CR          func4     rd/rs1       rs2      op
        mem[100] = {{4'b1000},{5'b00000},{5'b00000},{op10}}; //c.jr rs1!=0 rs2==0
        mem[104] = {{4'b1000},{5'b00000},{5'b00000},{op10}}; //c.mv rs1!=0 rs2!=0
        mem[108] = {{4'b1001},{5'b00000},{5'b00000},{op10}}; //c.jalr rs1!=0 rs2==0
        mem[112] = {{4'b1001},{5'b00000},{5'b00000},{op10}}; //c.add rs1!=0 rs2!=0
        
        //CSS          func3    imm          rs2      op
        mem[116] = {{3'b110},{6'b000000},{5'b00000},{op10}}; //c.swsp
    end
    
endmodule
