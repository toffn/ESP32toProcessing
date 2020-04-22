//ESP32 to Processing
//Toff Nguyen

import processing.serial.*;    

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;
int serialIndex = 7;

String [] data;

String [] faces = {":^(", ":^I", ":^P", ":^0", ":^)"};

int switchValue = 0;
int potValue = 0;

int circleColor = 255;
int circleSize;
int textColor;
String circleFace = ":^)";
int faceSize = 40;

int halfWidth = 375;
int halfHeight = 310;

void setup()
{
  size (800,  600);
  //List all the available serial ports
  printArray(Serial.list());
  
  //Set the com port and the baud rate according to the Arduino IDE
  //-- use your port name
  myPort = new Serial (this, Serial.list() [serialIndex],  115200); 

  ellipseMode(CENTER);
  textMode(CENTER);
}

void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    print(inBuffer);
    
    //This removes the end-of-line from the string 
    inBuffer = (trim(inBuffer));
    
    //This function will make an array of TWO items, 1st item = switch value, 2nd item = potValue
    data = split(inBuffer, ',');
   
   //we have TWO items — ERROR-CHECK HERE
   if(data.length >= 2) {
      switchValue = int(data[0]);           // first index = switch value 
      potValue = int(data[1]);               // second index = pot value
 
   }
  }
}

void draw ( ) {  
  //Every loop, look for serial information
  checkSerial();
  
  //Change background color and value for faceSize
  if (potValue < 1000)
  {
    background(255, 248, 176);
    fill(235, 247, 255);
    ellipse(width/2, height/2, 100, 100);
    faceSize=40;
  }
  
  if (potValue > 1000)
  {
    background(223, 232, 155);
    fill(241, 232, 255);
    ellipse(width/2, height/2, 200, 200);
    faceSize=90;
  }
  
  if (potValue > 2000)
  {
    background(149, 232, 220);
    fill(247, 255, 235);
    ellipse(width/2, height/2, 300, 300);
    faceSize=180;
  }
  
  if (potValue > 3000)
  {
    background(237, 192, 216);
    fill(255, 247, 235);
    ellipse(width/2, height/2, 400, 400);
    faceSize=220;
  }
  
  if (potValue > 4000)
  {
    background(240, 152, 132);
    fill(255, 235, 249);
    ellipse(width/2, height/2, 500, 500);
    faceSize=280;
  }
  
  //Change expression if button is pressed
  if( switchValue == 1 )
  {
    circleFace = faces[int(random(0,4))];
  }
  
  //Set text size and color for text
  textSize(faceSize);
  fill(textColor);
  
  //Drawing faces over circles based on previously assigned size
  if (faceSize == 40)
  {
    text(circleFace, halfWidth, halfHeight);
  }
  if (faceSize == 90)
  {
    text(circleFace, halfWidth-30, halfHeight+15);
  }
  if (faceSize == 180)
  {
    text(circleFace, halfWidth-90, halfHeight+34);
  }
  if (faceSize == 220)
  {
    text(circleFace, halfWidth-120, halfHeight+50);
  }
  if (faceSize == 280)
  {
    text(circleFace, halfWidth-160, halfHeight+60);
  }
  
}
