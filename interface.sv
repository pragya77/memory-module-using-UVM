
interface intf();

	timeunit 1ns;
	timeprecision 100ps;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	logic rd_wr;
	logic [7:0] wr_data;
	logic [7:0] rd_data;
	logic reset;
   	logic [7:0] addr;

 	logic tb_clk;
	initial tb_clk =0;
	always #10 tb_clk = ~tb_clk;
 endinterface

