
ArrayList<PVector> graphArray1X = new ArrayList();
ArrayList<PVector> graphArray1Y = new ArrayList();
ArrayList<PVector> graphArray1Z = new ArrayList();

ArrayList<PVector> graphArray2X = new ArrayList();
ArrayList<PVector> graphArray2Y = new ArrayList();
ArrayList<PVector> graphArray2Z = new ArrayList();

ArrayList<PVector> graphArray3X = new ArrayList();
ArrayList<PVector> graphArray3Y = new ArrayList();
ArrayList<PVector> graphArray3Z = new ArrayList();

boolean displayUI = true;
boolean displayUIReset = false;

short displayMode = 0;  // Mode 0: Graph
                        // Mode 1: Change value

String graphName1;
String graphName2;
String graphName3;

float graph1Xmin = 0;
float graph1Xmax = 0;
float graph1Xmoy = 0;
float graph1Ymin = 0;
float graph1Ymax = 0;
float graph1Ymoy = 0;
float graph1Zmin = 0;
float graph1Zmax = 0;
float graph1Zmoy = 0;

float graph2Xmin = 0;
float graph2Xmax = 0;
float graph2Xmoy = 0;
float graph2Ymin = 0;
float graph2Ymax = 0;
float graph2Ymoy = 0;
float graph2Zmin = 0;
float graph2Zmax = 0;
float graph2Zmoy = 0;

float graph3Xmin = 0;
float graph3Xmax = 0;
float graph3Xmoy = 0;
float graph3Ymin = 0;
float graph3Ymax = 0;
float graph3Ymoy = 0;
float graph3Zmin = 0;
float graph3Zmax = 0;
float graph3Zmoy = 0;

String displayValueName1;
String displayValue1;
String displayValueName2;
String displayValue2;
String displayValueName3;
String displayValue3;

int index = 0;

void initGraph()
{
  for(int i=1; i<200; i++){
    graphArray1X.add( new PVector(0, 0, 0) );
    graphArray1Y.add( new PVector(0, 0, 0) );
    graphArray1Z.add( new PVector(0, 0, 0) );
    
    graphArray2X.add( new PVector(0, 0, 0) );
    graphArray2Y.add( new PVector(0, 0, 0) );
    graphArray2Z.add( new PVector(0, 0, 0) );
    
    graphArray3X.add( new PVector(0, 0, 0) );
    graphArray3Y.add( new PVector(0, 0, 0) );
    graphArray3Z.add( new PVector(0, 0, 0) );
    index = i;
  }
}

  
void drawUI()
{
  fill(200);
  
   int posX = width -500;
   int posY = 50;
   int sizeX = 480;
   int sizeY = height -100;
  
  rect(posX, posY, sizeX, sizeY);
  
  textSize(20);
  fill(0, 102, 153);
  text(graphName1,posX+50,posY+40);
  
  float scale1,scale1Max,scale1Min;
  
  scale1Max = Math.max(Math.max(graph1Xmax,graph1Ymax),graph1Zmax);
  scale1Min = Math.min(Math.min(graph1Xmin,graph1Ymin),graph1Zmin);
  
  scale1 = 1/(scale1Max - scale1Min);
  
  for(int i=1; i<graphArray1X.size(); i++){
    stroke(255,0,0);
    line(posX + (i-1) * 2 + 20,posY + sizeY/6 + graphArray1X.get(i-1).y * (50 - sizeY/6) * scale1,posX + (i) * 2 + 20,posY + sizeY/6 + graphArray1X.get(i).y * (50 - sizeY/6) * scale1);
    stroke(50,140,50);
    line(posX + (i-1) * 2 + 20,posY + sizeY/6 + graphArray1Y.get(i-1).y * (50 - sizeY/6) * scale1,posX + (i) * 2 + 20,posY + sizeY/6 + graphArray1Y.get(i).y * (50 - sizeY/6) * scale1);
    stroke(0,0,255);
    line(posX + (i-1) * 2 + 20,posY + sizeY/6 + graphArray1Z.get(i-1).y * (50 - sizeY/6) * scale1,posX + (i) * 2 + 20,posY + sizeY/6 + graphArray1Z.get(i).y * (50 - sizeY/6) * scale1);
  }
  
  textSize(10);
  fill(255, 0, 0);
  text(graphArray1X.get(graphArray1X.size()-1).y,posX+440,posY-40+sizeY/6);
  textSize(10);
  fill(50,140,50);
  text(graphArray1Y.get(graphArray1X.size()-1).y,posX+440,posY-30+sizeY/6);
  textSize(10);
  fill(0, 0, 255);
  text(graphArray1Z.get(graphArray1X.size()-1).y,posX+440,posY-20+sizeY/6);
  
  textSize(20);
  fill(0, 102, 153);
  text(graphName2,posX+50,posY+40+sizeY/3);
  
  float scale2,scale2Max,scale2Min;
  
  scale2Max=Math.max(Math.max(graph2Xmax,graph2Ymax),graph2Zmax);
  scale2Min=Math.min(Math.min(graph2Xmin,graph2Ymin),graph2Zmin);
  
  scale2 =  1/(scale2Max - scale2Min);
  
  
  for(int i=1; i<graphArray2X.size(); i++){
    stroke(255,0,0);
    line(posX + (i-1) * 2 + 20,posY + sizeY/2 + graphArray2X.get(i-1).y * (50 - sizeY/6) * scale2,posX + (i) * 2 + 20,posY + sizeY/2 + graphArray2X.get(i).y * (50 - sizeY/6) * scale2);
    stroke(50,140,50);
    line(posX + (i-1) * 2 + 20,posY + sizeY/2 + graphArray2Y.get(i-1).y * (50 - sizeY/6) * scale2,posX + (i) * 2 + 20,posY + sizeY/2 + graphArray2Y.get(i).y * (50 - sizeY/6) * scale2);
    stroke(0,0,255);
    line(posX + (i-1) * 2 + 20,posY + sizeY/2 + graphArray2Z.get(i-1).y * (50 - sizeY/6) * scale2,posX + (i) * 2 + 20,posY + sizeY/2 + graphArray2Z.get(i).y * (50 - sizeY/6) * scale2);
  }
  textSize(10);
  fill(255, 0, 0);
  text(graphArray2X.get(graphArray2X.size()-1).y,posX+440,posY-40+sizeY/2);
  textSize(10);
  fill(50,140,50);
  text(graphArray2Y.get(graphArray2X.size()-1).y,posX+440,posY-30+sizeY/2);
  textSize(10);
  fill(0, 0, 255);
  text(graphArray2Z.get(graphArray2X.size()-1).y,posX+440,posY-20+sizeY/2);
  
  
  textSize(20);
  fill(0, 102, 153);
  text(graphName3,posX+50,posY+40+2*sizeY/3);
  
  
  float scale3,scale3Max,scale3Min;
  
  scale3Max=Math.max(Math.max(graph3Xmax,graph3Ymax),graph3Zmax);
  scale3Min=Math.min(Math.min(graph3Xmin,graph3Ymin),graph3Zmin);
  
  scale3 =  1/((scale3Max - scale3Min));
  
  for(int i=1; i<graphArray3X.size(); i++){
    stroke(255,0,0);
    line(posX + (i-1) * 2 + 20,posY + 5*sizeY/6 + graphArray3X.get(i-1).y * (50 - sizeY/6) * scale3,posX + (i) * 2 + 20,posY + 5*sizeY/6 + graphArray3X.get(i).y * (50 - sizeY/6) * scale3);
    stroke(50,140,50);
    line(posX + (i-1) * 2 + 20,posY + 5*sizeY/6 + graphArray3Y.get(i-1).y * (50 - sizeY/6) * scale3,posX + (i) * 2 + 20,posY + 5*sizeY/6 + graphArray3Y.get(i).y * (50 - sizeY/6) * scale3);
    stroke(0,0,255);
    line(posX + (i-1) * 2 + 20,posY + 5*sizeY/6 + graphArray3Z.get(i-1).y * (50 - sizeY/6) * scale3,posX + (i) * 2 + 20,posY + 5*sizeY/6 + graphArray3Z.get(i).y * (50 - sizeY/6) * scale3);
  }
  
  textSize(10);
  fill(255, 0, 0);
  text(graphArray3X.get(graphArray3X.size()-1).y,posX+440,posY-40+5*sizeY/6);
  textSize(10);
  fill(50,140,50);
  text(graphArray3Y.get(graphArray3X.size()-1).y,posX+440,posY-30+5*sizeY/6);
  textSize(10);
  fill(0, 0, 255);
  text(graphArray3Z.get(graphArray3X.size()-1).y,posX+440,posY-20+5*sizeY/6);
  
  
  // DISPLAY TEXT
  textSize(12);
  fill(0, 0, 0);
  text(displayValueName1+":",posX+40,posY+80+5*sizeY/6);
  textSize(11);
  text(displayValue1,posX+150,posY+80+5*sizeY/6);
  
  textSize(12);
  fill(0, 0, 0);
  text(displayValueName2+":",posX+40,posY+100+5*sizeY/6);
  textSize(11);
  text(displayValue2,posX+150,posY+100+5*sizeY/6);
  
  
  cp5.draw();
  
  cpBdot.draw();
  
  cpToggle.draw();
  
}

void drawUIReset()
{
  
  fill(200);
  
  int posX = width -500;
  int posY = 50;
  int sizeX = 480;
  int sizeY = 200;
  
  rect(posX, posY, sizeX, sizeY);
    
  cpReset.draw();
  
  cpToggle.draw();
}


void addPlotGraph1(float paramX,float paramY,float paramZ, String name)
{
  graphName1 = name;
  if(index<200)
  {
    graphArray1X.add( new PVector(index, paramX, 0) );
    graphArray1Y.add( new PVector(index, paramY, 0) );
    graphArray1Z.add( new PVector(index, paramZ, 0) );
    index++;
  }
  else
  {
    graphArray1X.remove(0);
    graphArray1Y.remove(0);
    graphArray1Z.remove(0);
    
    graphArray1X.add( new PVector(index, paramX, 0) );
    graphArray1Y.add( new PVector(index, paramY, 0) );
    graphArray1Z.add( new PVector(index, paramZ, 0) );
  }
  if(paramX < graph1Xmin)graph1Xmin = paramX;
  if(paramX > graph1Xmax)graph1Xmax = paramX;
  
  if(paramY < graph1Ymin)graph1Ymin = paramY;
  if(paramY > graph1Ymax)graph1Ymax = paramY;
  
  if(paramZ < graph1Zmin)graph1Zmin = paramZ;
  if(paramZ > graph1Zmax)graph1Zmax = paramZ;
}
  
void addPlotGraph2(float paramX,float paramY,float paramZ, String name)
{
  graphName2 = name;
  if(index<200)
  {
    graphArray2X.add( new PVector(index, paramX, 0) );
    graphArray2Y.add( new PVector(index, paramY, 0) );
    graphArray2Z.add( new PVector(index, paramZ, 0) );
    index++;
  }
  else
  {
    graphArray2X.remove(0);
    graphArray2Y.remove(0);
    graphArray2Z.remove(0);
    
    graphArray2X.add( new PVector(index, paramX, 0) );
    graphArray2Y.add( new PVector(index, paramY, 0) );
    graphArray2Z.add( new PVector(index, paramZ, 0) );
  }
  
  if(paramX < graph2Xmin)graph2Xmin = paramX;
  if(paramX > graph2Xmax)graph2Xmax = paramX;
  
  if(paramY < graph2Ymin)graph2Ymin = paramY;
  if(paramY > graph2Ymax)graph2Ymax = paramY;
  
  if(paramZ < graph2Zmin)graph2Zmin = paramZ;
  if(paramZ > graph2Zmax)graph2Zmax = paramZ;
}

void addPlotGraph3(float paramX,float paramY,float paramZ, String name)
{
  graphName3 = name;
  if(index<200)
  {
    graphArray3X.add( new PVector(index, paramX, 0) );
    graphArray3Y.add( new PVector(index, paramY, 0) );
    graphArray3Z.add( new PVector(index, paramZ, 0) );
    index++;
  }
  else
  {
    graphArray3X.remove(0);
    graphArray3Y.remove(0);
    graphArray3Z.remove(0);
    
    graphArray3X.add( new PVector(index, paramX, 0) );
    graphArray3Y.add( new PVector(index, paramY, 0) );
    graphArray3Z.add( new PVector(index, paramZ, 0) );
  }
  
  if(paramX < graph3Xmin)graph3Xmin = paramX;
  if(paramX > graph3Xmax)graph3Xmax = paramX;
  
  if(paramY < graph3Ymin)graph3Ymin = paramY;
  if(paramY > graph3Ymax)graph3Ymax = paramY;
  
  if(paramZ < graph3Zmin)graph3Zmin = paramZ;
  if(paramZ > graph3Zmax)graph3Zmax = paramZ;
}

void displayValue1(String name, float value)
{
  displayValueName1 = name;
  displayValue1 = Float.toString(value);
}


void displayValue2(String name, float value)
{
  displayValueName2 = name;
  displayValue2 = Float.toString(value);
}