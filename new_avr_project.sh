#!/bin/bash

# ─────────────────────────────────────────
#  AVR Project Generator
#  Run once with --install to make it
#  available system-wide as: new_avr_project
# ─────────────────────────────────────────

INSTALL_PATH="/usr/local/bin/new_avr_project"

# ── Self-install mode ──────────────────────
if [[ "$1" == "--install" ]]; then
    echo "Installing to $INSTALL_PATH ..."
    sudo cp "$0" "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    echo "Done! You can now run: new_avr_project"
    exit 0
fi

# ── Uninstall mode ─────────────────────────
if [[ "$1" == "--uninstall" ]]; then
    echo "Removing $INSTALL_PATH ..."
    sudo rm -f "$INSTALL_PATH"
    echo "Uninstalled."
    exit 0
fi

# ─────────────────────────────────────────
echo "================================"
echo "   AVR Project Generator"
echo "================================"
echo ""

# Ask for project name
read -p "Project name: " PROJECT_NAME

if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: Project name cannot be empty."
    exit 1
fi

if [[ -d "$PROJECT_NAME" ]]; then
    echo "Error: Directory '$PROJECT_NAME' already exists."
    exit 1
fi

# Ask for config (with defaults)
read -p "MCU        [atmega328p]: " MCU
MCU=${MCU:-atmega328p}

read -p "Baudrate   [115200]: " BAUDRATE
BAUDRATE=${BAUDRATE:-115200}

read -p "Port       [/dev/ttyUSB0]: " PORT
PORT=${PORT:-/dev/ttyUSB0}

read -p "Programmer [stk500]: " PROGRAMMER
PROGRAMMER=${PROGRAMMER:-stk500}

# ── Create project folder ──────────────────
mkdir -p "$PROJECT_NAME"

# ── main.c ─────────────────────────────────
cat > "$PROJECT_NAME/main.c" << 'EOF'
#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    // Configure PB5 (Arduino pin 13) as output
    DDRB |= (1 << PB5);

    while (1) {
        PORTB |= (1 << PB5);   // LED ON
        _delay_ms(500);
        PORTB &= ~(1 << PB5);  // LED OFF
        _delay_ms(500);
    }

    return 0;
}
EOF

# ── Makefile ───────────────────────────────
cat > "$PROJECT_NAME/Makefile" << EOF
MCU        = $MCU
BAUDRATE   = $BAUDRATE
PORT       = $PORT
PROGRAMMER = $PROGRAMMER
TARGET     = $PROJECT_NAME
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

# ── Done ───────────────────────────────────
echo ""
echo "Project '$PROJECT_NAME' created!"
echo ""
echo "${PROJECT_NAME}/"
echo "├── main.c"
echo "└── Makefile"
echo ""
echo "  cd $PROJECT_NAME && make create"
echo ""