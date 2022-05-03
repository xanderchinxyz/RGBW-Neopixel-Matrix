import processing.serial.*;
Serial myPort;
String serialData;

import processing.video.*;

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

// Size of each cell in the grid, ratio of window size to video size
// Number of columns and rows in the system
int cols, rows;
// Variable to hold onto Capture object
Capture video;

void setup() {
  String portName = Serial.list()[11];
  myPort = new Serial(this, portName, 2000000, 'N', 8, 1.0);
  myPort.bufferUntil('\n');
  
  //size(1120, 560);
  // Initialize columns and rows
  cols = 16;
  rows = 8;
  background(0);
  video = new Capture(this, cols, rows);
  video.start();
  
  frameRate(30);
}

// Read image from the camera
void captureEvent(Capture video) {
  video.read();
}

int redVal = 0;
int greenVal = 0;
int blueVal = 0;
int whiteVal = 0;

void draw() {
  video.loadPixels();
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      // Where are you, pixel-wise?
      //int x = i*videoScale;
      //int y = j*videoScale;
      color c = video.pixels[i + j*video.width];
      redVal = int(red(c));
      greenVal = int(green(c));
      blueVal = int(blue(c));
      whiteVal = min(redVal, greenVal, blueVal);
      data[36*i+j] = byte(Integer.reverse(greenVal - whiteVal) >> 24);
      data[36*i+j+9] = byte((Integer.reverse(redVal - whiteVal))>>24);
      data[36*i+j+18] = byte((Integer.reverse(blueVal - whiteVal))>>24);
      data[36*i+j+27] = byte((Integer.reverse(whiteVal))>>24);      
      //fill(c);
      //stroke(0);
      //rect(x, y, videoScale, videoScale);
    }
  }
  myPort.write(1);
}

void serialEvent(Serial myPort) {
   //serialData = myPort.readStringUntil('\n');
   //serialData = serialData.substring(0, serialData.length() - 1);
   //println(serialData);
   myPort.write(data);
}
