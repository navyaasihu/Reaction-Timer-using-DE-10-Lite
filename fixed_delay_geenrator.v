// fixed_delay_generator.v
// Generates a 1.5 second delay when the 'start' signal is asserted.
module fixed_delay_generator (
    input clk_1ms,       // 1 ms clock from clock_divider
    input reset,         // Reset signal (active-high)
    input start,         // Start delay signal (e.g., button press)
    output reg done      // Delay completion flag (goes high after 1.5 sec)
);
    reg [10:0] counter;
    
    always @(posedge clk_1ms or posedge reset) begin
        if (reset) begin
            counter <= 0;
            done <= 0;
        end else if (start) begin
            if (counter < 1500) begin  // 1500 ms = 1.5 seconds
                counter <= counter + 1;
                done <= 0;
            end else begin
                done <= 1;
            end
        end else begin
            counter <= 0;
            done <= 0;
        end
    end
endmodule
