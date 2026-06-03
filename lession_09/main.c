/*************************************************
 * Program   : [Project Name]
 * Author    : [Author Name]
 * Date      : [Date]
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * This program to demonstrate to timer caputre mode in ATmeage328o.
 *************************************************/

#define F_CPU 16000000UL // Define CPU frequency for delay functions

#include <avr/io.h>
#include <util/delay.h>

//

int main(void)
{

    // ENBLE GLOBEL INTERRUPT BIT
    sei();
    // ENBLE REQUIRED TIMER INTERRUPT
    TIMSK1 |= (1 << ICIE1);
    //    TIMER MODE IN NORMAL
    TCCR0A &= (~(1 << WGM10)) & (~(1 << WGM11));
    TCCR0B &= (~(1 << WGM12)) & (~(1 << WGM13));
    // SET  PRESCALER AT 1024
    TCCR0B |= (1 << CS10) | (1 << CS12);
    TCCR0B &= ~(1 << CS11);

    // SET CAPTURE 
    TCCR0B |=(1<<ICR1);
    while (1)
    {
    }

    return 0;
}

