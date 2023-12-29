`timescale 1ns / 1ps
`include "defines2.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 14:52:16
// Design Name: 
// Module Name: alu
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


module alu(
	input wire[31:0] a,b,
	input wire [4:0] sa,
	input wire[4:0] op,
	output reg[31:0] y,
	output reg overflow,
	output wire zero
    );

	wire[31:0] s,bout;
	assign bout = op[2] ? ~b : b;
	assign s = a + bout + op[2];
	always @(*) begin
		case (op)
			`AND_CONTROL: y <= a & b;
			`OR_CONTROL: y <= a | b;
			`XOR_CONTROL: y <= a ^ b;
			`NOR_CONTROL: y <= ~(a | b);
			`LUI_CONTROL: y <= { b[15:0],16'b0 };
			`SLL_CONTROL: y <= b << sa;
			`SLLV_CONTROL: y <= b << a[4:0];
			`SRL_CONTROL: y <= b >> sa;
			`SRLV_CONTROL: y <= b >> a[4:0];
			`SRA_CONTROL: y <= ({32{b[31]}} << (6'd32 -{1'b0,sa})) | b >> sa;
			`SRAV_CONTROL: y <= ({32{b[31]}} << (6'd32 -{1'b0,a[4:0]})) | b >> a[4:0];
			default : y <= 32'b0;
		endcase	
	end
	assign zero = (y == 32'b0);

	always @(*) begin
		case (op[2:1])
			2'b01:overflow <= a[31] & b[31] & ~s[31] |
							~a[31] & ~b[31] & s[31];
			2'b11:overflow <= ~a[31] & b[31] & s[31] |
							a[31] & ~b[31] & ~s[31];
			default : overflow <= 1'b0;
		endcase	
	end
endmodule
