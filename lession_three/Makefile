MCU        = atmega328p
BAUDRATE   = 115200
PORT       = /dev/ttyUSB0
PROGRAMMER = stk500
TARGET     = lession_three
FUSES      = -U lock:w:0x3F:m -U efuse:w:0x05:m -U hfuse:w:0xDE:m -U lfuse:w:0xFF:m

create:
	avr-gcc -mmcu=$(MCU) -Wall -Os -o $(TARGET).elf main.c
	avr-objcopy -j .text -j .data -O ihex $(TARGET).elf $(TARGET).hex

upload:
	avrdude -p $(MCU) -P $(PORT) -b $(BAUDRATE) -c $(PROGRAMMER) -e -U flash:w:$(TARGET).hex

fuses:
	avrdude -p $(MCU) -P $(PORT) -b $(BAUDRATE) -c $(PROGRAMMER) $(FUSES)

clean:
	rm -f *.elf *.hex
