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

// Function prototypes
void lcd_data(unsigned char data);
void lcd_cmd(unsigned char command);
void lcd_string(const unsigned char *str, unsigned char length);
void lcd_initialize(void);

// globle variables
uint16_t a, b, c, d, e, f;
uint16_t first_digit, second_digit, third_digit, fourth_digit, fifth_digit;
volatile uint16_t captured = 0;

int main(void)
{
    DDRC = 0xFF;                                     // LCD data bus on Port C
    DDRB |= (1 << DDB1) | (1 << DDB2) | (1 << DDB3); // Control pins on PB1-PB3
    DDRB &= ~(1 << DDB0);                            // Set PB0 as input for capture signal

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
    TCCR1B |= (1 << ICES1); // Capture on rising edge

    // Initialize LCD and display header
    lcd_initialize();
    lcd_cmd(0x80);                     // Set cursor to first line
    lcd_string("INPUT CAPTURED:", 14); // Display header text

    while (1)
    {
        lcd_cmd(0xC0); // Set cursor to second line

        // Extract individual digits from captured value
        a = captured / 10;
        b = a / 10;
        c = b / 10;

        // Extract each digit using modulo and division
        fifth_digit = captured % 10; // Ones place
        fourth_digit = a % 10;       // Tens place
        third_digit = b % 10;        // Hundreds place
        second_digit = c % 10;       // Thousands place
        first_digit = c / 10;        // Ten-thousands place

        // Display each digit on the LCD
        lcd_data(first_digit + 0x30);
        lcd_data(second_digit + 0x30);
        lcd_data(third_digit + 0x30);
        lcd_data(fourth_digit + 0x30);
        lcd_data(fifth_digit + 0x30);
    }

    return 0;
}

ISR(TIMER1_CAPT_vect)
{
    captured = ICR1;
}

void lcd_data(unsigned char data)
{
    PORTB = (data & 0xF0); // Place upper 4 bits of data on Port B
    PORTB |= (1 << PB1);   // Clear RS to select instruction register mode
    PORTB &= ~(1 << PB2);  // Set RW low for write operation
    PORTB |= (1 << PB3);   // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB3);       // Set E low to complete the write cycle
    PORTC = (data << 4) & 0xF0; // Place lower 4 bits of data on Port C
    PORTB |= (1 << PB1);        // Clear RS to select instruction register mode
    PORTB &= ~(1 << PB2);       // Set RW low for write operation
    PORTB |= (1 << PB3);        // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB3);
}

void lcd_cmd(unsigned char command)
{
    PORTB = (command & 0xF0); // Place upper 4 bits of command on Port B
    PORTB &= ~(1 << PB1);     // Clear RS to select instruction register mode
    PORTB &= ~(1 << PB2);     // Set RW low for write operation
    PORTB |= (1 << PB3);      // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB3);          // Set E low to complete the write cycle
    PORTC = (command << 4) & 0xF0; // Place lower 4 bits of command on Port C
    PORTB &= ~(1 << PB1);          // Clear RS to select instruction register mode
    PORTB &= ~(1 << PB2);          // Set RW low for write operation
    PORTB |= (1 << PB3);           // Set E high initially
    _delay_ms(10);
    PORTB &= ~(1 << PB3);
}

void lcd_string(const unsigned char *str, unsigned char length)
{
    for (char i = 0; i < length; i++) // Send each character one by one
    {
        lcd_data(str[i]);
    }
}

void lcd_initialize()
{
    _delay_ms(50); // Wait for LCD to power up
    lcd_cmd(0x33); // Initialize LCD in 4-bit mode
    lcd_cmd(0x32); // Set to 4-bit mode
    lcd_cmd(0x28); // 2-line display, 5x8 font
    lcd_cmd(0x06); // Increment cursor after each character
    lcd_cmd(0x0C); // Display on, cursor off
    lcd_cmd(0x01); // Clear the display
}