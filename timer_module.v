// timer_module.v
// Counts the elapsed time (in ms) after the fixed delay is complete.
module timer_module (
    input clk_1ms,             // 1 ms clock from clock_divider
    input reset,               // Reset signal (active-high)
    input start,               // Signal to start the timer (typically the delay_done signal)
    input stop,                // Signal to stop the timer (e.g., when the button is released)
    output reg [23:0] time_elapsed  // Reaction time in ms (24 bits)
);
    always @(posedge clk_1ms or posedge reset) begin
        if (reset)
            time_elapsed <= 0;
        else if (start && !stop)
            time_elapsed <= time_elapsed + 1;
    end
endmodule
