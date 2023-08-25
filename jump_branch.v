`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2023 11:07:11
// Design Name: 
// Module Name: jump_branch
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


module jump_branch(
    input zero,
    input branch,
    input jump,
    input branch_o_delayed,
    output pc_src,
    output pc_src_branch
    );
    assign pc_src = ((zero&branch_o_delayed)|jump);
//    assign pc_src = (branch | jump);
//  assign pc_src_branch = ((zero&branch)|jump) | branch_o_delayed;
    assign pc_src_branch = (branch | jump);
//    assign pc_src_branch = (branch_o_delayed | jump);

endmodule
