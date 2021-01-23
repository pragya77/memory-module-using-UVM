
 class monitor extends uvm_monitor;

	packet item;

    real cov;
	virtual intf vif;
    bit enable_coverage;
   
    event cov_transaction;

	`uvm_component_utils_begin(monitor)
   `uvm_field_int(enable_coverage, UVM_ALL_ON);
   `uvm_component_utils_end
   
	uvm_analysis_port #(packet) item_collected_port;

   covergroup cov_trans;
    rw : coverpoint vif.rd_wr1 { bins read = { 1 };
                            bins write = { 0 };
                           }
    rst : coverpoint vif.reset1;
    adr : coverpoint vif.addr1 { bins low = {[0:70]};
                            bins mid = {[71:160]};
                            bins high = {[161:255]};
                         }
    read : coverpoint vif.rd_data1;
    write : coverpoint vif.wr_data1; 
  endgroup
   
   function new(string name="monitor", uvm_component parent = null);
		super.new(name,parent);
     	cov_trans = new ();
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

          @(vif.cb);
          item.rd_wr = vif.cb.rd_wr1;
        item.wr_data = vif.cb.wr_data1;
        item.rd_data = vif.cb.rd_data1;
		item.reset = vif.cb.reset1;
		item.addr = vif.cb.addr1;         
                    
          if (enable_coverage)
				perform_coverage();
          
	      item_collected_port.write(item);
		end
	endtask
      
   virtual protected function void perform_coverage();
     cov_trans.sample();
	endfunction: perform_coverage
     
    function void extract_phase(uvm_phase phase);
      cov = cov_trans.get_coverage();
   endfunction  

   function void report_phase(uvm_phase phase);
     `uvm_info(get_full_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM); 
   endfunction

 endclass
