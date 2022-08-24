// PROJECT  : Serial Communication Streaming on 32 by 24 RGBW matrix
// AUTHOR   : Xander Chin
// MCU      : ATmega328P

extern "C" {
  void asmSerialSend();
  void test();
}

#define BAUD 2000000UL   // max baud rate
#define UB ((F_CPU / (8 * BAUD)) - 1)

void initSerial() {
  UCSR0A = 0x02; // 1<<U2X | 0<<MPCM;
  //UCSR0B = 0x98; // 1<<RXCIE | 0<<TXCIE | 0<<UDRIE | 1<<RXEN | 1<<TXEN | 0<<UCSZ2;  // enable TX & RX
  UCSR0B |= 1<<RXCIE0 | 0<<TXCIE0 | 0<<UDRIE0 | 1<<RXEN0 | 1<<TXEN0 | 0<<UCSZ02;
  
  UCSR0C = 0x06; //0<<UMSEL0 | 0<<UPM1 | 0<<UPM0 | 0<<USBS | 1<<UCSZ1 | 1<<UCSZ0 | 0<<UCPOL;  // 8N1
  UBRR0H = (UB >> 8);   // set baud rate
  UBRR0L = (UB & 0xFF); // HL register 
}

void setup() {
  SREG &= ~(1<<7);

  DDRB = 255;
  DDRC |= (1<<0);
  DDRD |= (1<<PD7)|(1<<PD6);

  initSerial();
  PORTB = 0;

  SREG |= 1<<7;
}

bool frame;

void loop() {

  if(frame) { 
    frame = false;
    SREG &= ~(1<<7);    //turn off global interrupts for no glitching
    UCSR0B &= ~(1<<RXCIE0);
    UCSR0B &= ~(1<<RXEN0);
    serialSendRGBW();   //send out frame
    UCSR0B |= (1<<RXCIE0);
    UCSR0B |= (1<<RXEN0);
    SREG |= 1<<7;
  }
}

void serialSendRGBW() {
  //receive serial data (32 bytes (4 color bytes * 8 leds))
  //read serial data from register
  //send back confirmation signal
  
  while (!(UCSR0A & (1<<UDRE0)));   // Wait for empty transmit buffer
  UDR0 = '\n';

  asmSerialSend();          //assembly
  delayMicroseconds(100);   //latch neopixels

  uint8_t message = UDR0;
}

ISR(USART_RX_vect) {
  uint8_t message = UDR0;
  frame = true;
}
