module counter(input Reset, clk, eat_mushroom,
					output can_eat,
					output[29:0] Q);


always_ff @ (posedge Reset or posedge clk ) begin
	if(Reset) begin
		Q <= 0;
		can_eat <= 0;
	end
	else if (eat_mushroom) begin
		Q <= 0;
		can_eat <= 1;
	end
	else begin
		Q++;
		if (Q == 400000000) begin
			can_eat <= 0;
		end
	end
end


endmodule