`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 04:01:11 PM
// Design Name: 
// Module Name: top
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


module top(pclk,presetn,transfer,read_write
            ,apb_write_paddr,apb_write_data,apb_read_paddr,apb_read_data_out,paddr,pwdata,
             pwrite,psel,penable,pready,prdata,SLV_ERR);
            input pclk,presetn,transfer,read_write;
            input [7:0]apb_write_data;
            input [8:0] apb_write_paddr,apb_read_paddr;
            output wire [7:0]pwdata,apb_read_data_out;
            output wire [8:0]paddr;
            output wire pwrite,psel,penable;
            output wire SLV_ERR;
            wire SLV_PSEL1,SLV_PREADY1,SLV_PSEL2,SLV_PREADY2;
            wire [7:0]SLV_PRDATA1,SLV_PRDATA2;
            input wire [7:0]prdata;
            input wire pready;
    master m1(pclk,presetn,transfer,read_write
            ,apb_write_paddr,apb_write_data,apb_read_paddr,apb_read_data_out,paddr,pwdata,
             pwrite,psel,penable,prdata,pready);
    slave_select_mux m2(paddr,psel,pready,prdata,SLV_PSEL1,SLV_PREADY1,SLV_PRDATA1,SLV_PSEL2,SLV_PREADY2,SLV_PRDATA2
    );
    slave s1(pwrite,SLV_PSEL1,penable,paddr,
          pwdata,SLV_PREADY1,SLV_PRDATA1,SLV_ERR);
    slave s2(pwrite,SLV_PSEL2,penable,paddr,
          pwdata,SLV_PREADY2,SLV_PRDATA2,SLV_ERR);
    
    
endmodule
