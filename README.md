# FPGA-Lock-Project-with-Solenoid
# VSDFPGA Lock Project

## Overview
The **VSDFPGA Lock Project** is a digital password-based locking system implemented using Verilog HDL and designed for FPGA deployment. The system uses a Finite State Machine (FSM) to control password entry, verification, error handling, and lock/unlock functionality. User interaction is handled through push buttons, while system status is indicated using LEDs, a buzzer, and a relay output.

This project demonstrates fundamental FPGA design concepts such as FSM-based control logic, synchronous digital design, and hardware pin constraint mapping.

---

## Features
- FSM-based digital password lock  
- Multi-step password entry mechanism  
- Push-button based user input  
- Visual feedback using RGB LEDs  
- Audible feedback using a buzzer  
- Relay control for external locking mechanism  
- Active-LOW relay logic  
- Reset and error handling support  

---

## Design Files

### `lock_fsm.v`
This file contains the Verilog HDL implementation of the password lock FSM.

**Inputs**
- `hw_clk` – System clock  
- `btn_toggle` – Toggles the current password bit  
- `btn_enter` – Confirms the entered bit  
- `btn_next` – Moves to the next password position  
- `btn_reset` – Resets the system to the locked state  

**Outputs**
- `led_red` – Indicates locked state  
- `led_green` – Indicates unlocked state  
- `led_blue` – Indicates password entry or error state  
- `buzzer` – Audible alert for incorrect password  
- `relay_ctrl` – Controls the external lock (active LOW)  

**Operation**
- The FSM advances through password entry states sequentially  
- Entered bits are compared with a predefined password  
- Correct password transitions the system to the `UNLOCKED` state  
- Incorrect password triggers an `ERROR` state with buzzer activation  
- Relay output is enabled when the lock is unlocked  

---

### `vsdfm.pcf`
This file defines the physical pin mapping between FPGA pins and external hardware components.

**Key Details**
- Clock and button inputs mapped with internal pull-up resistors  
- Outputs assigned for RGB LEDs, buzzer, and relay  
- Ensures correct FPGA-to-hardware interfacing  

---

## State Indication

| State     | LED Indication | Relay | Buzzer |
|----------|---------------|-------|--------|
| LOCKED   | Red LED ON     | OFF   | OFF    |
| INPUT    | Blue LED ON    | OFF   | OFF    |
| ERROR    | Blue LED ON    | OFF   | ON     |
| UNLOCKED | Green LED ON   | ON    | ON    |

---

## Applications
- FPGA-based electronic locking systems  
- Access control and security systems  
- Educational projects for learning Verilog and FSM design  
- Embedded and digital system prototyping  

---

## Conclusion
The **VSDFPGA Lock Project** is a practical FPGA-based security system that demonstrates FSM-driven control, structured Verilog design, and real-world hardware interfacing.
