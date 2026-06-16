# ─────────────────────────────────────────
#  I2C Programming
#  Generated: 2026-06-16
# ─────────────────────────────────────────

MCU        = atmega328p
F_CPU      = 16000000
BAUDRATE   = 115200
PORT       = /dev/ttyUSB0
PROGRAMMER = arduino
TARGET     = lesson_15
FUSES      = -U lock:w:0x3F:m -U efuse:w:0x05:m -U hfuse:w:0xDE:m -U lfuse:w:0xFF:m

# Compiler flags
CFLAGS     = -mmcu=$(MCU) -DF_CPU=$(F_CPU)UL -Wall -Os -std=c11
OBJCOPY    = avr-objcopy
SIZE       = avr-size

# ──── Build ──────────────────────────────
create: $(TARGET).hex
	@echo ""
	@echo "  ✔️  Build successful!"
	@$(SIZE) --mcu=$(MCU) --format=avr $(TARGET).elf

$(TARGET).elf: main.c
	avr-gcc $(CFLAGS) -o $@ $<

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

# ──── Upload ─────────────────────────────
upload: $(TARGET).hex
	avrdude -p $(MCU) -P $(PORT) -b $(BAUDRATE) -c $(PROGRAMMER) -e -U flash:w:$(TARGET).hex:v
	@echo ""
	@echo "  ✔️  Upload complete + verified!"

# ──── Fuses ──────────────────────────────
fuses:
	avrdude -p $(MCU) -P $(PORT) -b $(BAUDRATE) -c $(PROGRAMMER) $(FUSES)

# ──── Read Fuses ─────────────────────────
fuses-read:
	avrdude -p $(MCU) -P $(PORT) -b $(BAUDRATE) -c $(PROGRAMMER) -U lfuse:r:-:h -U hfuse:r:-:h -U efuse:r:-:h

# ──── Erase Chip ─────────────────────────
erase:
	avrdude -p $(MCU) -P $(PORT) -b $(BAUDRATE) -c $(PROGRAMMER) -e
	@echo "  ✔️  Chip erased!"

# ──── Clean ──────────────────────────────
clean:
	rm -f *.elf *.hex *.eep *.lss *.map

# ──── Serial Monitor ─────────────────────
monitor:
	@echo "  Opening serial monitor on $(PORT) @ $(BAUDRATE) baud..."
	@echo "  Press Ctrl+A then K to exit (minicom) or Ctrl+C"
	minicom -D $(PORT) -b $(BAUDRATE)

# ──── Disassemble ────────────────────────
disasm: $(TARGET).elf
	avr-objdump -d $< > $(TARGET).lss
	@echo "  Disassembly saved to $(TARGET).lss"

.PHONY: create upload fuses fuses-read erase clean monitor disasm
