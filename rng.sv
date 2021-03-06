// random number generator 
// Reference: https://stackoverflow.com/questions/14497877/how-to-implement-a-pseudo-hardware-random-number-generator



module rng
   #(parameter BITS = 5)
   (
    input             clk,
    input             rst_n,

    output [4:0] data
    );

   logic [4:0] data_next;
   always_comb begin
      data_next = data;
      repeat(BITS) begin
			  data_next[4] = data[4]^data[1];
			  data_next[3] = data[3]^data[0];
			  data_next[2] = data[2]^data_next[4];
			  data_next[1] = data[1]^data_next[3];
			  data_next[0] = data[0]^data_next[2];
      end
   end

   always_ff @(posedge clk or posedge rst_n) begin
      if(rst_n)
         data <= 5'h1f;
      else
         data <= data_next;

   end

endmodule