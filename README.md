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

| No  | Lesson Folder             | Short Description                                               |
| --- | ------------------------- | --------------------------------------------------------------- |
| 1   | [lesson_01](lesson_01/)   | LED blink on PB0 with 1-second delay using direct port control. |
| 2   | [lesson_02](lesson_02/)   | 7-segment counter (0-9) on PORTD with timed updates.            |
| 3   | [lesson_03](lesson_03/)   | Button-based LED control (PD0 input, PB0 output).               |
| 4   | [lesson_04](lesson_04/)   | LCD control in 8-bit mode with command/data helper functions.   |
| 5   | [lesson_05](lesson_05/)   | LCD control in 4-bit mode initialization and text display.      |
| 6   | [lesson_06](lesson_06/)   | Basic blink example on PB5 (Arduino D13 equivalent).            |
| 7   | [lesson_07](lesson_07/)   | External interrupts (INT0/INT1) with ISR handlers.              |
| 8   | [lesson_08](lesson_08/)   | Timer/interrupt scaffold and experiment playground.             |
| 9   | [lesson_09](lesson_09/)   | Small experiment folder (basic I/O examples).                   |
| 10  | [lesson_10](lesson_10/)   | Additional peripheral experiments (timing and control).         |
| 11  | [lesson_11](lesson_11/)   | Extended examples and Proteus simulation for timing tests.      |
| 12  | [lesson_12](lesson_12/)   | PWM + ADC experiments; advanced timer/ADC integration.          |
| 13  | [lesson_13](lesson_13/)   | UART receive example with ISR and serial handling.              |
| 14  | [lesson_14](lesson_14/)   | Higher-level examples and combined features (project-ready).     |

## 🧪 Project Table

| No  | Project    | Short Description                                                      |
| --- | ---------- | ---------------------------------------------------------------------- |
| 1   | [project_01](project_01/) | Pseudo-random LED pattern generator using a simple LCG on PORTB/PORTD. |
| 2   | [project_02](project_02/) | Additional mini-project (integrates lessons into small demo).        |

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

1. Build the target lesson or project first to generate the HEX file. Example:

```bash
make -C lesson_03
make -C lesson_04
make -C lesson_07
make -C project_01
```

2. Open your simulator tool (for example Proteus) and load the corresponding `.sim1` file.
3. In the MCU properties (ATmega328P), set the program file to the generated `.hex` file from the same folder.
4. Ensure clock frequency is set to 16 MHz to match project configuration.
5. Run the simulation and observe outputs (LED, LCD, interrupts, or port patterns depending on the lesson).

### 📌 Available Simulation Files

- [lesson_03/simulation_file_lession_three.sim1](lesson_03/simulation_file_lession_three.sim1)
- [lesson_04/simulation_file_lession_four.sim1](lesson_04/simulation_file_lession_four.sim1)
- [lesson_07/simulation_file_lession_seven.sim1](lesson_07/simulation_file_lession_seven.sim1)
- [lesson_11/simulation_file_lession_11.sim1](lesson_11/simulation_file_lession_11.sim1)
- [lesson_12/simulation_file_lession_12.sim1](lesson_12/simulation_file_lession_12.sim1)
- [project_01/simulation_file_lession_three.sim1](project_01/simulation_file_lession_three.sim1)

## ✅ Notes

- Folder naming in this repo is mixed; links above point to the actual folders present.
- Each lesson is intentionally small and focused on one concept.

## 🖼️ HTML Graphics Preview

An interactive HTML preview showing repository badges and quick links is available at: [docs/graphics.html](docs/graphics.html)

You can open `docs/graphics.html` in a browser to see a lightweight visual summary of the repo.
