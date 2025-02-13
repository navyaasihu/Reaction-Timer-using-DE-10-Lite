// led_controller.v
// Controls the LED outputs for visual feedback.
module led_controller (
    input start,           // Signal to turn on LEDs (active during timing phase)
    input stop,            // Signal to turn off LEDs (when timing stops)
    output reg [9:0] led   // 10-bit LED output
);
    always @(*) begin
        if (start)
            led = 10'b1111111111;  // All LEDs on
        else if (stop)
            led = 10'b0000000000;  // All LEDs off
    end
endmodule
