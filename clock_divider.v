// clock_divider.v
// Converts a 50 MHz system clock to a 1 kHz clock (i.e., 1 ms period)
module clock_divider (
    input clk,            // 50 MHz system clock
    input reset,          // Reset signal (active-high)
    output reg clk_1ms    // 1 ms clock output (1 kHz)
);
    reg [15:0] counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_1ms <= 0;
        end else if (counter == 49999) begin  // 50,000 cycles at 50 MHz = 1 ms
            counter <= 0;
            clk_1ms <= ~clk_1ms;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
