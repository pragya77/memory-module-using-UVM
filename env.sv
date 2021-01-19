
 class env extends uvm_env;

	scoreboard i_scoreboard;
	agent i_agent;

	`uvm_component_utils(env)

   function new(string name="env", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		i_agent = agent::type_id::create("i_agent",this);
		i_scoreboard = scoreboard::type_id::create("i_scoreboard",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		i_agent.i_monitor.item_collected_port.connect(i_scoreboard.item_collected_export);
	endfunction

 endclass