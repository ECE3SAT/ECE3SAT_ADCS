/******************************************************************************************************************************************/  //<>//
/*      Copyright ECE3SAT  /  ECE Paris                                                                                            ********/
/*      @author   : Gael GUEGAN & Jeremie MARTIN                                                                                   ********/  
/*      @version  : 1.0                                                                                                            ********/
/*      Objective : Display cubesat attitude from Nucleo IKS0A101 data                                                             ********/
/*                  sensors : gyroscope, accelerometer, magnetometer                                                               ********/
/*                                                                                                                                 ********/ 
/*      ... to complete ...                                                                                                        ********/
/*                                                                                                                                 ********/        
/*      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!       ********/
/*      !!!                                                                                                              !!!       ********/
/*      !!! DOWNLOAD/COPY/PASTE "Gwoptics" ON YOUR LIBRARIES FOLDER : file->preferences->sketchbookPath                  !!!       ********/
/*      !!!                                                                                                              !!!       ********/
/*      !!! https://github.com/ECE3SAT/ECE3SAT/tree/master/ADCS/Simulation/SimulationWithBoard/ProcessingCode/Libraries  !!!       ********/
/*      !!!                                                                                                              !!!       ********/
/*      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!       ********/
/*                                                                                                                                 ********/
/******************************************************************************************************************************************/


//Camera library
import peasy.*;

//Serial libray
import processing.serial.*;

//Graph library
import org.gwoptics.*;
import org.gwoptics.graphics.*;
import org.gwoptics.graphics.graph2D.*; 
import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.traces.*;
import org.gwoptics.graphics.graph2D.backgrounds.*; 




PeasyCam cam;
Cube cube;
Earth earth;
Graph gyroXGraph, gyroYGraph, gyroZGraph;
Graph attitudeXGraph, attitudeYGraph, attitudeZGraph;
Graph magnetoXGraph, magnetoYGraph, magnetoZGraph;
boolean pause=false;

/**
 *  Description : Setup function
 */
void setup() {
  
  // Window initialization in 3D mode
  size(1500, 900, P3D);
  //fullScreen(P3D);
  frameRate(60);
  textureMode(NORMAL);
  
  // Serial Port initialization
  serialInit();
  
  //Objects initialization
  cam = new PeasyCam(this, width/2, height/2, 0, 800);
  cam.setActive(false);
  cube = new Cube();
  earth = new Earth();
  
  //Graphs initialization
  gyroXGraph = new Graph(70, 150, 260, 150, new EquationGyroX(), "gyroX", "deg/s", -1200, +1200, 255, 0, 0);
  gyroYGraph = new Graph(70, 400, 260, 150, new EquationGyroY(), "gyroY", "deg/s", -1200, +1200, 0, 255, 0);
  gyroZGraph = new Graph(70, 650, 260, 150, new EquationGyroZ(), "gyroZ", "deg/s", -1200, +1200, 0, 0, 255);
  attitudeXGraph = new Graph(410, 150, 260, 150, new EquationAttitudeX(), "attitudeX", "deg", -180, +180, 255, 0, 0);
  attitudeYGraph = new Graph(410, 400, 260, 150, new EquationAttitudeY(), "attitudeY", "deg", -180, +180, 0, 255, 0);
  attitudeZGraph = new Graph(410, 650, 260, 150, new EquationAttitudeZ(), "attitudeZ", "deg", -180, +180, 0, 0, 255);
  magnetoXGraph = new Graph(750, 150, 260, 150, new EquationMagnetoX(), "magnetoX", "mGauss", -1000, +1000, 255, 0, 0);
  magnetoYGraph = new Graph(750, 400, 260, 150, new EquationMagnetoY(), "magnetoY", "mGauss", -1000, +1000, 0, 255, 0);
  magnetoZGraph = new Graph(750, 650, 260, 150, new EquationMagnetoZ(), "magnetoZ", "mGauss", -1000, +1000, 0, 0, 255);
    
}


/**
 *  Description : Infinite loop to draw sketch
 */
void draw() {
  
  background(0);
  writeSerial(10, 20, 18);
  writeHelp(width-300, 20, 17);
  cube.draw();
  earth.draw();
  
  gyroXGraph.draw();
  gyroYGraph.draw();
  gyroZGraph.draw();
  attitudeXGraph.draw();
  attitudeYGraph.draw();
  attitudeZGraph.draw();
  magnetoXGraph.draw();
  magnetoYGraph.draw();
  magnetoZGraph.draw();
  
}


/**
 *  Description : When the SPACEBAR key is pressed, we calibrate the cube attitude
 */
void keyPressed() {
  
  if(key == ' ') {
    cube.gyro.calibrate();
    cube.attitude.set(-PI/2, 0, 0);
    cube.attitudeQ.set(cos(-PI/4), sin(-PI/4), 0, 0);
    
    cube.accelero.calibrate();
    cube.position.set(0, 0, 0);
    
    //cube.magneto.calibrate();
  }
  
  if(key == 'c'){
    if(!cam.isActive())
      cam.setActive(true);
    else
      cam.setActive(false);  
  }
  
  if(key == 'p'){
    if(!pause){
    gyroXGraph.line2DTrace.pause();
    gyroYGraph.line2DTrace.pause();
    gyroZGraph.line2DTrace.pause();
    attitudeXGraph.line2DTrace.pause();
    attitudeYGraph.line2DTrace.pause();
    attitudeZGraph.line2DTrace.pause();
    magnetoXGraph.line2DTrace.pause();
    magnetoYGraph.line2DTrace.pause();
    magnetoZGraph.line2DTrace.pause();
    pause=true;
    }
    else{
      gyroXGraph.line2DTrace.unpause();
      gyroYGraph.line2DTrace.unpause();
      gyroZGraph.line2DTrace.unpause();
      attitudeXGraph.line2DTrace.unpause();
      attitudeYGraph.line2DTrace.unpause();
      attitudeZGraph.line2DTrace.unpause();
      magnetoXGraph.line2DTrace.unpause();
      magnetoYGraph.line2DTrace.unpause();
      magnetoZGraph.line2DTrace.unpause();
      pause=false;
    }
  }
  
}