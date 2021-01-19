class packet extends uvm_sequence_item;

 	rand bit rd_wr;

	rand bit [7:0] wr_data;
	rand bit reset;
   	rand bit [7:0] addr;

	bit [7:0] rd_data;

	
	`uvm_object_utils_begin(packet)
	`uvm_field_int(rd_wr, UVM_DEFAULT)
	`uvm_field_int(wr_data, UVM_DEFAULT)
	`uvm_field_int(reset, UVM_DEFAULT)
	`uvm_field_int(addr, UVM_DEFAULT)
	`uvm_field_int(rd_data, UVM_DEFAULT)
	`uvm_object_utils_end

	function new(string name = "packet");
		super.new(name);
	endfunction
	
 endclass