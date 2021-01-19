// Code your design here
 `timescale 1ns/100ps 
module memory(intf vif, input clk);
   logic [7:0] register [5:0];
  always_ff @(posedge clk)
	begin
      if(vif.reset1)begin
        for( int i = 0; i<=5; i++) register[i] <= 8'hff;
      end
      else if(vif.rd_wr1 == 1 && vif.reset1 == 0) vif.rd_data1 <= register[vif.addr1]; 
      else if(vif.rd_wr1 == 0 && vif.reset1 == 0) register[vif.addr1] <= vif.wr_data1;
	end
 endmodule