/*************************************************
 * Program   : ADC conversion
 * Author    : Irfan Fathan M
 * Date      : 2026-06-10
 * MCU       : ATmega328P @ 16000000 Hz
 *
 * Description:
 *   ADC conversion
 * Status     :
 *   Code Error {UNDER REVIEW}
 *************************************************/

#define F_CPU 16000000UL /* CPU frequency for delay functions */

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

int main(void)
{
    // ENABLE TIMER MODE AS PWM 10 bit MODE
    TCCR1A |= (1 << WGM10) | (1 << WGM11);
    TCCR1B |= (1 << WGM12);
    TCCR1B &= ~(1 << WGM13);

    // SET PWM MODE TO NON INVERTING MODE
    TCCR1A |= (1 << COM1A1);
    TCCR1A &= ~(1 << COM1A0);

    // SET PRESCALER
    // 16 MHZ / 205KHZ = 16
    TCCR1B |= (1 << CS10) | (1 << CS11);
    // TCCR1B &= (1 << CS12); => no needed to write this line because the bit is already 0

    // SETING THE OUTPUT COMPARING PIN AS DDb5 (OC1A)
    DDRB |= (1 << DDB1);

    // // SET DUTY CYCLE TO 50%
    // OCR1A = 512; // 50% of 1023 (10-bit resolution)

    // // ENABLE GLOBLE INTERRUPT
    // sei();
    // // ENABLE ADC INTERRUPT AND RELETIVES
    // ADCSRA |= (1 << ADIE); //
    // // SET REFERNCE VOLATEGE AT Avcc AND INPUT TO ADC
    // // ADMUX |=(1<<REFS0);
    // // ADMUX &=(~(1<<ADLAR));
    // ADMUX = 0X40;
    // // ENABLE ADC
    // ADCSRA |= (1 << ADEN) | (1 << ADATE);
    // ADCSRB = 0X00; // ADC SET THE AUTO TRIGGER SOURCE IN FREE RUNNING MODE
    // // SETING THE PRESCALER
    // ADCSRA |= (1 << ADPS2);
    // ADCSRA &= (~(1 << ADPS1) | (1<<ADPS0));
    // // START THE CONVERSION
    // ADCSRA |= (1 << ADSC);












sei();

// Enable ADC interrupt
ADCSRA |= (1 << ADIE);

// AVCC reference, ADC0
ADMUX = 0x40;

// Free running mode
ADCSRB = 0x00;

// Enable ADC and auto trigger
ADCSRA |= (1 << ADEN) | (1 << ADATE);

// Prescaler = 16
ADCSRA |= (1 << ADPS2);
ADCSRA &= ~((1 << ADPS1) | (1 << ADPS0));

// Start conversion
ADCSRA |= (1 << ADSC);



















    while (1)
    {
    };

    return 0;
}
ISR(ADC_vect)
{
    OCR1A = ADCW;
}