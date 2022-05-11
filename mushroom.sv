module mushroom_rom ( input [3:0]	addr,
						output [15:0]	data
					 );

	parameter ADDR_WIDTH = 4;
   parameter DATA_WIDTH =  16;
	logic [ADDR_WIDTH-1:0] addr_reg;
				
	// ROM definition				
	parameter [0:2**ADDR_WIDTH-1][DATA_WIDTH-1:0] ROM = {

			16'b0000000000000000,
			16'b0000000000000000,
			16'b0000011111110000,
			16'b0000011000110000,
			16'b0000011111110000,
			16'b0000011000110000,
			16'b0000011000110000,
			16'b0000011000110000,
			16'b0000011000110000,
			16'b0000011001110000,
			16'b0000111001110000,
			16'b0000111001100000,
			16'b0000110000000000,
			16'b0000000000000000,
			16'b0000000000000000,
			16'b0000000000000000,
};
	
		assign data = ROM[addr];

endmodule