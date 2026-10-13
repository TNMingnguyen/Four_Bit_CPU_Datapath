`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: program_counter
// Description: 4-bit Program Counter (PC)
//              The PC keeps the address of the instruction being fetched.
//              After reset: PC = 0
//              Every clock with pc_en = 1: PC loads the next address
//////////////////////////////////////////////////////////////////////////////////

module program_counter (
    input  wire       clk,
    input  wire       rst,
    input  wire       pc_en,
    input  wire [3:0] pc_next,
    output reg  [3:0] pc_out
);
    always @(posedge clk) begin
        if (rst)
            pc_out <= 4'd0;
        else if (pc_en)
            pc_out <= pc_next;
    end
endmodule