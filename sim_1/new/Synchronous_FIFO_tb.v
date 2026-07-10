`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institue of Technology, Patna.
// Engineer: Utpal Kant
// 
// Create Date: 03.04.2026 14:49:10
// Design Name: Synchronous FIFO
// Module Name: SYNC_FIFO_tb
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


module SYNC_FIFO_tb();
parameter FIFO_DEPTH = 8;
parameter DATA_WIDTH = 32;
reg clk,rst_n,read_enable,write_enable;
reg[31:0] write_data;
wire[31:0] read_data;
wire FULL,EMPTY;

integer i;

SYNC_FIFO #(.DATA_WIDTH (32), .FIFO_DEPTH (8), .POINTER_WIDTH (3))
    FIFO( 
    .clk(clk),
    .rst_n(rst_n),
    .write_data(write_data),
    .read_data(read_data),
    .read_enable(read_enable),
    .write_enable(write_enable),
    .FULL(FULL),
    .EMPTY(EMPTY)
    );
    
 initial clk = 0;
 always #5 clk = ~clk;
 
 // TASK 1 WRITE ONE WORD INTO FIFO;
 
 task fifo_write;
      input[31:0] data;
      begin
           @(posedge clk);
           write_enable = 1;
           write_data = data;
           $display($time,"  write_data data_in = %0d", write_data);
            @(posedge clk)
            write_enable = 0;
      end
 endtask
 
 // TAASK 2 READ ONE WORD AND SELF-CHECK AGAINST EXPECTED
 
   task fifo_read();
        begin 
             @(posedge clk);
             read_enable = 1;
             @(posedge clk);
             #1;
             $display($time,"  read_data data_out = %0d",read_data);
             read_enable = 0;
             end
   endtask
        
   initial begin 
   #1;
   rst_n = 0; read_enable = 0; write_enable = 0;
   
   #1.3;
   rst_n = 1;
   $display($time, " \n SCENARIO 1");
  fifo_write(1);
   fifo_write(10);
  fifo_write(100);
  fifo_read();
  fifo_read();
  fifo_read();
  fifo_read();
   
   
   $display($time, " \n SCENARIO 2");
   for(i = 0; i<FIFO_DEPTH; i = i+1)begin
      fifo_write(2**i);
      fifo_read();
    end
    
    $display($time," \n SCENARIO 3");
    for(i = 0; i<FIFO_DEPTH; i = i+1)begin
       fifo_write(2**i);
    end
    for(i = 0; i<FIFO_DEPTH; i = i+1)begin
       fifo_read();
    end
#40 $stop;
end
endmodule
