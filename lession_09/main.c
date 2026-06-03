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
#include <avr/interrupt.h>

// globle variables
uint8_t a, b, c, d, e, f;
uint8_t first_digit, second_digit, third_digit, fourth_digit, fifth_digit;
uint8_t captured;

int main(void)
{
    DDRC = 0xFF;                                     // LCD data bus on Port C
    DDRB |= (1 << DDB0) | (1 << DDB1) | (1 << DDB2); // Control pins on PB0-PB2

    // ENBLE GLOBEL INTERRUPT BIT
    sei();
    // ENBLE REQUIRED TIMER INTERRUPT
    TIMSK1 |= (1 << ICIE1);
    //    TIMER MODE IN NORMAL
    TCCR1A &= (~(1 << WGM10)) & (~(1 << WGM11));
    TCCR1B &= (~(1 << WGM12)) & (~(1 << WGM13));
    // SET  PRESCALER AT 1024
    TCCR1B |= (1 << CS10) | (1 << CS12);
    TCCR1B &= ~(1 << CS11);

    // SET CAPTURE
    TCCR1B |= (1 << ICR1);

    lcd_initiaise();
    lcd_cmd(0x80);
    lcd_string("INPUT CAPTURED:", 14);
    while (1)
    {
        lcd_cmd(0xC0);

        a = captured / 10;
        b = a / 10;
        c = b / 10;

        fifth_digit = captured % 10;
        fourth_digit = a % 10;
        third_digit = b % 10;
        second_digit = c % 10;
        first_digit = c / 10;
    }

    return 0;
}

void lcd_data(unsigned char data)
{
    PORTC = data;         // Place character data on data bus (Port D)
    PORTB |= (1 << PB0);  // Set RS high to select data register mode
    PORTB &= ~(1 << PB1); // Set RW low for write operation
    PORTB |= (1 << PB2);  // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB2); // Set E low to complete the write cycle
}

void lcd_cmd(unsigned char command)
{
    PORTC = command;      // Place command byte on data bus (Port D)
    PORTB &= ~(1 << PB0); // Clear RS to select instruction register mode
    PORTB &= ~(1 << PB1); // Set RW low for write operation
    PORTB |= (1 << PB2);  // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB2); // Set E low to complete the write cycle
}

void lcd_string(const unsigned char *str, unsigned char length)
{
    for (char i = 0; i < length; i++) // Send each character one by one
    {
        lcd_data(str[i]);
    }
}

void lcd_initiaise()
{
    lcd_cmd(0x38); // 8-bit, 2-line display, 5x8 font
    lcd_cmd(0x06); // Increment cursor after each character
    lcd_cmd(0x0c); // Display on, cursor off
    lcd_cmd(0x01); // Clear the display
}