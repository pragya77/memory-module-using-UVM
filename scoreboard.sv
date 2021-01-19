
 class scoreboard extends uvm_scoreboard;

	packet q[$];
	logic [7:0] ref_item[255:0]; 
    int i = 0;

	uvm_analysis_imp #(packet, scoreboard) item_collected_export;
	
	`uvm_component_utils(scoreboard)

   function new(string name = "scoreboard", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_collected_export = new("item_collected_export", this);
		foreach(ref_item[i]) ref_item[i] = 8'hFF;
	endfunction

	virtual function void write(packet item);
		q.push_back(item);
	endfunction

	virtual task run_phase(uvm_phase phase);		
			
		forever begin
			packet item;
			wait(q.size()>0);
			item = q.pop_front();
			if(item.reset == 0 && item.rd_wr == 1) begin
            			if(ref_item[item.addr] == item.rd_data) begin
					`uvm_info(get_type_name(),$sformatf("-----Read data Match-----"), UVM_LOW)
					`uvm_info(get_type_name(),$sformatf("Addr:%0h",item.addr), UVM_LOW)
					`uvm_info(get_type_name(), $sformatf("Expected data:%0h  Actual Data:%0h",ref_item[item.addr], item.rd_data), UVM_LOW)
					`uvm_info(get_type_name(), "--------------------------------------", UVM_LOW)
				end
            			else begin
					`uvm_error(get_type_name(),$sformatf("-----Read data Mismatch-----"))
					`uvm_info(get_type_name(),$sformatf("Addr:%0h",item.addr), UVM_LOW)
					`uvm_info(get_type_name(), $sformatf("Expected data:%0h  Actual Data:%0h",ref_item[item.addr], item.rd_data), UVM_LOW)
					`uvm_info(get_type_name(), "--------------------------------------", UVM_LOW)
				end
          		end
          		else if(item.reset == 0 && item.rd_wr == 0)begin
            			ref_item[item.addr] = item.wr_data;
				`uvm_info(get_type_name(),$sformatf("Addr:%0h",item.addr), UVM_LOW)
				`uvm_info(get_type_name(), $sformatf("Write data:%0h", item.wr_data), UVM_LOW)
          		end
          		else if (item.reset == 1)begin
                  for(int i=0; i<=5; i++) begin
              				ref_item[i] = 8'hff;
					`uvm_info(get_type_name(), "Reset", UVM_LOW)
                                    					    
            			end
          		end 
		end
	endtask

 endclass