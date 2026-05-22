/*************************************************
 * Program   : Timer1 Overflow LED Blink
 * Author    : Irfan Fathan
 * Date      : 22 May 2026
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * Blink onboard LED using Timer1 overflow
 * interrupt every 1 second.
 *************************************************/

#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>

// Timer1 Overflow Interrupt Service Routine
ISR(TIMER1_OVF_vect)
{
    // Reload timer value for 1 second delay
    TCNT1 = 49911;

    // Toggle PB5 (Arduino Uno onboard LED)
    PORTB ^= (1 << PORTB5);
}

int main(void)
{
    // Set PB5 as output
    DDRB |= (1 << DDB5);

    // Timer1 Normal Mode
    TCCR1A = 0;
    TCCR1B = 0;

    // Preload timer for 1 second
    TCNT1 = 49911;

    // Set prescaler to 1024
    TCCR1B |= (1 << CS12) | (1 << CS10);

    // Enable Timer1 Overflow Interrupt
    TIMSK1 |= (1 << TOIE1);

    // Enable global interrupts
    sei();

    while (1)
    {
        // Main loop empty
    }

    return 0;
}