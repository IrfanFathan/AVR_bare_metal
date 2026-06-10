/*************************************************
 * Program   : PWM Program
 * Author    : Irfan Fathan
 * Date      : 2026-06-05
 * MCU       : ATmega328P @ 16 MHz
 *
 * Description:
 *
 *************************************************/

#define F_CPU 16000000UL /* CPU frequency for delay functions */

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    // ENABLE TIMER MODE AS PWM 10 bit MODE
    TCCR1A |= (1 << WGM10) | (1 << WGM11);
    TCCR1B |= (1 << WGM12);
    TCCR1B &= ~(1 << WGM13);

    // SET PWM MODE TO NON INVERTING MODE
    TCCR1A |= (1 << COM1A1);
    TCCR1A &= ~(1 << COM1A0);

    // SET PRESCALER
    // 16 MHZ / 205KHZ = 16
    TCCR1B |= (1 << CS10) | (1 << CS11);
    // TCCR1B &= (1 << CS12); => no needed to write this line because the bit is already 0

    // SETING THE OUTPUT COMPARING PIN AS DDb5 (OC1A)
    DDRB |= (1 << DDB1);

    // // SET DUTY CYCLE TO 50%
    // OCR1A = 512; // 50% of 1023 (10-bit resolution)

    while (1)
    {

        for (uint16_t i = 0; i < 1024; i++)
        {
            OCR1A = i;
            _delay_ms(2);
        }
        _delay_ms(2000);
        for (int16_t i = 1024; i > 0; i--)
        {
            OCR1A = i;
            _delay_ms(2);
        }
        _delay_ms(2000);
    }

    return 0;
}
