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
    sei();                  // Enable global interrupts
    TIMSK1 |= (1 << TOIE1); // Enable Timer1 overflow interrupt

    // Set Modes of timer1 to normal mode
    TCCR1A = 0;
    TCCR1B = 0;

    while (1)
    {
    }

    return 0;
}
