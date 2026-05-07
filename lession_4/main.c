/*************************************************
 * Program   : LCD Display Control
 * Author    : Irfan Fathan M
 * Date      : 7 May 2026
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * LCD interface control with data and command functions.
 * Sends data and commands to LCD via Port D and control pins on Port B.
 *************************************************/

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>

void lcd_data(unsigned char data)
{
    // Put character data on the LCD data bus.
    PORTD = data;
    // RS=1 selects data register, RW=0 writes to LCD.
    PORTB |= (1 << PB0);
    PORTB |= (1 << PB1);
    // Toggle E to latch the byte into the LCD.
    PORTB &= ~(1 << PB2);
    _delay_ms(10);
    PORTB |= (1 << PB2);
};

void lcd_cmd(unsigned char command)
{
    // Put command byte on the LCD data bus.
    PORTD = command;
    // RS=0 selects instruction register, RW=0 writes to LCD.
    PORTB &= ~(1 << PB0);
    PORTB |= (1 << PB1);
    // Toggle E to execute the command.
    PORTB &= ~(1 << PB2);
    _delay_ms(10);
    PORTB |= (1 << PB2);
}

void lcd_string(unsigned char *str, unsigned char length)
{
    char i = 0;
    // Send each character in the buffer one by one.
    for (i = 0; i < length; i++)
    {
        lcd_data(str[i]);
    }
};

void lcd_initiaise()
{
    // 8-bit, 2-line display, 5x8 font.
    lcd_cmd(0x38);
    // Increment cursor after each character.
    lcd_cmd(0x06);
    // Display on, cursor off.
    lcd_cmd(0x0c);
    // Clear the display.
    lcd_cmd(0x01);
};
int main(void)
{

    DDRD = 0xFF;                                     // LCD data bus on Port D.
    DDRB |= (1 << DDB0) | (1 << DDB1) | (1 << DDB2); // Control pins on PB0-PB2.

    while (1)
    {
    }

    return 0;
}
