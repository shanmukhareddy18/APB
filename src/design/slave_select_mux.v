`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2026 10:23:58 AM
// Design Name: 
// Module Name: slave_select_mux
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


module slave_select_mux(
   PADDR,MST_PSEL,MST_PREADY,MST_PRDATA,SLV_PSEL1,SLV_PREADY1,SLV_PRDATA1,SLV_PSEL2,SLV_PREADY2,SLV_PRDATA2
    );
    input MST_PSEL,SLV_PREADY1,SLV_PREADY2;
    input [7:0]SLV_PRDATA1,SLV_PRDATA2;
    input [8:0] PADDR;
    output wire SLV_PSEL1,SLV_PSEL2;
    output  MST_PREADY;
    output  [7:0]MST_PRDATA;
    
    assign SLV_PSEL1=MST_PSEL && !PADDR[8];
    assign SLV_PSEL2=MST_PSEL && PADDR[8];
    assign MST_PREADY=PADDR[8]? SLV_PREADY2:SLV_PREADY1;
    assign MST_PRDATA=PADDR[8]? SLV_PRDATA2:SLV_PRDATA1;
endmodule
