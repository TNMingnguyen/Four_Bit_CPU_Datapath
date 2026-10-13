`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: flag_register
// Description: Saves the Zero and Carry flags
//              zero  : last ALU result was 0000
//              carry : carry-out from ADD, or no-borrow from SUB
//              Each flag has its own write enable.
//////////////////////////////////////////////////////////////////////////////////

module flag_register (
    input  wire clk,        
    input  wire rst,        
    input  wire zero_we,    // 1 = save new zero flag
    input  wire carry_we,   // 1 = save new carry flag
    input  wire zero_in,    // new zero value from ALU
    input  wire carry_in,   // new carry value from ALU
    output reg  zero_flag,  // saved zero flag
    output reg  carry_flag  // saved carry flag
);
    always @(posedge clk) begin
        // step 1: reset
        if (rst == 1'b1) begin
            zero_flag  <= 1'b0;
            carry_flag <= 1'b0;
        end
        // step 2: normal operation
        else begin
            // update zero if enabled
            if (zero_we == 1'b1)
                zero_flag <= zero_in;
            // update carry if enabled
            if (carry_we == 1'b1)
                carry_flag <= carry_in;
        end
    end
endmodule