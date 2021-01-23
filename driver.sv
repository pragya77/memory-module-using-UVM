
 class driver extends uvm_driver #(packet);

	packet item;

	virtual intf vif;

	`uvm_component_utils(driver)

   function new(string name = "driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual intf)::get(this,"","vif",vif)) 
			`uvm_error("NOVIF", {"virtual interface must be set for:", get_full_name(), ".vif"})	
	endfunction

	task run_phase(uvm_phase phase);
       wait(vif.reset1 == 1'b1);
          wait(vif.reset1 == 1'b0);
      
        forever begin

		  seq_item_port.get_next_item(item);
          @(posedge vif.clk);
          vif.rd_wr1 = item.rd_wr;
          if(item.rd_wr == 0)vif.wr_data1 = item.wr_data;
		  vif.addr1 = item.addr;
		  seq_item_port.item_done();
        end
	endtask

	
 endclass
