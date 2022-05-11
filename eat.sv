module eat(input Reset, clk,
			  input can_eat,
			  input [9:0] BallX, BallY, blinkyX, blinkyY, pinkyX, pinkyY, inkyX, inkyY, clydeX, clydeY,
			  output eaten,
			  output [8:0] eaten_score,
			  output blinky_eaten,
			  output pinky_eaten, inky_eaten, clyde_eaten,
			  output [1:0] life);
	


	always_ff @ (posedge Reset or posedge clk ) begin
		if (Reset) begin
			life <= 2'b10;
			eaten <= 1'b0;
			eaten_score <= 0;
			blinky_eaten <= 1'b0;
			pinky_eaten <= 1'b0;
			inky_eaten <= 1'b0;
			clyde_eaten <= 1'b0;
			end
		else begin
			if (can_eat)begin
				if(((BallX - blinkyX < 16 || blinkyX - BallX < 16) && (BallY - blinkyY < 15 || blinkyY - BallY < 15))
				||  ((BallY - blinkyY< 16 || blinkyY - BallY < 16) && (BallX - blinkyX < 15 || blinkyX - BallX < 15))) begin
					blinky_eaten <= 1'b1;
					eaten_score <= eaten_score + 10;
				end
				else if(((BallX - pinkyX < 16 || pinkyX - BallX < 16) && (BallY - pinkyY < 15 || pinkyY - BallY < 15))
				||  ((BallY - pinkyY< 16 || pinkyY - BallY < 16) && (BallX - pinkyX < 15 || pinkyX - BallX < 15)))begin
					pinky_eaten <= 1'b1;
					eaten_score <= eaten_score + 10;
				end
				else if(((BallX - inkyX < 16 || inkyX - BallX < 16) && (BallY - inkyY < 15 || inkyY - BallY < 15))
				||  ((BallY - inkyY< 16 || inkyY - BallY < 16) && (BallX - inkyX < 15 || inkyX - BallX < 15)))begin
					inky_eaten <= 1'b1;
					eaten_score <= eaten_score + 10;
				end
				else if(((BallX - clydeX < 16 || clydeX - BallX < 16) && (BallY - clydeY < 15 || clydeY - BallY < 15))
				||  ((BallY - clydeY< 16 || clydeY - BallY < 16) && (BallX - clydeX < 15 || clydeX - BallX < 15))) begin
					clyde_eaten <= 1'b1;
					eaten_score <= eaten_score + 10;
				end
				else begin
					blinky_eaten <= 1'b0;
					pinky_eaten <= 1'b0;
					inky_eaten <= 1'b0;
					clyde_eaten <= 1'b0;
				end

			end
			else begin
				if(((BallX - blinkyX < 16 || blinkyX - BallX < 16) && (BallY - blinkyY < 15 || blinkyY - BallY < 15))
				||  ((BallY - blinkyY< 16 || blinkyY - BallY < 16) && (BallX - blinkyX < 15 || blinkyX - BallX < 15)))
					eaten <= 1'b1;
				else if(((BallX - pinkyX < 16 || pinkyX - BallX < 16) && (BallY - pinkyY < 15 || pinkyY - BallY < 15))
				||  ((BallY - pinkyY< 16 || pinkyY - BallY < 16) && (BallX - pinkyX < 15 || pinkyX - BallX < 15)))
					eaten <= 1'b1;
				else if(((BallX - inkyX < 16 || inkyX - BallX < 16) && (BallY - inkyY < 15 || inkyY - BallY < 15))
				||  ((BallY - inkyY< 16 || inkyY - BallY < 16) && (BallX - inkyX < 15 || inkyX - BallX < 15)))
					eaten <= 1'b1;
				else if(((BallX - clydeX < 16 || clydeX - BallX < 16) && (BallY - clydeY < 15 || clydeY - BallY < 15))
				||  ((BallY - clydeY< 16 || clydeY - BallY < 16) && (BallX - clydeX < 15 || clydeX - BallX < 15)))
					eaten <= 1'b1;
				else
					eaten <= 1'b0;
					
				if (eaten)
					life--;
			end
		end
	
	end
		
//	always_comb begin
//		if((BallX == blinkyX) && (BallY == blinkyY))
//			eaten = 1'b1;
//		else if((BallX == pinkyX) && (BallY == pinkyY))
//			eaten = 1'b1;
//		else if((BallX == inkyX) && (BallY == inkyY))
//			eaten = 1'b1;
//		else if((BallX == clydeX) && (BallY == clydeY))
//			eaten = 1'b1;
//		else
//			eaten = 1'b0;
//	end
	

	
endmodule