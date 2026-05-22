#!/bin/bash

# ╔══════════════════════════════════════════════════════════════╗
# ║              AVR FORGE  ·  Project Generator                 ║
# ║  Run with --install   →  installs system-wide as: avr_forge  ║
# ║  Run with --uninstall →  removes system-wide install         ║
# ╚══════════════════════════════════════════════════════════════╝

INSTALL_PATH="/usr/local/bin/avr_forge"

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

ok()   { echo -e "${BGREEN}  ✔  ${WHITE}$1${R}"; }
err()  { echo -e "${RED}  ✘  ${WHITE}$1${R}" >&2; exit 1; }
warn() { echo -e "${YELLOW}  ⚠  ${WHITE}$1${R}"; }
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
#  Install / Uninstall
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

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Header
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
clear
echo ""
echo -e "${BCYAN}  ╔══════════════════════════════════════════════════╗${R}"
echo -e "${BCYAN}  ║${R}         ${BWHITE}▲  AVR  FORGE  ·  Project Generator${R}  ${BCYAN}       ║${R}"
echo -e "${BCYAN}  ║${R}  ${GRAY}Firmware scaffold for AVR bare-metal development${R}  ${BCYAN}║${R}"
echo -e "${BCYAN}  ╚══════════════════════════════════════════════════╝${R}"

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
    PREFIX="lession"
else
    PREFIX="project"
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 2 — Number (auto-detect + override)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Folder number"

NEXT=1
for d in "${PREFIX}_"*/; do
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
MCU_OPTS=("ATmega328P  — 32KB Flash, UART/SPI/I2C, most common")
menu "MCU" "${MCU_OPTS[@]}"
MCU_DISPLAY="ATmega328P"
MCU="atmega328p"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 6 — Programmer
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Programmer"
PROG_OPTS=("arduino     — Arduino bootloader via serial (recommended)")
menu "programmer" "${PROG_OPTS[@]}"
PROGRAMMER="arduino"
PROG_DISPLAY="arduino (bootloader)"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 7 — Baud rate
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Baud rate"
info "Used by avrdude for flashing. 115200 is standard for Arduino bootloader."
menu "baud rate" "115200  — standard Arduino Uno/Nano" "57600   — Arduino Duemilanove / older Nano" "19200   — slower / long cables"
case "$MENU_RESULT" in
    "115200"*) BAUDRATE="115200" ;;
    "57600"*)  BAUDRATE="57600"  ;;
    "19200"*)  BAUDRATE="19200"  ;;
esac

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Step 8 — Port
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
section "Serial port"

# Show detected ports as a hint
DETECTED=$(ls /dev/ttyUSB* /dev/ttyACM* 2>/dev/null | tr '\n' '  ')
if [[ -n "$DETECTED" ]]; then
    info "Detected ports: ${CYAN}${DETECTED}${R}"
fi

ask "Port" "/dev/ttyUSB0" PORT

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
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Programmer"  "$PROG_DISPLAY"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Baud rate"   "$BAUDRATE"
printf "  ${GRAY}%-14s${R}  ${BWHITE}%s${R}\n"  "Port"        "$PORT"
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
 * MCU       : ${MCU_DISPLAY} @ 16 MHz
 *
 * Description:
 *   [Add description here]
 *************************************************/

#define F_CPU 16000000UL  /* CPU frequency for delay functions */

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
BAUDRATE   = ${BAUDRATE}
PORT       = ${PORT}
PROGRAMMER = ${PROGRAMMER}
TARGET     = ${FOLDER_NAME}
FUSES      = -U lock:w:0x3F:m -U efuse:w:0x05:m -U hfuse:w:0xDE:m -U lfuse:w:0xFF:m

create:
	avr-gcc -mmcu=\$(MCU) -Wall -Os -o \$(TARGET).elf main.c
	avr-objcopy -j .text -j .data -O ihex \$(TARGET).elf \$(TARGET).hex

upload:
	avrdude -p \$(MCU) -P \$(PORT) -b \$(BAUDRATE) -c \$(PROGRAMMER) -e -U flash:w:\$(TARGET).hex

fuses:
	avrdude -p \$(MCU) -P \$(PORT) -b \$(BAUDRATE) -c \$(PROGRAMMER) \$(FUSES)

clean:
	rm -f *.elf *.hex
EOF

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Done
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ""
ok "Scaffold created successfully!"
echo ""
echo -e "  ${CYAN}${FOLDER_NAME}/${R}"
echo -e "  ${GRAY}├── main.c${R}"
echo -e "  ${GRAY}└── Makefile${R}"
echo ""
echo -e "  ${BWHITE}Next steps:${R}"
echo -e "  ${GRAY}cd ${FOLDER_NAME}${R}"
echo -e "  ${GRAY}make create    ${DIM}# compile${R}"
echo -e "  ${GRAY}make upload    ${DIM}# flash to board${R}"
echo ""
echo -e "${BCYAN}  ══════════════════════════════════════════════════${R}"
echo ""