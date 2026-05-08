/*************************************************
 * Program   : LCD Display Control
 * Author    : Irfan Fathan M
 * Date      : 8 May 2026
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * LCD interface control with data and command functions in 4-bit mode.
 * Sends data and commands to LCD via Port D and control pins on Port B.
 *************************************************/

#define F_CPU 16000000UL // Define CPU frequency for delay functions

#include <avr/io.h>
#include <util/delay.h>

void lcd_data(unsigned char data)
{
    PORTB = (data & 0xF0); // Place upper 4 bits of data on Port B
    PORTB |= (1 << PB0);   // Set RS high to select data register mode
    PORTB &= ~(1 << PB1);  // Set RW low for write operation
    PORTB |= (1 << PB2);   // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB2);       // Set E low to complete the write cycle
    PORTD = (data << 4) & 0xF0; // Place lower 4 bits of data on Port D
    PORTB |= (1 << PB0);        // Set RS high to select data register mode
    PORTB &= ~(1 << PB1);       // Set RW low for write operation
    PORTB |= (1 << PB2);        // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB2);
}

void lcd_cmd(unsigned char command)
{
    PORTB = (command & 0xF0); // Place upper 4 bits of command on Port B
    PORTB &= ~(1 << PB0);     // Clear RS to select instruction register mode
    PORTB &= ~(1 << PB1);     // Set RW low for write operation
    PORTB |= (1 << PB2);      // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB2);          // Set E low to complete the write cycle
    PORTD = (command << 4) & 0xF0; // Place lower 4 bits of command on Port D
    PORTB &= ~(1 << PB0);          // Clear RS to select instruction register mode
    PORTB &= ~(1 << PB1);          // Set RW low for write operation
    PORTB |= (1 << PB2);           // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB2);
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
    _delay_ms(50); // Wait for LCD to power up
    lcd_cmd(0x33); // Initialize LCD in 4-bit mode
    lcd_cmd(0x32); // Set to 4-bit mode
    lcd_cmd(0x28); // 2-line display, 5x8 font
    lcd_cmd(0x06); // Increment cursor after each character
    lcd_cmd(0x0C); // Display on, cursor off
    lcd_cmd(0x01); // Clear the display
}

int main(void)
{
    DDRD = 0xFF;                                     // LCD data bus on Port D
    DDRB |= (1 << DDB0) | (1 << DDB1) | (1 << DDB2); // Control pins on PB0-PB2
    lcd_initiaise();                                 // Initialize LCD settings

    while (1)
    {
        lcd_cmd(0x80);             // Move cursor to first line start
        lcd_string("Irfan", 5);    // Display "Irfan" on first line
        lcd_cmd(0xC0);             // Move cursor to second line start
        lcd_string("Fathan M", 8); // Display "Fathan M" on second line
    }

    return 0;
}
