/*************************************************
 * Program   : LED Button Control
 * Author    : Irfan Fathan M
 * Date      : 06 May 2026
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * Turns LED on PB0 on/off based on button input on PD0.
 *************************************************/

#define F_CPU 16000000UL // 16 MHz clock speed
#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB |= (1 << DDB0);  // Set PB0 as output
    DDRD &= ~(1 << DDD0); // Set PD0 as input

    while (1)
    {
        if (PIND & (1 << PIND0)) // Check if the button connected to PD0 is pressed
        {
            PORTB |= (1 << PB0); // Turn on the LED connected to PB0
        }
        else
        {
            PORTB &= ~(1 << PB0); // Turn off the LED connected to PB0
        }
    }

    return 0;
}
