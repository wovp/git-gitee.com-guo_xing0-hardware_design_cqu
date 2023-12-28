`timescale 1ns / 1ps
`include "defines2.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:27:24
// Design Name: 
// Module Name: aludec
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


module aludec(
	input wire[5:0] funct,
	input wire[5:0] opD,
	output reg[4:0] alucontrol
    );
	always @(*) begin
		case (opD)
			`R_TYPE: case (funct)
			     `AND : alucontrol <= `AND_CONTROL;
			     `OR : alucontrol <= `OR_CONTROL;
			     `XOR : alucontrol <= `XOR_CONTROL;
			     `NOR : alucontrol <= `NOR_CONTROL;
			default  alucontrol <= 5'b00000;
			endcase
			`ANDI: alucontrol <= `AND_CONTROL;
			`XORI: alucontrol <= `XOR_CONTROL;
			`LUI: alucontrol <= `LUI_CONTROL;
			`ORI: alucontrol <= `OR_CONTROL;
			default : alucontrol <= 5'b00000;
		endcase
	end
endmodule
