

module led_blink(clk,rstn,led);

input clk,rstn;
output reg [1:0]led;

reg [27:0] counter;
reg clkout;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
            counter<=0;
            clkout<=0;
                       
    end else begin
           if (counter[26]) begin
                clkout <= ~clkout;
                counter <=0;
            end
            else begin
                counter <= counter+1;
            end
        
    end
end

always @(posedge clkout or negedge rstn) begin
    if (!rstn) begin
            led <= 0;
         
    end else begin
        
          if (led <=3) begin
            led <= led+1;
            end
          else begin
            led <=0;
          end
    end
end
endmodule