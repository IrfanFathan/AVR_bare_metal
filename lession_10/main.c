/*************************************************
 * Program   : Timer output compare mode example
 * Author    : Irfan fathan
 * Date      : 2026-05-22
 * MCU       : ATmega328P @ 16 MHz
 *
 * Description:
 *   This program demonstrates the use of Timer1 in output compare mode to generate a PWM signal on OC1A (Pin 9).
 *************************************************/

#define F_CPU 16000000UL /* CPU frequency for delay functions */

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

int main(void)
{

    // ENABLE GLOBEL INTERRUPT BIT
    sei();

    // ENABLE REQUIRED TIMER INTERRUPT
    TIMSK1 |= (1 << OCIE1A);

    // TIMER MODE IN NORMAL
    TCCR1A &= ~(1 << WGM10) & ~(1 << WGM11);
    TCCR1B &= ~(1 << WGM12) & ~(1 << WGM13);

    // TOGGLE OC1A ON COMPARE MATCH
    TCCR1A |= (1 << COM1A0);
    TCCR1A &= ~(1 << COM1A1);

    // SET PRESCALER TO 1024
    TCCR1B |= (1 << CS12) | (1 << CS10);
    TCCR1B &= ~(1 << CS11);

    // INITIAL VALUE FOR TIMER COUNTER
    TCNT1 = 0;

    // SET OUTPUT COMPARE VALUE FOR 1 SECOND DELAY
    OCR1A = 15624; // (16,000,000 / (1024 * 1)) - 1

    DDRB |= (1 << DDB1); // Set PB1 (OC1A pin) as output

    while (1)
    {
    }

    return 0;
}
ISR(TIMER1_COMPA_vect)
{
    TCNT1 = 0;
    // SET OUTPUT COMPARE VALUE FOR 1 SECOND DELAY
    OCR1A = 15624; // (16,000,000 / (1024 * 1)) - 1
}
