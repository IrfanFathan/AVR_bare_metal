# ADC Conversion using Interrupt

This document describes the algorithm for performing ADC conversions on an AVR using interrupts.

## Steps

1. Initialize the required peripherals.
2. Select AVCC as reference voltage.
3. Select ADC0 as input channel.
4. Configure Auto Trigger mode.
5. Select Free Running mode.
6. Set the ADC prescaler.
7. Enable the ADC module.
8. Enable ADC interrupt.
9. Enable global interrupt.
10. Start the first conversion.
11. When conversion completes, the ADC interrupt occurs.
12. Read the ADC value and process it.
13. Repeat continuously.

---

Original C-style algorithm comment preserved for reference:

```c
/*************************************************
 * Algorithm : ADC Conversion using Interrupt
 *
 * Step 1 : Initialize the required peripherals.
 *
 * Step 2 : Select AVCC as reference voltage.
 *
 * Step 3 : Select ADC0 as input channel.
 *
 * Step 4 : Configure Auto Trigger mode.
 *
 * Step 5 : Select Free Running mode.
 *
 * Step 6 : Set the ADC prescaler.
 *
 * Step 7 : Enable the ADC module.
 *
 * Step 8 : Enable ADC interrupt.
 *
 * Step 9 : Enable global interrupt.
 *
 * Step 10 : Start the first conversion.
 *
 * Step 11 : When conversion completes,
 *            ADC interrupt occurs.
 *
 * Step 12 : Read ADC value and process it.
 *
 * Step 13 : Repeat continuously.
 *************************************************/
```
