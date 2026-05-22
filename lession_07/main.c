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

int main(void)
{
    // PB0 output
    DDRB |= (1 << DDB0);
    // PD2 and PD3 input
    DDRD &= ~((1 << DDD2) | (1 << DDD3));
    // Enable internal pull-up resistors
    PORTD |= (1 << PD2) | (1 << PD3);
    // Falling edge trigger
    EICRA |= (1 << ISC01) | (1 << ISC11) | (1 << ISC00) | (1 << ISC10);
    // EICRA &= ~((1 << ISC00) | (1 << ISC10));
    // Enable INT0 and INT1
    EIMSK |= (1 << INT0) | (1 << INT1);
    // Enable global interrupts
    sei();
    while (1)
    {
    }

    return 0;
}
