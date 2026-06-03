`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 03:53:05 PM
// Design Name: 
// Module Name: slave
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


module slave(pwrite,psel,penable,paddr,
          pwdata,pready,prdata,SLV_ERR);
    input pwrite,psel,penable;
    input [7:0]pwdata;
    input [8:0]paddr;
    output reg pready;
    output reg[7:0]prdata;
    output SLV_ERR;
    assign  SLV_ERR=(paddr>6'b111111) ? 1:0;
    reg [7:0]ram[8:0];
    always@(*)
    begin
      if(psel && penable )
            begin
            pready =1;
              if(pwrite && !SLV_ERR)
                  ram[paddr]=pwdata;
              else if(!pwrite && !SLV_ERR)
                 prdata= ram[paddr]; 
            end
    end
endmodule
