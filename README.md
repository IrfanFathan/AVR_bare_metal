# AVR Bare Metal Learning Repository

<p align="center">
	<img alt="Git Commits" src="https://img.shields.io/badge/Git%20Commits-25-0f766e?style=for-the-badge&logo=git&logoColor=white" />
	<img alt="Learning Days" src="https://img.shields.io/badge/Learning%20Days-29-1d4ed8?style=for-the-badge&logo=calendar&logoColor=white" />
	<img alt="First Commit" src="https://img.shields.io/badge/First%20Commit-2026--04--11-f59e0b?style=for-the-badge" />
	<img alt="Last Update" src="https://img.shields.io/badge/Last%20Update-2026--05--09-7c3aed?style=for-the-badge" />
</p>

<p align="center"><strong>Learning Days</strong> = days from first commit date to current date (inclusive).</p>

## 🎯 Repo Target

Build practical bare-metal AVR programming skills on ATmega328P (16 MHz) through step-by-step lessons and mini projects, from GPIO basics to interrupts and display interfacing.

## 👤 Who Is Me

- Name: Irfan Fathan M
- Role: Embedded Systems Learner / Developer
- Focus: Hands-on AVR register-level programming without Arduino framework abstractions

## 🚀 Why This Repo

- To document learning progress in a clear lesson-by-lesson format
- To practice low-level peripheral control using AVR registers
- To keep reusable templates and patterns for future AVR projects
- To build confidence in writing, compiling, and testing firmware with avr-gcc

## 📚 Lessons Table

| No  | Lession No                | Short Description                                               |
| --- | ------------------------- | --------------------------------------------------------------- |
| 1   | [lession_01](lession_01/) | LED blink on PB0 with 1-second delay using direct port control. |
| 2   | [lession_02](lession_02/) | 7-segment counter (0-9) on PORTD with timed updates.            |
| 3   | [lession_03](lession_03/) | Button-based LED control (PD0 input, PB0 output).               |
| 4   | [lession_04](lession_04/) | LCD control in 8-bit mode with command/data helper functions.   |
| 5   | [lession_05](lession_05/) | LCD control in 4-bit mode initialization and text display.      |
| 6   | [lession_06](lession_06/) | Basic blink example on PB5 (Arduino D13 equivalent).            |
| 7   | [lession_07](lession_07/) | External interrupts INT0/INT1 to set/clear PB0 output.          |
| 8   | [lession_08](lession_08/) | Timer/interrupt experiment scaffold for next lesson expansion.  |

## 🧪 Project Table

| No  | Project    | Short Description                                                      |
| --- | ---------- | ---------------------------------------------------------------------- |
| 1   | project_01 | Pseudo-random LED pattern generator using a simple LCG on PORTB/PORTD. |

## 🛠️ Toolchain

- Compiler: avr-gcc
- Target MCU: ATmega328P
- Clock: 16 MHz
- Build system: Makefile per lesson/project directory

## 📁 Repository Structure

- lession_01 to lession_08: Incremental learning modules
- project_01: Integrated mini project
- new_avr_project.sh: Script to bootstrap a new AVR lesson/project template

## 🧩 How To Use Simulation Files

1. Build the target lesson or project first to generate the HEX file:
   - `make -C lession_03`
   - `make -C lession_04`
   - `make -C lession_07`
   - `make -C project_01`
2. Open your simulator tool (for example Proteus) and load the corresponding `.sim1` file.
3. In the MCU properties (ATmega328P), set the program file to the generated `.hex` file from the same folder.
4. Ensure clock frequency is set to 16 MHz to match project configuration.
5. Run the simulation and observe outputs (LED, LCD, interrupts, or port patterns depending on the lesson).

### 📌 Available Simulation Files

- [lession_03/simulation_file_lession_three.sim1](lession_03/simulation_file_lession_three.sim1)
- [lession_04/simulation_file_lession_four.sim1](lession_04/simulation_file_lession_four.sim1)
- [lession_07/simulation_file_lession_seven.sim1](lession_07/simulation_file_lession_seven.sim1)
- [project_01/simulation_file_lession_three.sim1](project_01/simulation_file_lession_three.sim1)

## ✅ Notes

- Folder name uses lession spelling to match current project structure.
- Each lesson is intentionally small and focused on one concept.
