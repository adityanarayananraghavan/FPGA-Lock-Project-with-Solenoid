# FPGA-Lock-Project-with-Solenoid
VSDFPGA Lock Project
Overview
The VSDFPGA Lock Project is a digital password-based locking system implemented using Verilog HDL and designed for FPGA deployment. The project uses a finite state machine (FSM) to manage password entry, verification, error handling, and lock/unlock control. User interaction is achieved through push buttons, while system status is communicated using LEDs, a buzzer, and a relay output.
This project demonstrates core FPGA design concepts such as FSM-based control logic, synchronous design, input handling, and hardware pin constraint mapping.
________________________________________
Features
•	Finite State Machine (FSM)–based password lock
•	Multi-step password entry mechanism
•	Push-button controlled inputs
•	Visual feedback using RGB LEDs
•	Audible feedback using a buzzer
•	Relay control for external locking hardware
•	Active-LOW relay control logic
•	System reset and error handling support
________________________________________
File Description
lock_fsm.v
This Verilog file contains the main logic for the password lock system.
Inputs
•	hw_clk – FPGA system clock
•	btn_toggle – Toggles the current password bit
•	btn_enter – Confirms the selected bit
•	btn_next – Advances to the next password position
•	btn_reset – Resets the system to the initial locked state
Outputs
•	led_red – Indicates locked state
•	led_green – Indicates unlocked state
•	led_blue – Indicates password entry or error condition
•	buzzer – Provides audible alert on incorrect password
•	relay_ctrl – Controls the external locking mechanism (active LOW)
Functionality
•	The FSM progresses through multiple password entry states
•	User-entered bits are compared against a predefined password
•	Correct password entry transitions the system to the UNLOCKED state
•	Incorrect entry moves the system to an ERROR state with buzzer activation
•	The relay is enabled when the lock is successfully unlocked
________________________________________
vsdfm.pcf
This file defines the physical pin constraints for FPGA synthesis and implementation.
Key Details
•	Clock and button inputs are mapped with internal pull-up resistors
•	Output pins are assigned for RGB LEDs, buzzer, and relay control
•	Ensures correct interfacing between FPGA pins and external hardware
________________________________________
State Indication Summary
System State	LED Status	Relay	Buzzer
LOCKED	Red LED ON	OFF	OFF
INPUT	Blue LED ON	OFF	OFF
ERROR	Blue LED ON	OFF	ON
UNLOCKED	Green LED ON	ON	OFF
________________________________________
Applications
•	FPGA-based electronic locking systems
•	Access control and security solutions
•	Educational projects for learning Verilog and FSM design
•	Embedded systems and digital design demonstrations
________________________________________
Conclusion
The VSDFPGA Lock Project is a practical FPGA-based security system that highlights the use of FSMs, structured Verilog design, and real-world hardware interfacing. It serves as a strong foundation for learning and extending FPGA-based control applications.
________________________________________
