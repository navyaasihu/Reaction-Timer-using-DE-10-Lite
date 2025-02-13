// ssd_display_controller.v
// Converts binary reaction time to BCD and drives three 7-segment displays.
module ssd_display_controller (
    input clk,                      // System clock (not critical for conversion)
    input [23:0] reaction_time,     // Reaction time in binary (ms)
    output reg [6:0] hex0,          // 7-seg display output for ones digit
    output reg [6:0] hex1,          // 7-seg display output for tens digit
    output reg [6:0] hex2           // 7-seg display output for hundreds digit
);
    reg [11:0] bcd; // 12-bit BCD value (3 digits)
    integer i;
    
    // Convert binary to BCD using the shift-and-add-3 algorithm.
    // For a fully synthesizable design, consider using registers for shifting.
    always @(reaction_time) begin
        bcd = 0;
        for (i = 0; i < 24; i = i + 1) begin
            bcd = {bcd[10:0], reaction_time[23]};
            reaction_time = reaction_time << 1;
            if (bcd[3:0] > 4)
                bcd[3:0] = bcd[3:0] + 3;
            if (bcd[7:4] > 4)
                bcd[7:4] = bcd[7:4] + 3;
            if (bcd[11:8] > 4)
                bcd[11:8] = bcd[11:8] + 3;
        end
    end
    
    // Function to convert a 4-bit BCD digit to 7-segment encoding.
    function [6:0] seven_seg;
        input [3:0] digit;
        begin
            case (digit)
                4'd0: seven_seg = 7'b1000000;
                4'd1: seven_seg = 7'b1111001;
                4'd2: seven_seg = 7'b0100100;
                4'd3: seven_seg = 7'b0110000;
                4'd4: seven_seg = 7'b0011001;
                4'd5: seven_seg = 7'b0010010;
                4'd6: seven_seg = 7'b0000010;
                4'd7: seven_seg = 7'b1111000;
                4'd8: seven_seg = 7'b0000000;
                4'd9: seven_seg = 7'b0010000;
                default: seven_seg = 7'b1111111;  // Blank display
            endcase
        end
    endfunction
    
    // Map each BCD digit to the corresponding 7-segment display.
    always @(bcd) begin
        hex0 = seven_seg(bcd[3:0]);    // Ones digit
        hex1 = seven_seg(bcd[7:4]);    // Tens digit
        hex2 = seven_seg(bcd[11:8]);   // Hundreds digit
    end
endmodule
