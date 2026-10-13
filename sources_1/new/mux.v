`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2026 06:19:45 PM
// Design Name: 
// Module Name: mux2
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Description: 2-to-1 multiplexer, 4-bit
//              sel = 0 -> y = d0
//              sel = 1 -> y = d1
//////////////////////////////////////////////////////////////////////////////////

module mux2 (
    input  wire [3:0] d0,
    input  wire [3:0] d1,
    input  wire       sel,
    output wire [3:0] y
);
    assign y = sel ? d1 : d0;
endmodule
