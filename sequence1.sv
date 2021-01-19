
 class sequence1 extends uvm_sequence #(packet);

	packet item;

   `uvm_object_utils(sequence1)

   function new(string name = "sequence1");
		super.new(name);
	endfunction	

	virtual task body();
		`uvm_info(get_type_name(), "Executing sequence", UVM_LOW)	
                   
      for (int i=0; i<=5;i++)begin
          `uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
        `uvm_do_with(item, {item.rd_wr == 1; item.addr == i;})
		end
                       
      for (int i=0; i<=5;i++)begin
          `uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
          `uvm_do_with(item, {item.rd_wr ==0; item.wr_data == addr; item.addr == i;})
		end
                         
      for (int i=0; i<=5;i++)begin
          `uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
          `uvm_do_with(item, {item.reset == 0; item.rd_wr ==1; item.addr == i;})
		end
        #20;
     
        

	endtask                   

 endclass