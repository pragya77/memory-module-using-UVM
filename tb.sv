// Code your testbench here
// or browse Examples


	import uvm_pkg::*;
  	`include "uvm_macros.svh"

	`include "packet.sv"
	`include "sequence1.sv"
	`include "sequencer.sv"
	`include "driver.sv"
	`include "monitor.sv"
	`include "scoreboard.sv"
	`include "agent.sv"
	`include "env.sv"
	`include "test.sv"


 	`timescale 1ns/100ps 

 module tb;
   
   logic clk = 0;
   logic rst;
   
   intf vif (clk, rst);
   
   memory dut(vif, clk);
   
    always #10 clk = ~clk;

	initial begin
      uvm_config_db #(virtual intf)::set(uvm_root::get(),"*","vif",vif);
      	
      	$dumpfile("dump.vcd");
        $dumpvars;
		
	end

    initial begin
      
      rst = 1;
      #20
      rst = 0;
    end

	initial begin
      run_test("test");
	end

 endmodule
