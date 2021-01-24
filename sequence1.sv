
 class sequence1 extends uvm_sequence #(packet);

	packet item;
    int count = 0;

   `uvm_object_utils(sequence1)

   function new(string name = "sequence1");
		super.new(name);
	endfunction	

	virtual task body();
		`uvm_info(get_type_name(), "Executing sequence", UVM_LOW)	
                   
      for (int i=0; i<=255;i++)begin
          `uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
        `uvm_do_with(item, {item.rd_wr == 1; item.addr == i;})
        count++;
		end
                       
      for (int i=0; i<=255;i++)begin
          `uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
          `uvm_do_with(item, {item.rd_wr ==0; item.wr_data == addr; item.addr == i;})
        count++;
		end
                         
      for (int i=0; i<=255;i++)begin
          `uvm_info(get_type_name(), "Executing sequence", UVM_LOW)
          `uvm_do_with(item, {item.rd_wr ==1; item.addr == i;})
        count++;
		end
        #20;       

	endtask                   

 endclass

class derived_seq extends sequence1;

  `uvm_object_utils(derived_seq)

  function new(string name="derived_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    
    `uvm_do_with(item, {item.rd_wr ==0;})
   
    `uvm_do_with(item, {item.rd_wr ==1;})
    
  endtask
  
endclass
