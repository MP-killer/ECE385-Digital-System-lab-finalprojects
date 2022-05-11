module statemachine( input Reset, frame_clk,
							input [1:0] life,
							input[7:0] keycode,
							output start,
							output back

);

always_ff @ (posedge Reset or posedge frame_clk ) begin
	if(Reset) begin
		start <= 0;
		back <= 0;
		end
	else begin
		if (start == 1)
			start <= 0;
		if (back == 1)
			back <= 0;
//		if (life == 0) begin	
		case (keycode)
			8'h2c : begin
				start <= 1;
				end
			8'h05: begin
				back <= 1;
				end
			default: ;
		endcase
//		end
	end

end

//always_comb begin
//	case (keycode)
//			8'h2c : begin
//				start = 1;
//				end
//			default: ;
//		endcase
//end

endmodule