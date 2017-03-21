//Camera library //<>// //<>// //<>//
import peasy.*;
//Serial libray
import processing.serial.*;


PeasyCam cam;

Cube cube;
Earth earth;


void setup() {
  // Window initialization
  size(1200, 800, P3D);
  frameRate(60);
  cam = new PeasyCam(this, width/2, height/2, 0, 700);
  
  // Serial Port initialization
  if(Serial.list().length >= 1) {
    myPort = new Serial(this, Serial.list()[0], 9600);
    myPort.bufferUntil('\r');
    deviceConnected = true;
  }
  else {
    deviceConnected = false;
    println("PORT NOT FOUND !!!" + "\n" + "Connect Your Device");
  }
  
  //Objects initialization
  cube = new Cube();
  earth = new Earth();
}


void draw() {
  background(0);
  
  writeSerial(10, 20, 18);
  writeHelp(width-200, 20, 14);
  cube.draw();
  earth.draw();
  drawArrow(cube.magneto.smoothed, 800, 700, 0, color(255, 255, 255));
}


void keyPressed() {
  
  if(keyCode == BACKSPACE) {
    cube.gyro.calibrate();
    cube.attitude.set(PI/2, PI/2, 0);
    
    cube.accelero.calibrate();
    cube.position.set(2*width/3, height/3, 0);
    
    //cube.magneto.calibrate();
  }
  
}