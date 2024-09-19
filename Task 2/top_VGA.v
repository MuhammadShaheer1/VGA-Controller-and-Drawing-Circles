//Name: Ch. Muhammad Shaheer Yasir
//Qalam: 286021

module top_VGA(CLOCK_50, SW, KEY,
				VGA_R, VGA_G, VGA_B,
				VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_CLK);
	
	input CLOCK_50;	
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] VGA_R;
	output [9:0] VGA_G;
	output [9:0] VGA_B;
	output VGA_HS;
	output VGA_VS;
	output VGA_BLANK_N;
	output VGA_SYNC_N;
	output VGA_CLK;	
	
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	
	
	assign colour = y % 8;
	Task1 T1 (CLOCK_50, x, y); 
	

	vga_adapter VGA(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(~(KEY[1])),
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

module Task1 (clock, X, Y);
input clock;
output reg [7:0] X;
output reg [6:0] Y;
always @ (posedge clock)
begin
if (X < 159)
begin
X = X + 1;
Y = Y;
end
else if (X == 159)
begin
X = 0;
if (Y == 119)
Y = 0;
else
Y = Y + 1;
end
end
endmodule