// high_score_register.v
// Stores the best (lowest) reaction time measured.
module high_score_register (
    input clk,               // System clock (50 MHz)
    input reset,             // Reset signal (active-high)
    input [23:0] new_time,   // New reaction time in ms
    input update,            // Update signal (e.g., triggered when the button is released)
    output reg [23:0] high_score  // Best reaction time recorded
);
    initial high_score = 24'hFFFFFF; // Initialize to maximum possible value
    always @(posedge clk or posedge reset) begin
        if (reset)
            high_score <= 24'hFFFFFF;
        else if (update && new_time < high_score)
            high_score <= new_time;
    end
endmodule
