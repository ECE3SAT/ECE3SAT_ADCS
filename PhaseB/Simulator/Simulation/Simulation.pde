import http.requests.*;
import processing.serial.*;
import controlP5.*;

Earth earth;
Cube cube;
Sun sun;
Arrow lightRay;

// Button Controller
ControlP5 cp5,cpReset,cpBdot,cpToggle;

// Time factor
float timeCoefficient = 1; // DEFAULT = 1, accelerate or slow simulation time
                            // Slow => <1    Accelerate => >1

// Fixed number of frame
// Used because "frameRate" value is not reliable. First loop frameRate ~ 10
float framePerSecond = 30;

// Time spend since the start of the simulation
float timeSpend = 0;

PImage img;
PImage sky;

// Enable Serial communication
boolean enableCom = false;

Serial serialPort;
Serial serialPort2;

void settings() {
  size(displayWidth, displayHeight,P3D);
}

float rotationSpeed;
PVector rotationAxis;

void setup(){
  
  surface.setResizable(true);
  frameRate(framePerSecond);
  img = loadImage("img/main_900.jpg");
  sky = loadImage("img/cropped-starglobe-maya-render.jpg");
  
  try{
    serialPort = new Serial(this,"COM5", 57600);
  }
  catch(Exception e){}
  
  println("Time = "+timeCoefficient);
  
  // Store global cube rotation for time change
  rotationSpeed = 0;
  rotationAxis = new PVector(1,0,1);
  
  initGraph();
  
  // Create object
  try{
    earth = new Earth();
    sun = new Sun();
    cube =  new Cube(rotationSpeed,rotationAxis.x,rotationAxis.y,rotationAxis.z);
    lightRay = new Arrow(0,0,0,0,0,0);
  }
  catch(Exception e){
    e.printStackTrace(System.out);}
  
  //Initialize cube position  regarding of it's orbit around Earth
  cube.initializePosition();
  
  
  // Create button controller
  cp5 = new ControlP5(this);
  cp5.addTextfield("Time Factor").setPosition(width-250, height - 110).setSize(70, 30).setAutoClear(false);
  cp5.setAutoDraw(false);
  cp5.getController("Time Factor").getCaptionLabel().setColor(color(0,0,0) );
  cp5.addBang("Submit").setPosition(width-150, height - 110).setSize(30, 30); 
  cp5.getController("Submit").getCaptionLabel().setColor(color(0,0,0) );
  
  cpReset = new ControlP5(this);
  cpReset.setAutoDraw(false);
  cpReset.addTextfield("Angular Speed").setPosition(width-450, 50 + 30).setSize(70, 30).setAutoClear(false);
  cpReset.setAutoDraw(false);
  cpReset.getController("Angular Speed").getCaptionLabel().setColor(color(0,0,0) );
  cpReset.addTextfield("Rotation Axis X").setPosition(width-350, 50 + 30).setSize(70, 30).setAutoClear(false);
  cpReset.setAutoDraw(false);
  cpReset.getController("Rotation Axis X").getCaptionLabel().setColor(color(0,0,0) );
  cpReset.addTextfield("Rotation Axis Y").setPosition(width-350, 50 + 80).setSize(70, 30).setAutoClear(false);
  cpReset.setAutoDraw(false);
  cpReset.getController("Rotation Axis Y").getCaptionLabel().setColor(color(0,0,0) );
  cpReset.addTextfield("Rotation Axis Z").setPosition(width-350, 50 + 130).setSize(70, 30).setAutoClear(false);
  cpReset.setAutoDraw(false);
  cpReset.getController("Rotation Axis Z").getCaptionLabel().setColor(color(0,0,0) );
  cpReset.addBang("Reset").setPosition(width-250, 50 + 30).setSize(30, 30); 
  cpReset.getController("Reset").getCaptionLabel().setColor(color(0,0,0) );
  
  cpBdot = new ControlP5(this);
  cpBdot.setAutoDraw(false);
  cpBdot.addBang("Bdot").setPosition(width-100, height - 110).setSize(30, 30); 
  cpBdot.getController("Bdot").getCaptionLabel().setColor(color(0,0,0) );
  cpBdot.getController("Bdot").setColorActive(color(170,0,0));
  cpBdot.setColorForeground(color(255,0,0));
  
  cpToggle = new ControlP5(this);
  cpToggle.setAutoDraw(false);
  cpToggle.addBang("Toggle").setPosition(width-70, 60).setSize(30, 30); 
  cpToggle.getController("Toggle").getCaptionLabel().setColor(color(0,0,0) );
  cpToggle.getController("Toggle").setColorActive(color(170,0,0));
  cpToggle.setColorForeground(color(255,0,0));
  
  smooth();
}

String url1, url2;


// Reset simulation
void Reset() {
  timeSpend = 0;
  
  float angSpeed = Float.parseFloat(cpReset.get(Textfield.class,"Angular Speed").getText());
  float xCoord = Float.parseFloat(cpReset.get(Textfield.class,"Rotation Axis X").getText());
  float yCoord = Float.parseFloat(cpReset.get(Textfield.class,"Rotation Axis Y").getText());
  float zCoord = Float.parseFloat(cpReset.get(Textfield.class,"Rotation Axis Z").getText());
  println(xCoord);
  cube = new Cube(angSpeed,xCoord,yCoord,zCoord); 
  
  cube.initializePosition();
}

// Enable/Disable Serial communication
void Bdot() {
  enableCom ^= true;
  cube.magnetorquerX.changeIntensity(0);
  cube.magnetorquerY.changeIntensity(0);
  cube.magnetorquerZ.changeIntensity(0);
}

void Toggle() {
  displayUI ^= true; 
  displayUIReset ^= true;
}

// Change the time coefficient, and update object speed
void Submit() {
  print("the following text was submitted :");
  url1 = cp5.get(Textfield.class,"Time Factor").getText();
  
  cube.resetSpeed();
  
  timeCoefficient = Float.parseFloat(url1);
  
  cube.changeTime();
  earth.changeTime();
}


// Chanhe UI mode when A key is pressed
void keyPressed() {
  if (key == 'a') {
    displayUI ^= true; 
    displayUIReset ^= true; 
  } 
}