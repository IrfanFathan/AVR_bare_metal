/*************************************************
 * Program   : UART
 * Author    : —
 * Date      : 2026-06-13
 * MCU       : ATmega328P @ 16000000 Hz
 *
 * Description:
 *   [Add description here]
 *************************************************/

#define F_CPU 16000000UL /* CPU frequency for delay functions */

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

int main(void)
{

    // ENABLE GLOBEL INTRRUPT
    sei();

    // ENABLE TX AND RX
    UCSR0B |= (1 << RXEN0) | (1 << TXEN0); // enabled the rx and tx
    UCSR0B |= (1 << RXC0);                 // enabled RX complete intrrupt (ONLY RECIVIE DATA ONLY)

    // SETING THE DATA SIZE
    // here we uses 8 bit data size [ UCSZn2(0),UCSZn1(1),UCSZn0(1)]
    UCSR0B &= ~(1 << UCSZ02);
    UCSR0C |= (1 << UCSZ01) | (1 << UCSZ00);

    // SET BRAUD RATE SPEED
    UCSR0A |= (1 << U2X0); // 8-bit data transmission

    // SET BRAUD RATE
    UBRR0L = 16; // using bruad rate in 115200
    UBRR0H = 0;

    while (1)
    {

        /* Main loop */
    }

    return 0;
}

// UART ISR INTERRUPT
uint8_t data;
ISR(USART_RX_vect)
{
    UDR0 = data;
}