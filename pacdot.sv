module pacdot (
					input Reset, frame_clk,
					input [9:0]  BallX, BallY,
					input [9:0]  DrawX, DrawY,
					output mushroom_on,
					output pacdot_on,
					output [8:0] score,
					output eat_mushroom
);

logic [39:0] dots [30];
logic [3:0] dot_X_In, dot_Y_In;
logic [4:0] dot_addr_Y;
logic [5:0] dot_addr_X;
logic [8:0] score_logic;

always_ff @ (posedge Reset or posedge frame_clk)
begin
	if(Reset)
	begin
		  score_logic <= 0;
			
	     dots[0]  <=40'b1111111111111111111111111111111111111111; // 0
		  dots[1]  <=40'b1111111111111111111111111111111111111111; // 1
        dots[2]  <=40'b1111111000000000000110000000000001111111; // 2
        dots[3]  <=40'b1111111011110111110110111110111101111111; // 3
        dots[4]  <=40'b1111111011110111110110111110111101111111; // 4
        dots[5]  <=40'b1111111000000000000000000000000001111111; // 5
        dots[6]  <=40'b1111111011110110111111110110111101111111; // 6
        dots[7]  <=40'b1111111000000110000110000110000001111111; // 7
        dots[8]  <=40'b1111111111110111110110111110111111111111; // 8
        dots[9]  <=40'b1111111111110111110110111110111111111111; // 9
		  dots[10] <=40'b1111111111110110000000000110111111111111; // 10
		  dots[11] <=40'b1111111111110110111111110110111111111111; // 11
        dots[12] <=40'b1111111111110110111111110110111111111111; // 12
        dots[13] <=40'b1111111000000000111111110000000001111111; // 13
        dots[14] <=40'b1111111111110110111111110110111111111111; // 14
        dots[15] <=40'b1111111111110110111111110110111111111111; // 15
        dots[16] <=40'b1111111111110110000100000110111111111111; // 16
        dots[17] <=40'b1111111111110110111111110110111111111111; // 17
        dots[18] <=40'b1111111111110110111111110110111111111111; // 18
        dots[19] <=40'b1111111000000000000110000000000001111111; // 19
		  dots[20] <=40'b1111111011110111110110111110111101111111; // 20
		  dots[21] <=40'b1111111000110000000000000000110001111111; // 21
        dots[22] <=40'b1111111110110110111111110110110111111111; // 22
        dots[23] <=40'b1111111110110110111111110110110111111111; // 23
        dots[24] <=40'b1111111000000110000110000110000001111111; // 24
        dots[25] <=40'b1111111011111111110110111111111101111111; // 25
        dots[26] <=40'b1111111011111111110110111111111101111111; // 26
        dots[27] <=40'b1111111000000000000000000000000001111111; // 27
        dots[28] <=40'b1111111111111111111111111111111111111111; // 28
        dots[29] <=40'b1111111111111111111111111111111111111111; // 29
	end
    else if (BallX[3:0] == 0 && BallY[3:0] == 0)
    begin 
        if(dots[BallY[9:4]][BallX[9:4]] == 0)
		  begin
				 if (BallY[8:4] == 2 && BallX[9:4] == 7)
					eat_mushroom <= 1;
				 else if (BallY[8:4] == 2 && BallX[9:4] == 32)
					eat_mushroom <= 1;
				 else if (BallY[8:4] == 27 && BallX[9:4] == 7)
					eat_mushroom <= 1;
				 else if (BallY[8:4] == 27 && BallX[9:4] == 32)
					eat_mushroom <= 1;
				 else
					eat_mushroom <= 0;
             dots[BallY[9:4]][BallX[9:4]] = 1;
				 score_logic++;
		  end
    end 

end


always_comb 
begin
	 score = score_logic;
    dot_X_In = DrawX[3:0];
    dot_Y_In = DrawY[3:0];
    dot_addr_Y = DrawY [8:4];
    dot_addr_X = DrawX [9:4];

    if(dot_X_In <= 9 && dot_X_In >=6 && dot_Y_In <= 9 && dot_Y_In >=6) 
        pacdot_on = dots[dot_addr_Y][dot_addr_X];
		  
    else 
        pacdot_on = 1;

		  
	 //determine the condition for strong mashroom		  
	 if(dot_addr_Y == 2 && dot_addr_X == 7 && pacdot_on == 0) 
		mushroom_on = 1;
	 else if(dot_addr_Y == 2 && dot_addr_X == 32 && pacdot_on == 0) 
		mushroom_on = 1;
	 else if(dot_addr_Y == 27 && dot_addr_X == 7 && pacdot_on == 0) 
		mushroom_on = 1;
	 else if(dot_addr_Y == 27 && dot_addr_X == 32 && pacdot_on == 0) 
		mushroom_on = 1;
		
	 else 
	 	mushroom_on = 0;

end

endmodule 
