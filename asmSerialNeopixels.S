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
.global test

asmSerialSend:

  ldi byte0, 0    //clear all bytes
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

  ldi r28, 2
  ldi bytesLeft, 192      //loops 2*192 = 384 times
  byteLoop:
    ldi currbit, 1        //currbit is reset to 1
    ldi util, 7    
    dataLoop:             //gather data from 7 bytes
      nop                 //need this delay to properly read pinD
      sbic PIND, 0        //read from RX pin
      add byte7, currbit  //if high, add currbit
      lpm
      
      //sbi PORTC, 0      //debug signals
      lpm
      sbic PIND, 0        //read from RX pin
      add byte6, currbit  //if high, add currbit
      //cbi PORTC, 0      //debug signals
      nop
      nop
      nop
      
      //sbi PORTC, 0    //debug signals
      lpm
      sbic PIND, 0
      add byte5, currbit
      //cbi PORTC, 0    //debug signals
      nop
      nop
      nop

      
      //sbi PORTC, 0    //debug signals
      lpm
      sbic PIND, 0
      add byte4, currbit
      //cbi PORTC, 0    //debug signals
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

    //done 7 bytes. last one to go
    lpm                   //need this delay in order to read PIND properly afterward
    sbic PIND, 0          //read 8th byte (with output) - skip if RX is low
    add byte7, currbit    //add currbit to byte7

    ldi util, 255         //load high section of bits into util
    out PORTD, util       //PORTD high section of bit (corrupts rest of PORTD)
    out PORTB, util       //PORTB high section of bit
    lpm                   //delay (3 clock cycles)
    out PORTD, byte7      //PORTD output byte7 (high 2 bits only)
    out PORTB, byte7      //PORTD output byte7 (low 6 bits only)
    sbic PIND, 0          //skip next if RX is low (dont set currbit to byte6)
    add byte6, currbit    //add currbit to byte6
    ldi byte7, 0          //clear byte7 for next use
    out PORTD, byte7      //low section of bit
    out PORTB, byte7      //low section of bit
    nop                   //delay 1 clock cycle
    nop                   //delay 1 clock cycle
    sbic PIND, 0          //skip next if RX is low (dont set currbit to byte5)
    add byte5, currbit    //add currbit to byte5

    out PORTD, util       //repeats...
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
    
    //now no more bytes left to read. 0
    //delimeter byte starts in serial transmission
    //no need to read RX pin anymore
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
    
    
    waitStop:       //zero bit currently being sent 
    sbis PIND, 0    //
    rjmp waitStop   //wait for 0 bit to pass (prevents data shifting errors)
  
    //sbi   PORTC,0   //debug signal
    //cbi   PORTC,0   //debug signal
    lpm               //wait for stop and start bit to pass
    lpm
    nop
    nop

    dec bytesLeft           //decrease
    cpse bytesLeft, byte0   //skip if bytesLeft == 0
    rjmp byteLoop           //repeat
  
  //another loop
  dec r28           //decrease    
  cpse r28, byte0   //skip if bytesLeft == 0
  rjmp byteLoop     //jump back (reloads byteLoop)
ret                 //finally done, return

/*
test:
  waitLoop1:
  sbic PIND, 0
  rjmp waitLoop1

  ldi bytesLeft, 20
  byteLoop1:

    ldi util, 8
    byteLoop2:
      nop
      sbi PORTB, 0
      sbic PIND, 0
      nop 
      cbi PORTB, 0
      dec util
      brne byteLoop2

    dec bytesLeft
    brne byteLoop1
  ret

  */
