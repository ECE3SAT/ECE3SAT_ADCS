/****************************************************
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
int size = 35;

//Graph
ArrayList waveX = new ArrayList();
ArrayList waveY = new ArrayList();
ArrayList waveZ = new ArrayList();
int waveLength = 300;   /// length for graph
float prevX = 0, prevY = 0;



Test_PID procX = new Test_PID();
Test_PID procY = new Test_PID();
Test_PID procZ = new Test_PID();
float KP, KI, KD;
float threshold=5;
Boolean PIDact = false;


void settings() {
  size(1920, 1080, P3D);
}

void setup() 
{
  textSize(size);
  frameRate(35);
  earthImage=loadImage("earth.jpg");
  cubePosOnScreen.set(2*width/3, height/3, 0);
  earthPos.set(width/4, 3*height/4, 250);

  //creat text field
  // Copy paste to add new text field
  cp5 = new ControlP5(this);
  cp5.addTextfield("ThetaX").setPosition(30, 20+9*size).setSize(42+size, 2+size).setAutoClear(false).setFont(createFont("arial",size/2));
  cp5.addTextfield("ThetaY").setPosition(30,20+11*size).setSize(42+size, 2+size).setAutoClear(false).setFont(createFont("arial",size/2));
  cp5.addTextfield("ThetaZ").setPosition(30, 20+13*size).setSize(42+size, 2+size).setAutoClear(false).setFont(createFont("arial",size/2));
  cp5.addTextfield("KP").setPosition(1700, 650+2*size).setSize(42+size, 2+size).setAutoClear(false).setFont(createFont("arial",size/2));
  cp5.addTextfield("KI").setPosition(1700, 650+4*size).setSize(42+size, 2+size).setAutoClear(false).setFont(createFont("arial",size/2));
  cp5.addTextfield("KD").setPosition(1700, 650+6*size).setSize(42+size, 2+size).setAutoClear(false).setFont(createFont("arial",size/2));
  cp5.addTextfield("threshold").setPosition(1700, 650+8*size).setSize(42+size, 2+size).setAutoClear(false).setFont(createFont("arial",size/2));

  cp5.addButton("Reset").setValue(128).setPosition(1700,150).setSize(42+size, 2+size).setFont(createFont("arial",size/3));
  cp5.addButton("PID").setValue(128).setPosition(1700,150+2*size).setSize(42+size, 2+size).setFont(createFont("arial",size/3));
  cp5.addButton("Consign").setValue(128).setPosition(120,20+9*size).setSize(42+size, 2+size).setFont(createFont("arial",size/3));
  cp5.addButton("Param").setValue(128).setPosition(1700, 650+10*size).setSize(42+size, 2+size).setFont(createFont("arial",size/3));
  
}




void draw()
{
  background(0);

  if (counterTime>1) {
    if(PIDact) calPID();
    else {
      thetaX=radians(procX.offPID());
      thetaY=radians(procY.offPID());
      thetaZ=radians(procZ.offPID());
    }
      
    waveX.add(thetaX);
    graph(waveX, 60+16*size,0,180,180);
    fill(0,180,180);
    text("theatX", 20, 20+16*size);
    waveY.add(thetaY);
    graph(waveY, 60+21*size,255,125,180);
    fill(255,125,180);
    text("theatY", 20, 20+21*size);
    waveZ.add(thetaZ);
    graph(waveZ, 60+26*size,255,0,255);
    fill(255,0,255);
    text("theatZ", 20, 20+26*size);
    
  }
  counterTime++;
  //Draw elements
  writeParam(10, 20, size);
  drawCube(cubePosOnScreen.x+cubePos.x, cubePosOnScreen.y+cubePos.z, cubePosOnScreen.z+cubePos.y, thetaX, thetaY, thetaZ, CubeSize);
  drawEarth(earthPos.x, earthPos.y, earthPos.z);
}



/// launche PID Cal

void calPID() {  // edit val for parameter 
  thetaX=radians(procX.myEvaluation(Url1, thetaX));
  thetaY=radians(procY.myEvaluation(Url2, thetaY));
  thetaZ=radians(procZ.myEvaluation(Url3, thetaZ));
}


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
public void Consign() {
  url1 =cp5.get(Textfield.class, "ThetaX").getText();
  Url1=int(url1)%360; 
  url2 =cp5.get(Textfield.class, "ThetaY").getText();
  Url2=int(url2)%360; 
  url3 =cp5.get(Textfield.class, "ThetaZ").getText();
  Url3=int(url3)%360;
}


// create graph line for each Var
void graph(ArrayList Wave, int decalage,int r,int g ,int b) {

  if (Wave.size() >= waveLength) 
  {
    Wave.remove(0);
  }

  for (int i = 0; i < Wave.size(); i++)
  {
     
    if (prevX == 0 && prevY == 0)
    {
      prevX = i;
      prevY = ((float)Wave.get(i)*10);
    }
    if (prevX<i) {
      line(prevX+20, prevY+decalage, i+20, ((float)Wave.get(i))*10+decalage);  //we don't want to have a line joining the end to the begining of the graph
       stroke(r,g,b);
    }
    prevX = i;
    prevY = ((float)Wave.get(i))*10;
  }
  
}
 
 void Reset(){
   KP=0.1;
   KI=0;
   KD=0;
  procY.pid.KP=procZ.pid.KP=procX.pid.KP=KP; 
   procY.pid.KI=procZ.pid.KI=procX.pid.KI=KI;
  procY.pid.KD=procZ.pid.KD=procX.pid.KD=KD;
 }
 
 void PID(){
  if (PIDact) PIDact=false;
  else PIDact=true;
 }
 