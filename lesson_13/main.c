/*************************************************
 * Program   : UART
 * Author    : —
 * Date      : 2026-06-13
 * MCU       : ATmega328P @ 16000000 Hz
 *
 * Description:
 *   Simple UART remote LED control: receives characters via USART RX interrupt
 *   - 'a' turns the LED on (PORTB0)
 *   - 'b' turns the LED off (PORTB0)
 *   Uses 8N1, double speed (U2X0) and 115200 baud at 16 MHz.
 *************************************************/

#define F_CPU 16000000UL /* CPU frequency for delay functions */

#include <avr/io.h>
#include <avr/interrupt.h>

uint8_t data;

int main(void)
{

    // ENABLE GLOBEL INTRRUPT
    sei();

    // ENABLE TX AND RX
    UCSR0B |= (1 << RXEN0) | (1 << TXEN0); // enabled the rx and tx
    // UCSR0B |= (1 << RXC0);                 // enabled RX complete intrrupt (ONLY RECIVIE DATA ONLY)
    UCSR0B |= (1 << RXCIE0); // enabled RX complete intrrupt (RECIVIE DATA AND CALL THE ISR)

    // SET THE DATA SIZE
    // here we uses 8 bit data size [ UCSZn2(0),UCSZn1(1),UCSZn0(1)]
    UCSR0B &= ~(1 << UCSZ02);
    UCSR0C |= (1 << UCSZ01) | (1 << UCSZ00);

    // SET BRAUD RATE SPEED
    UCSR0A |= (1 << U2X0); // 8-bit data transmission

    // SET BRAUD RATE
    UBRR0L = 16; // using bruad rate in 115200
    UBRR0H = 0;

    // seting the B0 as the LED output pin
    DDRB |= (1 << DDB0);

    while (1)
    {
        // Turn the LED on when 'a' is received over UART.
        if (data == 'a')
        {
            PORTB |= (1 << PB0);
        }
        // Turn the LED off when 'b' is received over UART.
        else if (data == 'b')
        {
            PORTB &= (~(1 << PB0));
        }
    }
    return 0;
}

// UART ISR INTERRUPT

ISR(USART_RX_vect)
{
    /* Read the received byte from the UART data register.
       Reading UDR0 clears the RX complete flag. */
    data = UDR0;

    /* Wait until the USART Data Register is empty (ready to transmit). */
    while (!(UCSR0A & (1 << UDRE0)))
        ;

    /* Echo the received character back by writing it to UDR0. */
    UDR0 = data;
}