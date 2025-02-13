// reaction_timer_top.v
// Top-Level Module for the Reaction Timer Project
// Integrates clock division, fixed delay, timing, high score, LED, and 7-seg display functionalities.
module reaction_timer_top (
    input        clk,    // 50 MHz system clock
    input        reset,  // Active-high reset signal
    input        key0,   // Push button to start/stop the reaction timer
    output [9:0] led,    // 10-bit LED output for visual feedback
    output [6:0] hex0,   // 7-seg display: ones digit
    output [6:0] hex1,   // 7-seg display: tens digit
    output [6:0] hex2    // 7-seg display: hundreds digit
);
    // Internal signal declarations
    wire clk_1ms;              // 1 ms clock derived from the 50 MHz clock
    wire delay_done;           // Indicates that the fixed 1.5 second delay is complete
    wire [23:0] reaction_time; // Captured reaction time (in milliseconds)
    wire [23:0] high_score;    // Best (lowest) reaction time recorded

    // Instantiate the Clock Divider Module to generate a 1 ms clock.
    clock_divider clk_div (
        .clk(clk),
        .reset(reset),
        .clk_1ms(clk_1ms)
    );

    // Instantiate the Fixed Delay Generator Module.
    // When key0 is pressed, the delay generator waits 1.5 seconds before timing begins.
    fixed_delay_generator delay_gen (
        .clk_1ms(clk_1ms),
        .reset(reset),
        .start(key0),     // Begin delay when key0 is pressed
        .done(delay_done) // 'done' goes high after 1.5 seconds
    );

    // Instantiate the Timer Module.
    // Starts counting the elapsed time (in ms) after the delay is complete and stops when key0 is released.
    timer_module timer (
        .clk_1ms(clk_1ms),
        .reset(reset),
        .start(delay_done), // Begin timing when fixed delay is complete
        .stop(~key0),       // Stop timing when key0 is released
        .time_elapsed(reaction_time)
    );

    // Instantiate the High Score Register Module.
    // Updates the stored high score if the current reaction time is lower.
    high_score_register score_reg (
        .clk(clk),
        .reset(reset),
        .new_time(reaction_time),
        .update(~key0),      // Update high score when key0 is released
        .high_score(high_score)
    );

    // Instantiate the LED Controller Module.
    // Provides visual feedback during the active timing phase.
    led_controller led_ctrl (
        .start(delay_done), // Turn on LEDs when delay is complete (timing active)
        .stop(~key0),       // Turn off LEDs when timing stops
        .led(led)
    );

    // Instantiate the 7-Segment Display Controller Module.
    // Converts the binary reaction time into BCD and drives the HEX displays.
    ssd_display_controller ssd_ctrl (
        .clk(clk),
        .reaction_time(reaction_time),
        .hex0(hex0),
        .hex1(hex1),
        .hex2(hex2)
    );
    
endmodule
