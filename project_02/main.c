/*************************************************
 * Program   : [Project Name]
 * Author    : [Author Name]
 * Date      : [Date]
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * This is a template for an AVR microcontroller project using the ATmega328P.
 *************************************************/

#define F_CPU 16000000UL // Define CPU frequency for delay functions

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB = 0xFF; // Set all pins on PORTB as output
    unsigned char values[] = {0x00, 0x80, 0xC0, 0xE0, 0xF0,
                              0xF8, 0xFC, 0xFE, 0xFF};
    uint8_t count = sizeof(values) / sizeof(values[0]);
    while (1)
    {
        for (uint16_t i = 0; i < count; i++)
        {
            PORTB = values[i];
            _delay_ms(500);
        }
        _delay_us(1000);
        for (int16_t i = count - 1; i >= 0; i--)
        {
            PORTB = values[i];
            _delay_ms(500);
        }
        _delay_us(1000);
    }

    return 0;
}
