`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 02:23:40 PM
// Design Name: 
// Module Name: master
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


module master(pclk,presetn,transfer,read_write
            ,apb_write_paddr,apb_write_data,apb_read_paddr,apb_read_data_out,paddr,pwdata,
             pwrite,psel,penable,prdata,pready);
           input pclk,presetn,transfer,read_write,pready;
            input [7:0]apb_write_data,prdata;
            input [8:0] apb_write_paddr,apb_read_paddr;
            output reg [7:0]pwdata,apb_read_data_out;
            output reg [8:0]paddr;
            output reg pwrite,psel,penable;
  parameter IDLE=0,SETUP=1,ACCESS=2;
  reg [1:0]pst,nst;

  always@(posedge pclk or posedge presetn)
  begin
    if(presetn)
       pst<=IDLE;
     else
       pst<=nst;
  end
  
  always@(*)
   begin 
       case(pst)
         IDLE:
           begin
             psel=0;
             penable=0;
             if(transfer)
                nst=SETUP;
             else
               nst=IDLE;
            end
          SETUP:
            begin 
              psel=1;
              penable=0;
              pwrite=read_write;
              nst=ACCESS;
              if(pwrite)
                   begin
                    paddr=apb_write_paddr;
                    pwdata=apb_write_data;
                   end  
               else
                    paddr=apb_read_paddr;
            end
           ACCESS:
             begin
               psel=1;
               penable=1;
               if(pready)
                begin
                  if(!pwrite)
                    apb_read_data_out=prdata;
                  if(transfer)
                   nst=SETUP;
                  else 
                   nst=IDLE;
                 end
                else
                  nst=ACCESS;
              end
           default:nst=IDLE;
         endcase
   end
endmodule
