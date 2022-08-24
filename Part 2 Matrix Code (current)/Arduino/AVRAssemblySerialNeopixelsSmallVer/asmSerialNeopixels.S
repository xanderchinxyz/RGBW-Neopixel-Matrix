//since nano uses PD0 and PD1 as TX and RX I cannot use full 8 bit port
//so I will use either 6 bit PORTC/PORTB
//and have the two highest bits (non-existent bit 6 and 7 of PORTB and C) 
//be mapped to PD6 and PD7

#define __SFR_OFFSET 0
  
#include "avr/io.h"

#define util r16
#define currbit r17
#define bytesLeft r18

#define byte0 r20
#define byte1 r21
#define byte2 r22
#define byte3 r23
#define byte4 r24
#define byte5 r25
#define byte6 r26
#define byte7 r27

.global asmSerialSend

asmSerialSend:

  ldi byte0, 0
  ldi byte1, 0
  ldi byte2, 0
  ldi byte3, 0
  ldi byte4, 0
  ldi byte5, 0
  ldi byte6, 0
  ldi byte7, 0
  
  waitLoop:
  sbic PIND, 0
  rjmp waitLoop
  nop
  nop
  nop
  
  ldi bytesLeft, 64//190   //transmit 32 bytes (8 * 4)
  byteLoop:
    ldi currbit, 1
    ldi util, 7    
    dataLoop:   //gather data from 7 bytes
      nop           //need this delay to properly read pinD
      sbic PIND, 0
      add byte7, currbit
      lpm

      
      //sbi PORTC, 0
      lpm
      sbic PIND, 0
      add byte6, currbit
      //cbi PORTC, 0
      nop
      nop
      nop

      
      //sbi PORTC, 0
      lpm
      sbic PIND, 0
      add byte5, currbit
      //cbi PORTC, 0
      nop
      nop
      nop

      
      //sbi PORTC, 0
      lpm
      sbic PIND, 0
      add byte4, currbit
      //cbi PORTC, 0
      nop
      nop
      nop

      nop
      //sbi PORTC, 0
      nop
      nop
      sbic PIND, 0
      add byte3, currbit
      cbi PORTC, 0
      nop
      nop
      nop

      nop
      //sbi PORTC, 0
      nop
      nop
      sbic PIND, 0
      add byte2, currbit
      cbi PORTC, 0
      nop

      nop
      //sbi PORTC, 0
      nop
      nop
      sbic PIND, 0
      add byte1, currbit
      //cbi PORTC, 0
      nop
      nop
      nop

      nop
      //sbi PORTC, 0
      nop
      nop
      sbic PIND, 0
      add byte0, currbit
      //cbi PORTC, 0

      lsl currbit

      lpm
      lpm
      lpm
      lpm
      lpm
      dec util
      brne dataLoop
    
    lpm            //need this delay in order to read PIND properly afterward
    sbic PIND, 0          //read 8th byte (with output)
    add byte7, currbit

    ldi util, 255    
    out PORTD, util   //corrupts rest of PORTD
    out PORTB, util
    lpm
    out PORTD, byte7
    out PORTB, byte7  
    sbic PIND, 0
    add byte6, currbit
    ldi byte7, 0
    out PORTD, byte7
    out PORTB, byte7
    nop
    nop
    sbic PIND, 0
    add byte5, currbit

    out PORTD, util
    out PORTB, util
    lpm
    out PORTD, byte6
    out PORTB, byte6
    sbic PIND, 0
    add byte4, currbit
    ldi byte6, 0
    out PORTD, byte6
    out PORTB, byte6
    nop
    nop
    sbic PIND, 0
    add byte3, currbit

    out PORTD, util
    out PORTB, util
    nop
    nop
    nop
    out PORTD, byte5
    out PORTB, byte5
    sbic PIND, 0
    add byte2, currbit
    ldi byte5, 0
    out PORTD, byte5
    out PORTB, byte5
    nop
    nop
    sbic PIND, 0
    add byte1, currbit

    out PORTD, util
    out PORTB, util
    lpm
    out PORTD, byte4
    out PORTB, byte4
    sbic PIND, 0
    add byte0, currbit
    ldi byte4, 0
    out PORTD, byte4
    out PORTB, byte4
    lpm
    nop

    out PORTD, util
    out PORTB, util
    lpm
    out PORTD, byte3
    out PORTB, byte3
    ldi byte3, 0
    nop
    nop
    out PORTD, byte3
    out PORTB, byte3
    lpm 
    nop

    out PORTD, util
    out PORTB, util
    lpm
    out PORTD, byte2
    out PORTB, byte2
    ldi byte2, 0
    nop
    nop
    out PORTD, byte2
    out PORTB, byte2
    lpm
    nop

    out PORTD, util
    out PORTB, util
    lpm
    out PORTD, byte1
    out PORTB, byte1
    ldi byte1, 0
    nop
    nop
    out PORTD, byte1
    out PORTB, byte1
    lpm 
    nop

    out PORTD, util
    out PORTB, util
    lpm
    out PORTD, byte0
    out PORTB, byte0
    ldi byte0, 0
    nop
    nop
    out PORTD, byte0
    out PORTB, byte0

    waitStop:       //zero bit is sent (prevents data shifting errors)
    sbis PIND, 0    //
    rjmp waitStop   //wait for 0 bit to pass
  
    //sbi   PORTC,0
    //cbi   PORTC,0
    lpm
    lpm
    nop
    nop

    dec bytesLeft
    cpse bytesLeft, byte0
    rjmp byteLoop
ret
