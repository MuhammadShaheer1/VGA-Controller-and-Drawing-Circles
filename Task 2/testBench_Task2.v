module testBench_Task2();

wire	VGA_R,
			VGA_G,
			VGA_B,
			VGA_HS,
			VGA_VS,
			VGA_BLANK_N,
			VGA_SYNC_N,
			VGA_CLK;



wire [2:0]color;
wire [7:0]xCoord;
wire [6:0]yCoord;


reg [3:2]KEY; 
reg	CLOCK_50;
integer k;

top_VGA dut(	.KEY(KEY), 
					.CLOCK_50(CLOCK_50),
					.color(color),
					.xCoord(xCoord),
					.yCoord(yCoord),
					
					
					
					.VGA_R(VGA_R),
					.VGA_G(VGA_G),
					.VGA_B(VGA_B),
					.VGA_HS(VGA_HS),
					.VGA_VS(VGA_VS),
					.VGA_BLANK_N(VGA_BLANK_N),
					.VGA_SYNC_N(VGA_SYNC_N),
					.VGA_CLK(VGA_CLK));
					
					
initial 
begin

KEY = 2'b11;
CLOCK_50 = 1'b0;
#10;

KEY = 2'b01;
CLOCK_50 = 1'b1;
#10;

KEY = 2'b11;
CLOCK_50 = 1'b1;
#10;

for(k = 0; k < 39000; k = k + 1)
begin

CLOCK_50 = ~CLOCK_50;
#10;

end

end

endmodule 