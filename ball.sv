module  ball ( input Reset, frame_clk,
					input [7:0] keycode,
               output [9:0]  BallX, BallY, BallD );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 logic [1:0] Ball_Direction;
	 logic [4:0] addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8;
	 logic [39:0] data1, data2, data3, data4, data5, data6, data7, data8;
	 logic lefttop, rightbot, topleft, botright,righttop,leftbot,topright,botleft;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 
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
				Ball_Y_Pos <= 16 * 16;
				Ball_X_Pos <= 20 * 16;
        end
           
        else 
        begin 
//				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//					  Ball_Y_Motion <= Ball_Y_Step;
//					  
//				 else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
//					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
//					  Ball_X_Motion <= Ball_X_Step;
//					  
//				 else 
//					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
//					  
				if(lefttop || righttop) //top
					Ball_Y_Motion <= 0;
					
				if(leftbot || rightbot) //botom
					Ball_Y_Motion <=0;
					
				if(topleft || botleft) //left
					Ball_X_Motion <=0;
				
				if(topright || botright) //right
					Ball_X_Motion <=0;				 
				 
				 case (keycode)
					8'h04 : begin
								Ball_Direction <= 2'b01;
								Ball_X_Motion <= -1;//A
								Ball_Y_Motion<= 0;
								
							   if(topleft || botleft) //left
									Ball_X_Motion <=0;
								
							  end
					        
					8'h07 : begin
							  Ball_Direction <= 2'b00;
					        Ball_X_Motion <= 1;//D
							  Ball_Y_Motion <= 0;
							
							 if(topright || botright) //right
					          Ball_X_Motion <=0;
							  end
							    
							  
					8'h16 : begin
							  Ball_Direction <= 2'b10;
					        Ball_Y_Motion <= 1;//S
							  Ball_X_Motion <= 0;
							
							  if(leftbot || rightbot) //botom
								  Ball_Y_Motion <=0;
							    
							 end
							  
					8'h1A : begin
							  Ball_Direction <= 2'b11;
					        Ball_Y_Motion <= -1;//W
							  Ball_X_Motion <= 0;
							  
							  if(lefttop || righttop) //top
					           Ball_Y_Motion <= 0;
						
							 end	  
					default: ;
			   endcase
				 
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
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallD = Ball_Direction;
	 
	 
    

endmodule

