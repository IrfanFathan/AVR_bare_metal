/*************************************************
 * Program   : External Interrupt Control
 * Author    : Irfan Fathan M
 * Date      : 09 May 2026
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * Uses INT0 to set PB0 high and INT1 to clear PB0 on external interrupts.
 *************************************************/

#define F_CPU 16000000UL // Define CPU frequency for delay functions

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
int main(void)
{

    DDRB |= (1 << DDB0);                // Set PB0 as output
    sei();                              // Enable global interrupts
    EIMSK |= (1 << INT0) | (1 << INT1); // Enable external interrupts INT0 and INT1
    // Configure INT0 and INT1 for rising-edge triggering.
    MCUCR |= (1 << ISC11) | (1 << ISC10) | (1 << ISC01) | (1 << ISC00);
    while (1)
    {
    }

    return 0;
}
ISR(INT0_vect)
{
    // INT0 turns the output on.
    PORTB |= (1 << PB0);
}

ISR(INT1_vect)
{
    // INT1 turns the output off.
    PORTB &= ~(1 << PB0);
}
