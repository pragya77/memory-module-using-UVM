
 class test extends uvm_test;

	`uvm_component_utils(test)

	sequence1 i_seq;
	env i_env;

   function new(string name = "test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
      uvm_config_db #(uvm_bitstream_t) :: set (this, "i_env.i_agent.i_monitor", "enable_coverage", 1);
      
		super.build_phase(phase);
		i_seq = sequence1::type_id::create("i_seq");
		i_env = env::type_id::create("i_env", this);
	endfunction	

	task run_phase(uvm_phase phase);
      super.run_phase(phase);
      
		phase.raise_objection(this);
        fork
          begin
		    i_seq.start(i_env.i_agent.i_sequencer);
          end
          begin
          #20000;
          end
        join_any
		phase.drop_objection(this);

	endtask
   
   virtual function void end_of_elaboration_phase (uvm_phase phase);
		uvm_top.print_topology;
	endfunction  

 endclass
