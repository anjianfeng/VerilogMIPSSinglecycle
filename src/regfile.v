`include "global_def.v"
module regfile( clk, rst, ra, rb, rw, busa, busb, busw, regwr);
    
   input         clk;
   input         rst;
   input  [4:0]  ra, rb, rw;
   input  [31:0] busw;
   output [31:0] busa, busb;
   input         regwr;
   
   reg [31:0] rf[31:0];
   
   integer i;
   
   always @(posedge clk) begin
      if (rst) begin
       for (i=0; i<32; i=i+1)
         rf[i] <= 0;
      end else if (regwr) begin
         // DON'T write $zero
         if (rw!=0)
            rf[rw] <= busw;
         `ifdef DEBUG
            $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", 0, rf[1], rf[2], rf[3], rf[4], rf[5], rf[6], rf[7]);
            $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[8], rf[9], rf[10], rf[11], rf[12], rf[13], rf[14], rf[15]);
            $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[16], rf[17], rf[18], rf[19], rf[20], rf[21], rf[22], rf[23]);
            $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[24], rf[25], rf[26], rf[27], rf[28], rf[29], rf[30], rf[31]);
         `endif
      end
   end // end always
   
   assign busa = (ra == 0) ? 32'd0 : rf[ra];
   assign busb = (rb == 0) ? 32'd0 : rf[rb];
   
endmodule


