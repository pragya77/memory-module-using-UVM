
 class agent extends uvm_agent;

	monitor i_monitor;
	sequencer i_sequencer;
	driver i_driver;

	`uvm_component_utils_begin(agent)
   `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON);
   `uvm_component_utils_end

   
   function new(string name="agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

        i_monitor = monitor::type_id::create("i_monitor",this);
      if(get_is_active() == UVM_ACTIVE) begin
			i_sequencer= sequencer::type_id::create("i_sequencer",this);		
			i_driver = driver::type_id::create("i_driver",this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
      if(get_is_active() == UVM_ACTIVE)
			i_driver.seq_item_port.connect(i_sequencer.seq_item_export);
	endfunction

 endclass
