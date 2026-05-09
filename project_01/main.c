#define F_CPU 16000000UL // Define CPU frequency for delay functions

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB = 0xFF;
    DDRD = 0xFF;

    // simple LCG pseudo-random generator
    static unsigned long seed = 0xDEADBEEF;
    auto_rand:
    while (1)
    {
        // LCG: seed = (a*seed + c) mod 2^32
        seed = seed * 1664525UL + 1013904223UL;
        // use different bytes for PORTD and PORTB
        PORTD = (uint8_t)(seed >> 8);
        PORTB = (uint8_t)(seed >> 16);
        _delay_ms(10);
    }

    return 0;
}
