/**************************************************** //<>//
 Installation:
 Library: ControlP5
 Tools: G4P GUI builder
 
 **********************************************/
import controlP5.*;


PImage earthImage;
PShape globe;
float earthAngle=0;
int counterTime=0;
float thetaX, thetaY, thetaZ;
PVector cubePos=new PVector(0, 0, 0);
PVector cubePosOnScreen=new PVector(0, 0, 0);
int CubeSize=80;
PVector earthPos=new PVector(0, 0);



//Create  Text field
ControlP5 cp5;
String url1, url2, url3;
int Url1=0, Url2=0, Url3=0;

//Graph
ArrayList waveX = new ArrayList();
ArrayList waveY = new ArrayList();
ArrayList waveZ = new ArrayList();
int waveLength = 200;   /// length for graph
float prevX = 0, prevY = 0;



Test_PID procX = new Test_PID();
Test_PID procY = new Test_PID();
Test_PID procZ = new Test_PID();
float KP, KI, KD;
float threshold=5;

//Set the screen size//
void settings() {
  size(1920, 1080, P3D);
}

//Create and set textfields and buttons//
void setup() 
{
  frameRate(35);
  earthImage=loadImage("earth.jpg");
  cubePosOnScreen.set(2*width/3, height/3, 0);
  earthPos.set(width/4, 3*height/4, 250);

  //creat text field
  // Copy paste to add new text field
  cp5 = new ControlP5(this);
  cp5.addTextfield("ThetaX").setPosition(30, 120+18).setSize(60, 20).setAutoClear(false);
  cp5.addTextfield("ThetaY").setPosition(30, 155+18).setSize(60, 20).setAutoClear(false);
  cp5.addTextfield("ThetaZ").setPosition(30, 190+18).setSize(60, 20).setAutoClear(false);
  cp5.addTextfield("KP").setPosition(1700, 820+18).setSize(60, 20).setAutoClear(false);
  cp5.addTextfield("KI").setPosition(1700, 855+18).setSize(60, 20).setAutoClear(false);
  cp5.addTextfield("KD").setPosition(1700, 890+18).setSize(60, 20).setAutoClear(false);
  cp5.addTextfield("threshold").setPosition(1700, 925+18).setSize(60, 20).setAutoClear(false);

  cp5.addButton("Consign").setValue(128).setPosition(120, 150).updateSize();
  cp5.addButton("Param").setValue(128).setPosition(1700, 985).updateSize();
}



//Draw some Label on Screen and call the drawing methods of the other class//
void draw()
{
  background(0);

  if (counterTime>1) {
    calPID();  

    waveX.add(thetaX);
    graph(waveX, 300);
    text("theatX", 20, 280);
    waveY.add(thetaY);
    graph(waveY, 400);
    text("theatY", 20, 380);
    waveZ.add(thetaZ);
    graph(waveZ, 500);
    text("theatZ", 20, 480);
  }
  counterTime++;

  //Draw elements
  writeParam(10, 20, 18);

  drawCube(cubePosOnScreen.x+cubePos.x, cubePosOnScreen.y+cubePos.z, cubePosOnScreen.z+cubePos.y, thetaX, thetaY, thetaZ, CubeSize);
  drawEarth(earthPos.x, earthPos.y, earthPos.z);
}

//Launch the PID calculation to get the new angles//
/// launch PID Cal
void calPID() {  // edit val for parameter 
  thetaX=radians(procX.myEvaluation(Url1, thetaX));
  thetaY=radians(procY.myEvaluation(Url2, thetaY));
  thetaZ=radians(procZ.myEvaluation(Url3, thetaZ));
}

//Get and set the new values that are set graphically in the textfields//
//button 
public void Param() {
  KP=float(cp5.get(Textfield.class, "KP").getText());
  KI=float(cp5.get(Textfield.class, "KI").getText());
  KD=float(cp5.get(Textfield.class, "KD").getText());
  threshold=float(cp5.get(Textfield.class, "threshold").getText());

  if (Float.isNaN(KP))KP=1;  // arbitrary
  if (Float.isNaN(KI))KI=0;  // arbitrary
  if (Float.isNaN(KD))KD=0;  // arbitrary
  if (Float.isNaN(threshold)) threshold =1;  // arbitrary
  
  //send the values to the different PID (one per axis)
  procY.pid.KP=procZ.pid.KP=procX.pid.KP=KP;
  procY.pid.KI=procZ.pid.KI=procX.pid.KI=KI;
  procY.pid.KD=procZ.pid.KD=procX.pid.KD=KD;
  procY.pid.threshold=procZ.pid.threshold=procX.pid.threshold = threshold;
  println("KP:"+procX.pid.KP+" KI:"+procX.pid.KI+" KD:"+procX.pid.KD);
  println("KP:"+procY.pid.KP+" KI:"+procY.pid.KI+" KD:"+procY.pid.KD);
  println("KP:"+procZ.pid.KP+" KI:"+procZ.pid.KI+" KD:"+procZ.pid.KD);
}

//button 
//Get and set the new values that are set graphically in the textfields//
public void Consign() {
  url1 =cp5.get(Textfield.class, "ThetaX").getText();
  Url1=int(url1); 
  url2 =cp5.get(Textfield.class, "ThetaY").getText();
  Url2=int(url2); 
  url3 =cp5.get(Textfield.class, "ThetaZ").getText();
  Url3=int(url3);
}

//Compute and plot the graphic lines on screen//
// create graph line for each Var
void graph(ArrayList Wave, int decalage) {

  if (Wave.size() >= waveLength) 
  {
    Wave.remove(0);
  }

  for (int i = 0; i < Wave.size(); i++)
  {
    stroke(255);   //for the color 
    if (prevX == 0 && prevY == 0)
    {
      prevX = i;
      prevY = ((float)Wave.get(i)*10);
    }
    if (prevX<i) {
      line(prevX+20, prevY+decalage, i+20, ((float)Wave.get(i))*10+decalage);  //we don't want to have a line joining the end to the begining of the graph
    }
    prevX = i;
    prevY = ((float)Wave.get(i))*10;
  }
}
