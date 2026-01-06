# FPGA-Lock-Project-with-Solenoid
# VSDFPGA Lock Project

## Overview

The **VSDFPGA Lock Project** is a digital password-based locking and unlocking system implemented using **Verilog HDL** and designed for **FPGA deployment**. The system is built around a **Finite State Machine (FSM)** to handle password entry, verification, error detection, unlock timing, and reset control.

User interaction is performed through push buttons, while system status and feedback are provided via **RGB LEDs**, a **buzzer**, and a **relay output** connected to a **solenoid lock**.

This project demonstrates fundamental FPGA design principles such as FSM-based control logic, synchronous design, input handling, and hardware pin constraint mapping. Upon correct password entry, the lock unlocks and automatically resets back to the locked state after a fixed duration.


---

## Features
- FSM-based password lock and unlock mechanism  
- Multi-step password entry process  
- Push-button controlled inputs  
- Visual feedback using RGB LEDs  
- Audible feedback using a buzzer  
- Relay-based control for external locking hardware  
- Active-LOW relay control logic  
- System reset and error handling support  

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
- FSM progresses through multiple password entry states  
- User-entered bits are compared against a predefined password  
- Correct password transitions the system to the **UNLOCKED** state  
- Incorrect entry moves the system to an **ERROR** state with buzzer activation  
- Relay is enabled when the lock is successfully unlocked  

---

### `vsdfm.pcf`
This file defines the physical pin mapping between FPGA pins and external hardware components.

**Key Details**
- Button inputs mapped with internal pull-up   
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
- Access control and security solutions  
- Educational projects for learning Verilog and FSM design  
- Embedded systems and digital design demonstrations  

---

## Conclusion
The **VSDFPGA Lock Project** is a practical FPGA-based security system showcasing FSM-driven control, structured Verilog design, and real-world hardware interfacing. It provides a strong foundation for understanding and extending FPGA-based control and security applications.
