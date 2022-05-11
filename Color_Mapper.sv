module  color_mapper ( input [9:0] BallX, BallY, DrawX, DrawY, Ball_direction, blinkyX, blinkyY, pinkyX, pinkyY, inkyX, inkyY, clydeX, clydeY,
							  input [8:0] score,
							  input [8:0] eaten_score,
							  input [1:0] life,
							  input [29:0] Q,
							  input can_eat,
							  input 	pacdot_on, mushroom_on,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on, blinky_on, pinky_on, inky_on, clyde_on, score1_on,score2_on,score3_on, paclife1_on, paclife2_on, end_on;
	 
	 
 /* Old Ball: Generated square box by checkisng if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
//    int DistX, DistY, Size;
//	 assign DistX = DrawX - BallX;
//    assign DistY = DrawY - BallY;
//    assign Size = Ball_size;
	 logic [4:0] addr, end_addr;
	 logic [5:0] data_addr, end_data_addr;
	 logic [39:0] data, end_data;
	 logic wall;
	 logic [9:0] pacman_x, pacman_y;
	 logic [6:0] pacman_addr,paclife1_addr, paclife2_addr;
	 logic [15:0] pacman_data,paclife1_data, paclife2_data;
	 logic pacman, paclife1, paclife2;
	 logic [9:0] blinky_x, blinky_y;
	 logic [6:0] blinky_addr;
	 logic [15:0] blinky_data;
	 logic blinky;
	 logic [9:0] pinky_x, pinky_y;
	 logic [6:0] pinky_addr;
	 logic [15:0] pinky_data;
	 logic pinky;
	 logic [9:0] inky_x, inky_y;
	 logic [6:0] inky_addr;
	 logic [15:0] inky_data;
	 logic inky;
	 logic [9:0] clyde_x, clyde_y;
	 logic [6:0] clyde_addr;
	 logic [15:0] clyde_data;
	 logic clyde;
	 logic [7:0] score1_addr, score2_addr, score3_addr;
	 logic [15:0] score1_data, score2_data, score3_data;
	 logic [8:0]num1, num2, num3;
	 logic [9:0] score1_y, score2_y,score3_y, score1_x, score2_x, score3_x, paclife1_x, paclife2_x;
	 logic score1, score2, score3;
//	 logic [3:0] mushroom1_addr, mushroom2_addr,mushroom3_addr, mushroom4_addr;
//	 logic [15:0] mushroom1_data, mushroom2_data, mushroom3_data, mushroom4_data;
//	 logic mushroom1, mushroom2, mushroom3, mushroom4;
//	 logic [9:0] mushroom1_x, mushroom2_x, mushroom3_x, mushroom4_x;
	 
	 assign addr = DrawY[8:4];
	 assign data_addr = DrawX[9:4];
	 assign wall = data[data_addr];
	 
	 assign end_addr = DrawY[8:4];
	 assign end_data_addr = 40 - DrawX[9:4];
	 assign end_on = end_data[end_data_addr];
	 
	 assign pacman_x = DrawX - BallX;
	 assign pacman_y = DrawY - BallY;
	 assign pacman_addr = Ball_direction * 16 + pacman_y;
	 assign pacman = pacman_data[pacman_x];
	 
	 assign blinky_x = DrawX - blinkyX;
	 assign blinky_y = DrawY - blinkyY;
	 assign blinky_addr = 4 * 16 + blinky_y;
	 assign blinky = blinky_data[blinky_x];
	 
	 assign pinky_x = DrawX - pinkyX;
	 assign pinky_y = DrawY - pinkyY;
	 assign pinky_addr = 4 * 16 + pinky_y;
	 assign pinky = pinky_data[pinky_x];
	 
	 assign inky_x = DrawX - inkyX;
	 assign inky_y = DrawY - inkyY;
	 assign inky_addr = 4 * 16 + inky_y;
	 assign inky = inky_data[inky_x];
	 
	 assign clyde_x = DrawX - clydeX;
	 assign clyde_y = DrawY - clydeY;
	 assign clyde_addr = 4 * 16 + clyde_y;
	 assign clyde = clyde_data[clyde_x];
	 
	 assign num1 = ( (score + eaten_score) / 10) % 10;
  	 assign num2 = (score + eaten_score) % 10;
	 assign num3 = (score + eaten_score) /100;
	 assign score1_x = 16-(DrawX - 48);
	 assign score2_x = 16-(DrawX - 64);
	 assign score3_x = 16-(DrawX - 32);
	 assign score1_y = DrawY - 48;
	 assign score2_y = DrawY - 48;
	 assign score3_y = DrawY - 48;	 
	 assign score1_addr = num1 * 16 + score1_y;
	 assign score2_addr = num2 * 16 + score2_y;
	 assign score3_addr = num3 * 16 + score3_y;	 
	 assign score1 = score1_data[score1_x];
	 assign score2 = score2_data[score2_x];
	 assign score3 = score3_data[score3_x];
	 
	 assign paclife1_addr = DrawY - 48;
	 assign paclife2_addr = DrawY - 48;
	 assign paclife1_x = DrawX - 592;
	 assign paclife2_x = DrawX - 608;
	 assign paclife1 = paclife1_data[paclife1_x];
	 assign paclife2 = paclife2_data[paclife2_x];
	 
//	 assign mushroom1_x = 16 - (DrawX - 112);
//	 assign mushroom1_addr = DrawY - 32;
//	 assign mushroom1 = mushroom1_data[mushroom1_x];
//	 assign mushroom2_x = 16 - (DrawX - 512);
//	 assign mushroom2_addr = DrawY - 32;
//	 assign mushroom2 = mushroom2_data[mushroom2_x];
//	 assign mushroom3_x = 16 - (DrawX - 112);
//	 assign mushroom3_addr = DrawY - 448;
//	 assign mushroom3 = mushroom3_data[mushroom3_x];
//	 assign mushroom4_x = 16 - (DrawX - 512);
//	 assign mushroom4_addr = DrawY - 448;
//	 assign mushroom4 = mushroom4_data[mushroom4_x];
	 
	 room_rom rrom(.addr(addr+2), .data(data));
	 
	 character_rom crom(.addr(pacman_addr+48), .data(pacman_data));
	 character_rom crom2(.addr(blinky_addr+48), .data(blinky_data));
	 character_rom crom3(.addr(pinky_addr+48), .data(pinky_data));
	 character_rom crom4(.addr(inky_addr+48), .data(inky_data));
	 character_rom crom5(.addr(clyde_addr+48), .data(clyde_data));
	 
	 //New: add score
	 score_rom firstscore(.addr(score1_addr+96), .data(score1_data)); 	 
	 score_rom secondscore(.addr(score2_addr+96), .data(score2_data)); 
	 score_rom thirdscore(.addr(score3_addr+96), .data(score3_data));	 
	 
	 // New: add pacman life 
	 character_rom firstlife (.addr(paclife1_addr+48), .data(paclife1_data));
	 character_rom secondlife (.addr(paclife2_addr+48), .data(paclife2_data));
	 
	 // New: add endscene 
	 endscene_rom endscene (.addr(end_addr), .data(end_data));
	 
	 //New: add mushroom
//	 mushroom_rom mushroom1 (.addr(mushroom1_addr), .data(mushroom1_data));
//	 mushroom_rom mushroom2 (.addr(mushroom2_addr), .data(mushroom2_data));
//	 mushroom_rom mushroom3 (.addr(mushroom3_addr), .data(mushroom3_data));
//	 mushroom_rom mushroom4 (.addr(mushroom4_addr), .data(mushroom4_data));
	 
	 // determine whether draw a pacman life
	 always_comb 
	 begin 
	 if(DrawX >= 592 && DrawX < 608 && DrawY >= 48 && DrawY < 64)
			   paclife1_on = 1'b1;
	 else 
			   paclife1_on = 1'b0;
				
	 if(DrawX >= 608 && DrawX < 624 && DrawY >= 48 && DrawY < 64)
			   paclife2_on = 1'b1;
	 else 
			   paclife2_on = 1'b0;

	 end 
	 // determine whether write a score
	 always_comb
	 begin: Score_display
	 if(DrawX >= 48 && DrawX < 64 && DrawY >= 48 && DrawY < 64)
				score1_on = 1'b1;
	 else 
				score1_on = 1'b0;
				
    if(DrawX >= 64 && DrawX < 80 && DrawY >= 48 && DrawY < 64)
				score2_on = 1'b1;
	 else 
				score2_on = 1'b0;
	 
	 if(DrawX >= 32 && DrawX < 48 && DrawY >= 48 && DrawY < 64)
				score3_on = 1'b1;
	 else 
				score3_on = 1'b0;
	 
	 end
	 
	 // determine whether the pixel is in 16*16 region
    always_comb
    begin:Ball_on_proc
        if ( pacman_x >= 0 && pacman_x < 16 && pacman_y >= 0 && pacman_y < 16) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
		  if ( blinky_x >= 0 && blinky_x < 16 && blinky_y >= 0 && blinky_y < 16) 
            blinky_on = 1'b1;
        else 
            blinky_on = 1'b0;
		  if ( pinky_x >= 0 && pinky_x < 16 && pinky_y >= 0 && pinky_y < 16) 
            pinky_on = 1'b1;
        else 
            pinky_on = 1'b0;
		  if ( inky_x >= 0 && inky_x < 16 && inky_y >= 0 && inky_y < 16) 
            inky_on = 1'b1;
        else 
            inky_on = 1'b0;
		  if ( clyde_x >= 0 && clyde_x < 16 && clyde_y >= 0 && clyde_y < 16) 
            clyde_on = 1'b1;
        else 
            clyde_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
	 	  if (life == 2'b00 || (score + eaten_score) >= 200) begin
				if(end_on) begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;				
				end
				else begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;	
				end	
		  end 
		  else if (paclife1_on == 1'b1) begin
				if (life == 2'b01 || life == 2'b10) begin
					if(paclife1) begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'h00;					
					end 
					
					else begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end  
			   end 
				else begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;				
				end
		  end 
		  
		  else if (paclife2_on == 1'b1) begin
				if(life == 2'b10) begin
				   if(paclife2) begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'h00;					
					end 
					
					else begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end  
			   end 
				else begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;				
				end
		  end	 
	 
		  else if(score1_on == 1'b1) begin 
		  //white
				if(score1) begin
				  Red = 8'h88;
				  Green = 8'h2a;
				  Blue = 8'hb0;
				end
				
				else begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;				
				end

		  end
		  
		  else if(score3_on == 1'b1) begin 
		  //white
				if(score3) begin
				  Red = 8'h88;
				  Green = 8'h2a;
				  Blue = 8'hb0;
				end
				
				else begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;				
				end

		  end
		  
		  else if(score2_on == 1'b1) begin 
		  //white
				if(score2) begin
				  Red = 8'h88;
				  Green = 8'h2a;
				  Blue = 8'hb0;
				end
				
				else begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;				
				end

		  end
		  
		  else if(blinky_on == 1'b1) begin
				if(can_eat) begin
					if(blinky) 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
				else begin
					if(blinky) 
						begin
						Red = 8'hff;
						Green = 8'h00;
						Blue = 8'h00;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
		  end
		  else if(pinky_on == 1'b1) begin
				if (can_eat) begin
					if(pinky) 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
				else begin
					if(pinky) 
						begin
						Red = 8'hff;
						Green = 8'hc0;
						Blue = 8'hcb;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
		  end
		  else if(inky_on == 1'b1) begin
				if (can_eat) begin
					if(inky) 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
				else begin
					if(inky) 
						begin
						Red = 8'h00;
						Green = 8'hff;
						Blue = 8'hff;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
		  end
		  else if(clyde_on == 1'b1) begin
				if (can_eat) begin
					if(clyde) 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
				else begin
					if(clyde) 
						begin
						Red = 8'hff;
						Green = 8'h8c;
						Blue = 8'h00;
						end
					 else 
						begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
						end
				end
		  end
        else if ((ball_on == 1'b1)) 
		  begin
				 if(pacman) 
					begin
					Red = 8'hff;
					Green = 8'hff;
					Blue = 8'h00;
					end
				 else 
					begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
					end
        end 
		  else if (mushroom_on) begin
					Red = 8'h11;
					Green = 8'hff;
					Blue = 8'h00;		 
		  end  
		  else if(pacdot_on == 1'b0)
		  begin 
					Red = 8'hff;
					Green = 8'hff;
					Blue = 8'hff;		  
		  end 
		  
        else begin 

				if (wall) begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'hff;
				end
				else begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
				end
				
				
        end      
    end 
    
endmodule
