
 class monitor extends uvm_monitor;

	packet item;

	virtual intf vif;

	`uvm_component_utils(monitor)

	uvm_analysis_port #(packet) item_collected_port;

   function new(string name="monitor", uvm_component parent = null);
		super.new(name,parent);
		item_collected_port = new("item_collected_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	 	if (!uvm_config_db #(virtual intf)::get(this, get_full_name(),"vif", vif))
      			`uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})	
	endfunction

	task run_phase(uvm_phase phase);
                
          wait(vif.reset1 == 1'b1);
          wait(vif.reset1 == 1'b0);
		forever begin

          item = packet::type_id::create("item",this);
          
          @(negedge vif.clk);
          item.rd_wr = vif.rd_wr1;
        item.wr_data = vif.wr_data1;
        item.rd_data = vif.rd_data1;
		item.reset = vif.reset1;
		item.addr = vif.addr1;
	      item_collected_port.write(item);
		end
	endtask

 endclass