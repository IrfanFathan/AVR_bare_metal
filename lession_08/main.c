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
#include <avr/interrupt.h>

ISR(TIMER1_OVF_vect)
{
    // Reload value for 1 second
    TCNT1 = 49911;

    // Toggle LED
    PORTB ^= (1 << PORTB5);
}

int main(void)
{
    // enable global interrupt bit
    sei();
    // enable required timer interrupt
    TIMSK1 |= (1 << TOIE1);
    // set mode of timer to normal mode
    TCCR1A &= ~((1 << WGM10) | (1 << WGM11));
    TCCR1B &= ~((1 << WGM12) | (1 << WGM13));
    // set prescaler to 1024
    TCCR1B |= (1 << CS10) | (1 << CS12);
    TCCR1B &= ~(1 << CS11);
    // load prefers for it to generate interrupt every 1 second
    TCNT1 = 0;
    OCR1A = 49910;       // 16,000,000 / 1024 = 15625
    DDRB |= (1 << DDB5); // Set PB5 as output (built-in LED on many AVR boards)

    while (1)
    {
        // Main loop can be used for other tasks while timer interrupt handles LED toggling
    }

    return 0;
}
