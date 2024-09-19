//Name: Ch. Muhammad Shaheer Yasir
//Qalam: 286021

module task3(CLOCK_50,KEY,SW,x,y,VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS,VGA_BLANK_N,VGA_SYNC_N,VGA_CLK);

wire vgaPlot;
assign vgaPlot=SW[9];

output [0:9] VGA_R;
output [0:9] VGA_G;
output [0:9] VGA_B;
output VGA_HS;
output VGA_VS;
output VGA_BLANK;
output VGA_SYNC;
output VGA_CLK;
output reg [0:7]x;// the x and y coordinates of the pixel to be drawn
output reg [0:6]y;


integer xc=80;
integer yc=60;

reg signed [0:7]tempd;
reg  [0:6]tempY;
reg  [0:7]tempX;

integer k,l;
reg [0:3]i=10;

reg r;

input CLOCK_50;
input [0:9]SW; //SW9  is plot
input [0:3]KEY;//key3 is reset

wire resetn;
reg [0:2]colour;
wire [3:7]radius;

assign resetn=KEY[3];
//assign colour=SW[0:2];
assign radius=SW[3:8];

always @(posedge CLOCK_50)
begin
	case(i)
		0:begin
			if(tempY>=tempX)
			begin
			  i=1;
			end
			else 
			begin
			  i=10;
			end
		end //end of 1
		1:begin
			x<=xc+tempX;
			y<=yc+tempY;
			i<=i+1'b1;
		end
		2:begin
			x<=xc-tempX;
			y<=yc+tempY;
			i<=i+1'b1;
		end
		3:begin
			x<=xc+tempX;
			y<=yc-tempY;
			i<=i+1'b1;
		end
		4:begin
			x<=xc-tempX;
			y<=yc-tempY;
			i<=i+1'b1;
		end
		5:begin
			x<=xc+tempY;
			y<=yc+tempX;
			i<=i+1'b1;
		end
		6:begin
			x<=xc-tempY;
			y<=yc+tempX;
			i<=i+1'b1;
		end
		7:begin
			x<=xc+tempY;
			y<=yc-tempX;
			i<=i+1'b1;
		end
		8:begin
			x<=xc-tempY;
			y<=yc-tempX;
			i<=i+1'b1;
			tempX<=tempX+1'b1;
		end
		9:begin
			if(tempd<0)
			begin
			   tempd<=tempd+6+(4*tempX);
			end
			else
			begin
				tempd<=tempd+10+4*(tempX-tempY);
				tempY<=tempY-1'b1;
			end//for else
			i=0;
		end//for 9
		10:begin
			tempX=0;
			tempY=radius;
			colour[0:2]=SW[0:2];
			tempd=3-(2*radius);
			x<=0;
			y<=0;
			if(resetn==0)
			begin
			  i=11;
			end
			else if(vgaPlot==1)
			begin
			  i=0;
			end// for if
		end //for 10
		11:begin
			colour<=3'b100;
			x<=x+1;
			if(x==159)
			begin
				y<=y+1;
				if(y==119)
				  i<=10;
			end
		end//for 11
	endcase
	//end//for if statement
end //for always block

vga_adapter VGA(
			.resetn(KEY[3]),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(vgaPlot),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "image.colour.mif";
		defparam VGA.USING_DE1 = "TRUE";
endmodule