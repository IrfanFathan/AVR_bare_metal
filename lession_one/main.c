#define F_CPU 16000000UL // 16 MHz clock speed

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB |= (1 << PB5);   // configure pin as output

    while(1)
    {
        PORTB ^= (1 << PB5); // toggle LED
        _delay_ms(500);
        PORTB ^=(0 << PB5); // turn off LED
        _delay_ms(500);
    }
}