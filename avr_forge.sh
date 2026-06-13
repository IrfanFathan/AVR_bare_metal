#!/bin/bash

# ╔══════════════════════════════════════════════════════════════╗
# ║              AVR FORGE  ·  Project Generator                 ║
# ║  Run with --install   →  installs system-wide as: avr_forge  ║
# ║  Run with --uninstall →  removes system-wide install         ║
# ║  Run with --check     →  verify dependencies are installed   ║
# ╚══════════════════════════════════════════════════════════════╝

INSTALL_PATH="/usr/local/bin/avr_forge"
VERSION="1.1.0.a"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Colors & Styles
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
R='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
CYAN='\033[36m'
BCYAN='\033[1;36m'
GREEN='\033[32m'
BGREEN='\033[1;32m'
YELLOW='\033[33m'
RED='\033[31m'
WHITE='\033[97m'
BWHITE='\033[1;97m'
GRAY='\033[90m'

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  UI Helpers
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

divider() {
    echo -e "${GRAY}  ────────────────────────────────────────────────${R}"
}

section() {
    echo ""
    echo -e "${BCYAN}  ◆  ${BWHITE}$1${R}"
    echo -e "${GRAY}  ╰─────────────────────────────────────${R}"
}

ok()   { echo -e "${BGREEN}  ✔️  ${WHITE}$1${R}"; }
err()  { echo -e "${RED}  ✘  ${WHITE}$1${R}" >&2; exit 1; }
warn() { echo -e "${YELLOW}  ⚠️  ${WHITE}$1${R}"; }
info() { echo -e "${GRAY}     $1${R}"; }

# Numbered menu — stores choice in $MENU_RESULT
menu() {
    local title="$1"; shift
    local opts=("$@")
    echo -e "${CYAN}     Select ${BWHITE}${title}${R}${CYAN}:${R}"
    for i in "${!opts[@]}"; do
        printf "     ${CYAN}[%d]${R}  %s\n" "$((i+1))" "${opts[$i]}"
    done
    while true; do
        echo -ne "  ${BCYAN}❯${R} "
        read -r choice
        choice="${choice:-1}"
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#opts[@]} )); then
            MENU_RESULT="${opts[$((choice-1))]}"
            break
        fi
        warn "Enter a number between 1 and ${#opts[@]}"
    done
}

# Prompt with optional default — stores result in named variable
ask() {
    local label="$1"
    local default="$2"
    local out_var="$3"
    local hint=""
    [[ -n "$default" ]] && hint="${GRAY} [${default}]${R}"
    echo -ne "  ${BCYAN}❯${R} ${BWHITE}${label}${R}${hint}: "
    read -r input
    input="${input:-$default}"
    printf -v "$out_var" '%s' "$input"
}

# Yes/No confirm — returns 0=yes 1=no
confirm() {
    echo -ne "  ${BCYAN}❯${R} ${BWHITE}$1${R} ${GRAY}[Y/n]${R}: "
    read -r ans
    ans="${ans:-Y}"
    [[ "$ans" =~ ^[Yy]$ ]]
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Dependency Check
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
check_deps() {
    local missing=0
    echo ""
    echo -e "${BCYAN}  Checking dependencies...${R}"
    echo ""
    
    for cmd in avr-gcc avrdude avr-objcopy; do
        if command -v "$cmd" &>/dev/null; then
            ok "$cmd found: $(command -v "$cmd")"
        else
            err "$cmd NOT found. Install with: sudo apt install gcc-avr avr-libc binutils-avr avrdude"
            missing=1
        fi
    done
    
    if [[ $missing -eq 0 ]]; then
        echo ""
        ok "All dependencies installed!"
    fi
    echo ""
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Install / Uninstall / Check
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
if [[ "$1" == "--install" ]]; then
    echo -e "${CYAN}Installing avr_forge → ${INSTALL_PATH}${R}"
    sudo cp "$0" "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    ok "Installed. Run it anywhere with: avr_forge"
    exit 0
fi

if [[ "$1" == "--uninstall" ]]; then
    warn "Removing ${INSTALL_PATH} ..."
    sudo rm -f "$INSTALL_PATH"
    ok "Uninstalled."
    exit 0
fi

if [[ "$1" == "--check" ]]; then
    check_deps
    exit 0
fi

if [[ "$1" == "--version" || "$1" == "-v" ]]; then
    echo -e "${BCYAN}avr_forge${R} v${VERSION}"
    exit 0
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Header
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
clear
echo ""
echo -e "${BCYAN}  ╔════════════════════════════════════════════════════╗${R}"
echo -e "${BCYAN}  ║${R}         ${BWHITE}▲  AVR  FORGE  ·  Project Generator${R}  ${BCYAN}      ║${R}"
echo -e "${BCYAN}  ║${R}  ${GRAY}Firmware scaffold for AVR bare-metal development${R}${BCYAN}  ║${R}"
echo -e "${BCYAN}  ║${R}  ${GRAY}v${VERSION}${R}                                            ${BCYAN}║${R}"
echo -e "${BCYAN}  ╚════════════════════════════════════════════════════╝${R}"

DATE=$(date "+%Y-%m-%d")  
echo ""
echo -e "${GRAY}  Date: ${DATE}${R}"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 1 — Type
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "What are you creating?"
menu "type" "Project" "Lesson"
TYPE="$MENU_RESULT"

if [[ "$TYPE" == "Lesson" ]]; then
    PREFIX="lesson"
else
    PREFIX="project"
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 2 — Number (auto-detect + override)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Folder number"

NEXT=1
for d in "${PREFIX}"*/; do
    [[ -d "$d" ]] || continue
    num="${d#${PREFIX}_}"
    num="${num%/}"
    [[ "$num" =~ ^[0-9]+$ ]] && (( num >= NEXT )) && NEXT=$(( num + 1 ))
done
info "Scanned existing ${PREFIX}_* folders → next available: ${CYAN}${NEXT}${R}"
ask "Use this number (or type another)" "$NEXT" FOLDER_NUM
FOLDER_NAME="${PREFIX}_${FOLDER_NUM}"

if [[ -d "$FOLDER_NAME" ]]; then
    err "Directory '${FOLDER_NAME}' already exists. Choose a different number."
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 3 — Program name
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Program name"
info "This goes into the top comment of main.c"
ask "Program name" "" PROGRAM_NAME
[[ -z "$PROGRAM_NAME" ]] && err "Program name cannot be empty."

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 4 — Author (optional)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Author name  ${GRAY}(optional — press Enter to skip)${R}"
ask "Author" "" AUTHOR_NAME
[[ -z "$AUTHOR_NAME" ]] && AUTHOR_NAME="—"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 5 — MCU
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "MCU"
MCU_OPTS=(
    "ATmega328P  — 32KB Flash, 2KB RAM, most common (Arduino Uno)"
    "ATmega2560  — 256KB Flash, 8KB RAM, Arduino Mega"
    "ATmega32U4  — 32KB Flash, 2.5KB RAM, Arduino Leonardo"
    "ATmega16    — 16KB Flash, 1KB RAM, learning/education"
    "ATtiny85    — 8KB Flash, 512B RAM, tiny projects"
    "Custom      — type your own MCU"
)
menu "MCU" "${MCU_OPTS[@]}"

case "$MENU_RESULT" in
    *"ATmega328P"*)  MCU="atmega328p";  MCU_DISPLAY="ATmega328P" ;;
    *"ATmega2560"*)  MCU="atmega2560";  MCU_DISPLAY="ATmega2560" ;;
    *"ATmega32U4"*)  MCU="atmega32u4";  MCU_DISPLAY="ATmega32U4" ;;
    *"ATmega16"*)    MCU="atmega16";    MCU_DISPLAY="ATmega16" ;;
    *"ATtiny85"*)    MCU="attiny85";    MCU_DISPLAY="ATtiny85" ;;
    *"Custom"*)
        ask "MCU identifier (e.g. atmega128)" "" MCU
        MCU_DISPLAY="$MCU"
        ;;
esac

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 6 — Clock frequency
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Clock frequency"
menu "clock" "16 MHz  — Arduino Uno/Nano (default)" "8 MHz   — Internal oscillator" "1 MHz   — Low power / fuses" "Custom"
case "$MENU_RESULT" in
    *"16 MHz"*) F_CPU="16000000" ;;
    *"8 MHz"*)  F_CPU="8000000" ;;
    *"1 MHz"*)  F_CPU="1000000" ;;
    *"Custom"*)
        ask "CPU frequency in Hz" "16000000" F_CPU
        ;;
esac

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 7 — Programmer
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Programmer"
PROG_OPTS=(
    "arduino     — Arduino bootloader via serial (recommended)"
    "usbasp      — USBasp programmer (fast, no bootloader)"
    "stk500      — STK500 / USB-Serial"
    "Custom      — type your own"
)
menu "programmer" "${PROG_OPTS[@]}"

case "$MENU_RESULT" in
    *"arduino"*)  PROGRAMMER="arduino";  PROG_DISPLAY="arduino (bootloader)" ;;
    *"usbasp"*)   PROGRAMMER="usbasp";   PROG_DISPLAY="USBasp" ;;
    *"stk500"*)   PROGRAMMER="stk500";   PROG_DISPLAY="STK500" ;;
    *"Custom"*)
        ask "Programmer flag for avrdude" "" PROGRAMMER
        PROG_DISPLAY="$PROGRAMMER"
        ;;
esac

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 8 — Baud rate
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Baud rate"
menu "baud rate" "115200  — standard Arduino Uno/Nano" "57600   — Arduino Duemilanove / older Nano" "19200   — slower / long cables" "1000000 — fastest (USBasp)" "Custom"
case "$MENU_RESULT" in
    *"115200"*)    BAUDRATE="115200" ;;
    *"57600"*)     BAUDRATE="57600"  ;;
    *"19200"*)     BAUDRATE="19200"  ;;
    *"1000000"*)   BAUDRATE="1000000" ;;
    *"Custom"*)
        ask "Baud rate" "115200" BAUDRATE
        ;;
esac

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 9 — Port
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Serial port"

# Show detected ports as a hint
DETECTED=$(ls /dev/ttyUSB* /dev/ttyACM* 2>/dev/null | tr '\n' '  ')
if [[ -n "$DETECTED" ]]; then
    info "Detected ports: ${CYAN}${DETECTED}${R}"
else
    info "No serial ports detected (plug in your board first)"
fi

ask "Port" "/dev/ttyUSB0" PORT

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 10 — Git init?
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INIT_GIT=false
if command -v git &>/dev/null; then
    section "Git initialization"
    confirm "Initialize a git repository?" && INIT_GIT=true
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Summary
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ""
divider
echo -e "${BCYAN}  SUMMARY${R}"
divider
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Folder"      "$FOLDER_NAME"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Program"     "$PROGRAM_NAME"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Author"      "$AUTHOR_NAME"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Date"        "$DATE"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "MCU"         "$MCU_DISPLAY"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Clock"       "${F_CPU} Hz"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Programmer"  "$PROG_DISPLAY"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Baud rate"   "$BAUDRATE"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Port"        "$PORT"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Git init"    "$INIT_GIT"
divider
echo ""

confirm "Create project?" || { warn "Aborted."; echo ""; exit 0; }

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Generate files
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
mkdir -p "$FOLDER_NAME"

# ── main.c ────────────────────────────────────────────────────
cat > "$FOLDER_NAME/main.c" << EOF
/*************************************************
 * Program   : ${PROGRAM_NAME}
 * Author    : ${AUTHOR_NAME}
 * Date      : ${DATE}
 * MCU       : ${MCU_DISPLAY} @ ${F_CPU} Hz
 *
 * Description:
 *   [Add description here]
 *************************************************/

#define F_CPU ${F_CPU}UL  /* CPU frequency for delay functions */

#include <avr/io.h>
#include <util/delay.h>

int main(void) {

    /* Initialization */

    while (1) {

        /* Main loop */

    }

    return 0;
}
EOF

# ── Makefile ──────────────────────────────────────────────────
cat > "$FOLDER_NAME/Makefile" << EOF
# ─────────────────────────────────────────
#  ${PROGRAM_NAME}
#  Generated: ${DATE}
# ─────────────────────────────────────────

MCU        = ${MCU}
F_CPU      = ${F_CPU}
BAUDRATE   = ${BAUDRATE}
PORT       = ${PORT}
PROGRAMMER = ${PROGRAMMER}
TARGET     = ${FOLDER_NAME}
FUSES      = -U lock:w:0x3F:m -U efuse:w:0x05:m -U hfuse:w:0xDE:m -U lfuse:w:0xFF:m

# Compiler flags
CFLAGS     = -mmcu=\$(MCU) -DF_CPU=\$(F_CPU)UL -Wall -Os -std=c11
OBJCOPY    = avr-objcopy
SIZE       = avr-size

# ──── Build ──────────────────────────────
create: \$(TARGET).hex
	@echo ""
	@echo "  ✔️  Build successful!"
	@\$(SIZE) --mcu=\$(MCU) --format=avr \$(TARGET).elf

\$(TARGET).elf: main.c
	avr-gcc \$(CFLAGS) -o \$@ \$<

\$(TARGET).hex: \$(TARGET).elf
	\$(OBJCOPY) -j .text -j .data -O ihex \$< \$@

# ──── Upload ─────────────────────────────
upload: \$(TARGET).hex
	avrdude -p \$(MCU) -P \$(PORT) -b \$(BAUDRATE) -c \$(PROGRAMMER) -e -U flash:w:\$(TARGET).hex:v
	@echo ""
	@echo "  ✔️  Upload complete + verified!"

# ──── Fuses ──────────────────────────────
fuses:
	avrdude -p \$(MCU) -P \$(PORT) -b \$(BAUDRATE) -c \$(PROGRAMMER) \$(FUSES)

# ──── Read Fuses ─────────────────────────
fuses-read:
	avrdude -p \$(MCU) -P \$(PORT) -b \$(BAUDRATE) -c \$(PROGRAMMER) -U lfuse:r:-:h -U hfuse:r:-:h -U efuse:r:-:h

# ──── Erase Chip ─────────────────────────
erase:
	avrdude -p \$(MCU) -P \$(PORT) -b \$(BAUDRATE) -c \$(PROGRAMMER) -e
	@echo "  ✔️  Chip erased!"

# ──── Clean ──────────────────────────────
clean:
	rm -f *.elf *.hex *.eep *.lss *.map

# ──── Serial Monitor ─────────────────────
monitor:
	@echo "  Opening serial monitor on \$(PORT) @ \$(BAUDRATE) baud..."
	@echo "  Press Ctrl+A then K to exit (minicom) or Ctrl+C"
	minicom -D \$(PORT) -b \$(BAUDRATE)

# ──── Disassemble ────────────────────────
disasm: \$(TARGET).elf
	avr-objdump -d \$< > \$(TARGET).lss
	@echo "  Disassembly saved to \$(TARGET).lss"

.PHONY: create upload fuses fuses-read erase clean monitor disasm
EOF

# ── README.md ─────────────────────────────────────────────────
cat > "$FOLDER_NAME/README.md" << EOF
# ${PROGRAM_NAME}

> Generated by **AVR Forge** on ${DATE}

## 📋 Info

| Field    | Value              |
|----------|--------------------|
| MCU      | ${MCU_DISPLAY}     |
| Clock    | ${F_CPU} Hz        |
| Programmer | ${PROG_DISPLAY} |
| Baud     | ${BAUDRATE}        |

## 🔧 Build & Flash

\`\`\`bash
make create     # compile
make upload     # flash to board + verify
make clean      # remove build artifacts
\`\`\`

## 🛠️ Other Commands

\`\`\`bash
make fuses       # set fuses
make fuses-read  # read current fuses
make erase       # erase chip
make monitor     # open serial monitor
make disasm      # generate disassembly
\`\`\`

## 📝 Description

[Add your description here]
EOF

# ── .gitignore ────────────────────────────────────────────────
if [[ "$INIT_GIT" == true ]]; then
    cat > "$FOLDER_NAME/.gitignore" << 'EOF'
*.elf
*.hex
*.eep
*.lss
*.map
*.o
*.d
*.map
EOF
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Git Init (optional)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
if [[ "$INIT_GIT" == true ]]; then
    (cd "$FOLDER_NAME" && git init -q && git add -A && git commit -q -m "Initial scaffold: ${PROGRAM_NAME}")
    ok "Git repo initialized with initial commit"
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Done
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ""
ok "Scaffold created successfully!"
echo ""
echo -e "  ${CYAN}${FOLDER_NAME}/${R}"
echo -e "  ${GRAY}├── main.c${R}"
echo -e "  ${GRAY}├── Makefile${R}"
echo -e "  ${GRAY}├── README.md${R}"
[[ "$INIT_GIT" == true ]] && echo -e "  ${GRAY}├── .gitignore${R}"
echo ""
echo -e "  ${BWHITE}Next steps:${R}"
echo -e "  ${GRAY}cd ${FOLDER_NAME}${R}"
echo -e "  ${GRAY}make create    ${DIM}# compile + show size${R}"
echo -e "  ${GRAY}make upload    ${DIM}# flash to board + verify${R}"
echo -e "  ${GRAY}make monitor   ${DIM}# open serial monitor${R}"
echo ""
echo -e "${BCYAN}  ══════════════════════════════════════════════════${R}"
echo ""