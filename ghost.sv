module  ghost ( input Reset, frame_clk,
					input [1:0] random,
					input [9:0] StartX, StartY,
					input [9:0] PacmanX, PacmanY,
					input eaten,
					input [8:0] score,
					input [8:0] target,
               output [9:0]  GhostX, GhostY );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 logic [1:0] Ball_Direction;
	 logic [4:0] addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8;
	 logic [39:0] data1, data2, data3, data4, data5, data6, data7, data8;
	 logic lefttop, rightbot, topleft, botright,righttop,leftbot,topright,botleft;
	 logic [1:0] movement;
	 
//    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
//    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
//    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
//    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
//    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
//    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

//    assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 
	 always_comb begin
		addr1 = Ball_Y_Pos[8:4] + 2;
		addr2 = ((Ball_Y_Pos - 2) >> 4) + 2;
		addr3 = ((Ball_Y_Pos + 17) >> 4) + 2;
		addr4 = ((Ball_Y_Pos + 15) >> 4 )+ 2;
		
		addr5 = ((Ball_Y_Pos+15) >> 4) + 2;
		addr6 = ((Ball_Y_Pos+17) >> 4) + 2;
		addr7 = ((Ball_Y_Pos-2) >> 4) + 2;
		addr8 = Ball_Y_Pos[8:4]  + 2;
		
		topleft = data1[39 -(((Ball_X_Pos - 2) >> 4))];
		lefttop = data2[Ball_X_Pos[9:4]];
		rightbot = data3[(Ball_X_Pos + 15) >> 4];
		botright = data4[39-(((Ball_X_Pos + 17) >> 4))];
		
		botleft = data5[39 -(((Ball_X_Pos - 2) >> 4))];
		leftbot = data6[Ball_X_Pos[9:4]];
		righttop = data7[(Ball_X_Pos + 15) >> 4];
		topright = data8[39-(((Ball_X_Pos + 17) >> 4))];
	 end
	 
	 room_rom_8 rrom8(.*);
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= 13 * 16;
				Ball_X_Pos <= 20 * 16;
        end
        else if (score == target) begin
				Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= StartY;
				Ball_X_Pos <= StartX;
			end
		  else if (eaten) begin
				Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= StartY;
				Ball_X_Pos <= StartX;
			end	
        else 
        begin 
				if(lefttop || righttop) //top
					Ball_Y_Motion <= 0;
					
				if(leftbot || rightbot) //botom
					Ball_Y_Motion <=0;
					
				if(topleft || botleft) //left
					Ball_X_Motion <=0;
				
				if(topright || botright) //right
					Ball_X_Motion <=0;
			
				if ((Ball_X_Motion == 0) && (Ball_Y_Motion == 0)) begin
					movement <= random + PacmanX[1:0] + PacmanY[1:0];
					
				 
				 case (movement)
					2'b00 : begin
								Ball_Direction <= 2'b01;
								Ball_X_Motion <= -1;//A
								Ball_Y_Motion<= 0;
								
							   if(topleft || botleft) //left
									Ball_X_Motion <=0;
								
							  end
					        
					2'b01 : begin
							  Ball_Direction <= 2'b00;
					        Ball_X_Motion <= 1;//D
							  Ball_Y_Motion <= 0;
							
							 if(topright || botright) //right
					          Ball_X_Motion <=0;
							  end
							    
							  
					2'b10 : begin
							  Ball_Direction <= 2'b10;
					        Ball_Y_Motion <= 1;//S
							  Ball_X_Motion <= 0;
							
							  if(leftbot || rightbot) //botom
								  Ball_Y_Motion <=0;
							    
							 end
							  
					2'b11 : begin
							  Ball_Direction <= 2'b11;
					        Ball_Y_Motion <= -1;//W
							  Ball_X_Motion <= 0;
							  
							  if(lefttop || righttop) //top
					           Ball_Y_Motion <= 0;
						
							 end	  
					default: ;
			   endcase
				end
				
				 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign GhostX = Ball_X_Pos;
   
    assign GhostY = Ball_Y_Pos;
   
	 
	 
    

endmodule

