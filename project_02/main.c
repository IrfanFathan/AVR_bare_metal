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
    DDRB |= (1 << DDB5); // Set PB5 as output (LED pin)
    while (1)
    {
        PORTB |= (1 << PB5);
        _delay_ms(1000);
        PORTB &= ~(1 << PB5);
    }

    return 0;
}
