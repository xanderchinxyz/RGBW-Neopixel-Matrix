import java.awt.Robot;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;

import processing.serial.*;
Serial myPort;
String serialData;

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
  
  //-----------------
};
 
Robot robot;
int cols, rows;

void setup() {
  //size(320, 240);
  fullScreen();
  
  String portName = Serial.list()[11];
  myPort = new Serial(this, portName, 2000000, 'N', 8, 1.0);
  myPort.bufferUntil('\n');
  
  try {
    robot = new Robot();
  } 
  catch (Exception e) {
    println(e.getMessage());
  }
  cols = 16;
  rows = 8;
  
  frameRate(30);
}
 
int redVal = 0;
int greenVal = 0;
int blueVal = 0;
int whiteVal = 0;

void draw() {
  //background(0);
  Rectangle r = new Rectangle(0, 0, width, height);
  BufferedImage img1 = robot.createScreenCapture(r);
  PImage img2 = new PImage(img1);
  img2.loadPixels();
  img2.resize(cols, rows);
  
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      // Where are you, pixel-wise?
      //int x = i*videoScale;
      //int y = j*videoScale;
      //color c = img2.pixels[i + j*img2.width];
      color c = img2.pixels[i + j*img2.width];
      redVal = int(red(c));
      greenVal = int(green(c));
      blueVal = int(blue(c));
      whiteVal = min(redVal, greenVal, blueVal);
      data[36*i+j] = byte(Integer.reverse(greenVal - whiteVal) >> 24);
      data[36*i+j+9] = byte((Integer.reverse(redVal - whiteVal))>>24);
      data[36*i+j+18] = byte((Integer.reverse(blueVal - whiteVal))>>24);
      data[36*i+j+27] = byte((Integer.reverse(whiteVal))>>24);  
    }
  }
  myPort.write(1); 
}

void serialEvent(Serial myPort) {
   myPort.write(data);
}
