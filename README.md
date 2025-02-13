Reaction Timer on DE10-Lite with On-Board SSD Display
Overview:
This project implements a Reaction Timer using Verilog on the Terasic DE10-Lite FPGA board. The design employs a modular architecture that leverages the board’s on-board seven-segment displays (HEX displays) to present the reaction time numerically. The system is built to measure human reaction time accurately while demonstrating digital design, state machine implementation, and hardware/software integration.

Modules Included:

Clock Divider:
The clock divider reduces the board’s 50 MHz clock to a 1 ms tick, providing a manageable timing reference for the system.

Fixed Delay Generator:
A fixed delay generator creates a 1.5-second delay after the test is initiated. This delay prevents premature reaction and ensures the user’s readiness before the timer starts.

Timer Module:
Once the delay is complete, the timer module measures the elapsed time in milliseconds. This precise counting mechanism is essential for capturing the user’s reaction time.

LED Controller:
The LED controller drives a 10-LED array on the board, offering a visual indication of the timing process. The LEDs can display a binary representation of the reaction time or serve as status indicators during different stages of the test.

High Score Register:
This module stores and continuously updates the best (lowest) reaction time achieved, providing a performance benchmark for the user.

Seven-Segment Display (SSD) Controller:
The SSD controller converts the binary reaction time into BCD format and drives the on-board HEX displays (HEX0, HEX1, HEX2). This conversion allows the reaction time to be displayed in a human-readable numerical format.

Functionality:
The reaction timer begins when the user presses KEY0, initiating a 1.5-second delay. After the delay, the LEDs light up and the timer starts counting. When the user presses KEY0 again, the timer stops, the reaction time is captured, and if it is lower than the current high score, the high score is updated. The final reaction time is then displayed on the on-board seven-segment displays, providing an immediate and clear visual readout of the user's performance.

This project showcases the integration of digital logic, precise timing, and display interfacing on an FPGA platform, making it an excellent example of embedded system design and hardware/software co-design on the DE10-Lite board.
