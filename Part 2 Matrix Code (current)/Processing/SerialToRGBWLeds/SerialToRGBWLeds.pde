//serial library to communicate with arduino
import processing.serial.*;
Serial myPort;
String serialData;

Card[] cards = new Card [128];
 
int rows = 8;
int columns = 16;
int cardsize = 50;
int space = 2;
int border = 5;
int cardstotal = (rows * columns);

//colors and typing stuff
PFont font;

int redVal = 0;
int greenVal = 0;
int blueVal = 0;
int whiteVal = 0;
Text redText;
Text greenText;
Text blueText;

int lastUpdate = 0;

byte[] data = {
//P0 P1 P2 P3 P4 P5 P6 P7 
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
  
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //G byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //R byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //B byte
  0, 0, 0, 0, 0, 0, 0, 0, 0,    //W byte
};

void setup() {
  //set up bluetooth serial connection
  String portName = Serial.list()[11];
  myPort = new Serial(this, portName, 2000000, 'N', 8, 1.0);
  myPort.bufferUntil('\n');
  
  size(1400, 850, P2D);
  background(0);
  
  
  font = loadFont("AppleMyungjo-50.vlw");    //load font into sketch
  textFont(font, 50);
 
  // Puts cards where they belong
  int cardsinrow = 0;
  int cardsincolumn = 0;
  for (int i = 0; i < cards.length; i++) {
    cards[i] = new Card((border + (cardsinrow * (cardsize + space))), (border + (cardsincolumn * (cardsize + space))), 1, false);
    cardsinrow++;
    if (cardsinrow >= columns) { // "Line break" for the cards
      cardsinrow = 0;
      cardsincolumn++;
    }
    //println(cardsincolumn); // Debug
  }
  
  redText = new Text("Red: 0", 1000, 100, 40);
  greenText = new Text("Green: 0", 1000, 150, 40);
  blueText = new Text("Blue: 0", 1000, 200, 40);
}

void serialEvent(Serial myPort) {
   //serialData = myPort.readStringUntil('\n');
   //serialData = serialData.substring(0, serialData.length() - 1);
   //println(serialData);
   myPort.write(data);
}

void draw() {
  background(0);
  
  for (int i=0; i < cards.length; i++) {
    cards[i].display();
  } 
  
  if(redText.collision(mouseX, mouseY)) {
    redText.highlight = true;
  } else {
    redText.highlight = false;
  }
  
  if(greenText.collision(mouseX, mouseY)) {
    greenText.highlight = true;
  } else {
    greenText.highlight = false;
  }
  
  if(blueText.collision(mouseX, mouseY)) {
    blueText.highlight = true;
  } else {
    blueText.highlight = false;
  }
  
  redText.display();
  greenText.display();
  blueText.display();
  
  /*
  if(editRed)  fill(100, 200, 0);
  else         fill(255); 
  text("Red: " + redVal, 1000, 100);
  
  if(editGreen)  fill(100, 200, 0);
  else         fill(255); 
  text("Green: " + greenVal, 1000, 150);
  
  if(editBlue)  fill(100, 200, 0);
  else         fill(255); 
  text("Blue: " + blueVal, 1000, 200);
  */
  stroke(255);
  fill(redVal, greenVal, blueVal);
  rect(1000, 300, 100, 100);
  
}

void keyPressed() {
  if(key == 'w') myPort.write(1);
  if(redText.selected) {
    if(int(key) >= 48 && int(key) <= 57) {
      redVal = redVal*10;
      redVal = redVal + (int(key) - 48);
      redText.updateTextTo("Red: " + redVal);
    } else if(key == BACKSPACE) {
      redVal = floor(redVal/10);
      redText.updateTextTo("Red: " + redVal);
    } else if(key == ENTER) {
      redText.selected = false;
      if(redVal > 255) redVal = 255;
      redText.updateTextTo("Red: " + redVal);
    }
  }
  if(greenText.selected) {
    if(int(key) >= 48 && int(key) <= 57) {
      greenVal = greenVal*10;
      greenVal = greenVal + (int(key) - 48);
      greenText.updateTextTo("Green: " + greenVal);
    } else if(key == BACKSPACE) {
      greenVal = floor(greenVal/10);
      greenText.updateTextTo("Green: " + greenVal);
    } else if(key == ENTER) {
      greenText.selected = false;
      if(greenVal > 255) greenVal = 255;
      greenText.updateTextTo("Green: " + greenVal);
    }
  }
  if(blueText.selected) {
    if(int(key) >= 48 && int(key) <= 57) {
      blueVal = blueVal*10;
      blueVal = blueVal + (int(key) - 48);
      blueText.updateTextTo("Blue: " + blueVal);
    } else if(key == BACKSPACE) {
      blueVal = floor(blueVal/10);
      blueText.updateTextTo("Blue: " + blueVal);
    } else if(key == ENTER) {
      blueText.selected = false;
      if(blueVal > 255) blueVal = 255;
      blueText.updateTextTo("Blue: " + blueVal);
    }
  }
}

void mousePressed() {
  for (int i = 0; i < cards.length; i++) {
    if (cards[i].collision(mouseX, mouseY)) {
      cards[i].cardRed = redVal;
      cards[i].cardGreen = greenVal;
      cards[i].cardBlue = blueVal;
      //println(i);
      
      whiteVal = min(greenVal, redVal, blueVal);
      data[36*(i%16)+floor(i/16)] = byte(Integer.reverse(greenVal - whiteVal) >> 24);
      data[36*(i%16)+floor(i/16)+9] = byte((Integer.reverse(redVal - whiteVal))>>24);
      data[36*(i%16)+floor(i/16)+18] = byte((Integer.reverse(blueVal - whiteVal))>>24);
      data[36*(i%16)+floor(i/16)+27] = byte((Integer.reverse(whiteVal))>>24);
      
      myPort.write(1);
    }
  }
  
  if(redText.collision(mouseX, mouseY)) {
    redText.selected = !redText.selected;
    greenText.selected = false;
    blueText.selected = false; 
    
    if(redText.selected) redVal = 0;
    redText.updateTextTo("Red: " + redVal);
  } else if(greenText.collision(mouseX, mouseY)) {
    redText.selected = false;
    greenText.selected = !greenText.selected;
    blueText.selected = false;    
    
    if(greenText.selected) greenVal = 0;
    greenText.updateTextTo("Green: " + greenVal);
  } else if(blueText.collision(mouseX, mouseY)) {
    redText.selected = false;
    greenText.selected = false;
    blueText.selected = !blueText.selected;   
    
    if(blueText.selected) blueVal = 0;
    blueText.updateTextTo("Blue: " + blueVal);
  }
}

void mouseDragged() {
  for (int i = 0; i < cards.length; i++) {
    if (cards[i].collision(mouseX, mouseY)) {
      cards[i].cardRed = redVal;
      cards[i].cardGreen = greenVal;
      cards[i].cardBlue = blueVal;
      
      int whiteVal = min(greenVal, redVal, blueVal);
      data[36*(i%16)+floor(i/16)] = byte(Integer.reverse(greenVal - whiteVal) >> 24);
      data[36*(i%16)+floor(i/16)+9] = byte((Integer.reverse(redVal - whiteVal))>>24);
      data[36*(i%16)+floor(i/16)+18] = byte((Integer.reverse(blueVal - whiteVal))>>24);
      data[36*(i%16)+floor(i/16)+27] = byte((Integer.reverse(whiteVal))>>24);
      
      if(millis() - lastUpdate > 20) {
        myPort.write(1);
        lastUpdate = millis();
      }
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < cards.length; i++) {
    cards[i].cardstatus = false;
  }
}

public class Text {
  String text;
  int textPosX;
  int textPosY;
  float textWidth;
  int textSize;
  boolean highlight = false;
  boolean selected = false;
  
  Text(String string, int x, int y, int z) {
    text = string;
    textPosX = x;
    textPosY = y;
    textSize = z;
    textSize(textSize);    //initialize text size before calculating text width 
    textWidth = textWidth(string);
  }
  
  void display() {
    if(highlight) {
      fill(255);
    } else {
      fill(237, 180, 34);
    }
    
    if(selected) fill(173, 23, 203);
    
    textSize(textSize);
    text(text, textPosX, textPosY, textWidth);
  }
  
  void updateTextTo(String string) {
    text = string;
  }
  
  boolean collision(float mouseX, float mouseY) {
    if(mouseX >= textPosX && mouseX <= textPosX + textWidth) {
      if(mouseY >= textPosY - textSize && mouseY <= textPosY) {
        return true;
      }
    }    
    return false;
  } 
}
 
public class Card {
  int cardposx;
  int cardposy;
  int cardcontent;
  boolean cardstatus;
  
  int cardRed;
  int cardGreen;
  int cardBlue; 
 
  Card(int cardposx_, int cardposy_, int cardcontent_, boolean cardstatus_) {
    cardposx = cardposx_;
    cardposy = cardposy_;
    cardcontent = cardcontent_;
    cardstatus = cardstatus_;
  }
 
  void display() {
    /*if (cardstatus) {
      fill(0,200,200);
    } else {
      fill(0);
    }*/
    fill(cardRed, cardGreen, cardBlue);
    rect(cardposx, cardposy, cardsize, cardsize);
    stroke(255);
  }
 
  boolean collision(float mouseX, float mouseY) {
    if (mouseX >= cardposx &&         // right of the left edge AND
      mouseX <= cardposx + cardsize &&    // left of the right edge AND
      mouseY >= cardposy &&         // below the top AND
      mouseY <= cardposy + cardsize) {    // above the bottom
      return true;
    }
    return false;
  }
}

// class =======================================================
