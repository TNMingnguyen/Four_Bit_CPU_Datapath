`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Name: Than Nguyen Minh Nguyen
// Roll No: SE204340
// Module Name: alu
// Description: ALU with 7 operations
//              alu_ctrl: 0=ADD 1=SUB 2=AND 3=OR 4=XOR 5=NOT 6=PASS
//////////////////////////////////////////////////////////////////////////////////

// adder / subtractor
module adder_subtractor (
  input  wire [3:0] a,
  input  wire [3:0] b,
  input  wire       do_sub,
  output reg  [3:0] result,
  output reg        carry
);
  reg [4:0] full_sum;

  always @(*) begin
    if (do_sub == 1'b0) begin
      full_sum = a + b;
      result   = full_sum[3:0];
      carry    = full_sum[4];
    end
    else begin
      result = a - b;
      if (a >= b)
        carry = 1'b1;   // no borrow
      else
        carry = 1'b0;   // borrow
    end
  end
endmodule

// logic unit 
module logic_unit (
  input  wire [3:0] a,
  input  wire [3:0] b,
  input  wire [2:0] alu_ctrl,
  output reg  [3:0] result
);
  always @(*) begin
    case (alu_ctrl)
      3'd2: result = a & b;    // AND
      3'd3: result = a | b;    // OR
      3'd4: result = a ^ b;    // XOR
      3'd5: result = ~a;       // NOT
      3'd6: result = b;        // PASS
      default: result = 4'b0000;
    endcase
  end
endmodule

// zero detector
module zero_detector (
  input  wire [3:0] value,
  output wire       zero
);
  assign zero = (value == 4'b0000) ? 1'b1 : 1'b0;
endmodule

// main ALU 
module alu (
  input  wire [3:0] a,
  input  wire [3:0] b,
  input  wire [2:0] alu_ctrl,
  output reg  [3:0] result,
  output reg        carry,
  output wire       zero
);
  wire [3:0] arith_result;
  wire [3:0] logic_result;
  wire       arith_carry;
  wire       do_sub = (alu_ctrl == 3'd1);

  adder_subtractor ADDSUB (
    .a(a), .b(b), .do_sub(do_sub),
    .result(arith_result), .carry(arith_carry)
  );

  logic_unit LOGIC (
    .a(a), .b(b), .alu_ctrl(alu_ctrl),
    .result(logic_result)
  );

  always @(*) begin
    if (alu_ctrl == 3'd0 || alu_ctrl == 3'd1) begin
      result = arith_result;
      carry  = arith_carry;
    end
    else begin
      result = logic_result;
      carry  = 1'b0;
    end
  end

  zero_detector ZERO (.value(result), .zero(zero));
endmodule