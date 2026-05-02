/*************************************************
 * Program   : LED Blink
 * Author    : Irfan Fathan M
 * Date      : 02 May 2026
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * Blinks an LED connected to PB0 with 1s delay.
 *************************************************/

#define F_CPU 16000000UL // 16 MHz clock speed

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB |= (1 << PB0);   ///In Port B , 0th set as the output 

    while(1)
    {
       PORTB |=(1<<PB0); // 
       _delay_ms(1000);
       PORTB &=(~(1<<PB0));
       _delay_ms(1000);
    }
}