module FF_EXT(clk,lock,tg_out);

input clk,lock;
output reg tg_out;


wire pulse_lock;
reg lock_reg;
//LOCK 0->1
always@(posedge clk )begin
      lock_reg<=lock;
end
assign pulse_lock = lock & (~lock_reg);
always@(posedge clk)begin
   if(pulse_lock)begin
    tg_out<=1;
   end
end

endmodule



