/*************************************************
 * Program   : LED Blink
 * Author    : Irfan Fathan M
 * Date      : 02 May 2026
 * MCU       : ATmega328P (16 MHz)
 *
 * Description:
 * Blinks a 7-segment display connected to PORTD, counting from 0 to 9 with a 500ms delay.
 *************************************************/

#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
   DDRD = 0xFF; // Set all pins on PORTD as output
   unsigned char segment[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66,
                                0x6D, 0x7D, 0x07, 0x7F, 0x6F}, // It corsesponding values of  7 segment values , where the values in heaxadecail
       i;
   while (1)
   {

      for (i = 0; i < 10; i++)
      {
         PORTD = segment[i]; // It show value in PORT D
         _delay_ms(1000);    // Added delay for that
      }
   }

   return 0;
}
