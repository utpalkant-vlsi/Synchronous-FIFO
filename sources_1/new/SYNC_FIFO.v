`timescale 1ns / 1ps
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institue of Technology, Patna.
// Engineer: Utpal Kant
// 
// Create Date: 03.04.2026 14:49:10
// Design Name: Synchronous FIFO
// Module Name: SYNC_FIFO
// Project Name: Synchronous_FIFO_Design
// Target Devices: Basys3 FPGA
// Tool Versions:Vivado 2024.2 
// Description: Testbench to verify the functionality of a parameterized 
//              Synchronous FIFO, testing sequential read/write, overflow, 
//              and underflow conditions.
// 
// Dependencies: SYNC_FIFO.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SYNC_FIFO #(
parameter DATA_WIDTH = 32,// PARAMETER DECLARATION
parameter FIFO_DEPTH = 8) // PARAMETER DECLARATION
//parameter POINTER_WIDTH = 3)  // PARAMETER DECLARATION

(input clk,rst_n,write_enable,read_enable,                // INPUT-OUTPUT DECLARATION
input [DATA_WIDTH-1:0] write_data,              // DATA TO WRITE
output reg [DATA_WIDTH-1:0] read_data,         // DATA TO READ
output FULL,EMPTY);

localparam FIFO_DEPTH_LOG = $clog2(FIFO_DEPTH);
reg[DATA_WIDTH-1:0]mem[0:FIFO_DEPTH-1];  //8 LOCATION EACH 32 BITS WIDE

reg [FIFO_DEPTH_LOG:0] write_pointer;   //POINTS TO NEXT WRITE LOCATION
reg [FIFO_DEPTH_LOG:0] read_pointer;   //POINTS TO NEXT READ LOACTION
//reg [POINTER_WIDTH-1:0] count;    //PTR_WIDTH+1 BITS TO COUNT 0 TO 8

assign  FULL = (read_pointer=={~write_pointer[FIFO_DEPTH_LOG],write_pointer[FIFO_DEPTH_LOG-1:0]} );  
assign EMPTY = (read_pointer == write_pointer);

always@(posedge clk or negedge rst_n) begin
        if(!rst_n)
              write_pointer <= 0;
        else if (write_enable && !FULL) 
              write_pointer <= write_pointer + 1'b1;
end

always@(posedge clk or negedge rst_n)begin
       if(!rst_n)
             read_pointer <= 0;
       else if (read_enable && !EMPTY)
              read_pointer<= read_pointer +1;
end

always@(posedge clk)begin
        if(write_enable && ~FULL )
           mem[write_pointer[FIFO_DEPTH_LOG-1:0]] <= write_data;
 end
 
 always@(posedge clk or negedge rst_n) begin
        if(!rst_n)
           read_data <= 0;
        else if (read_enable && !EMPTY)
           read_data <= mem[read_pointer [FIFO_DEPTH_LOG-1:0]];
 end
endmodule
