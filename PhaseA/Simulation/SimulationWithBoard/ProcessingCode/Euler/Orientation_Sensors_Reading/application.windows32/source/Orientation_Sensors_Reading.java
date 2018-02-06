import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 
import processing.serial.*; 
import org.gwoptics.*; 
import org.gwoptics.graphics.*; 
import org.gwoptics.graphics.graph2D.*; 
import org.gwoptics.graphics.graph2D.Graph2D; 
import org.gwoptics.graphics.graph2D.traces.*; 
import org.gwoptics.graphics.graph2D.backgrounds.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Orientation_Sensors_Reading extends PApplet {

/******************************************************************************************************************************************/ 
/*      Copyright ECE3SAT  /  ECE Paris                                                                                            ********/
/*      Code written by Gael GUEGAN & Jeremie MARTIN                                                                               ********/
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


//Serial libray


//Graph library


 


 




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
public void setup() {
  
  // Window initialization in 3D mode
  
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
public void draw() {
  
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
public void keyPressed() {
  
  if(key == ' ') {
    cube.gyro.calibrate();
    cube.attitude.set(-PI/2, 0, 0);
    
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
public class Accelerometer extends SpatialSensor {
  
  public Accelerometer() {
    super();
  }
  
  public void calibrate() {
    calibration = received.copy();
  }
  
}
/**
 *    Description :  This Class defines a Cube object
 */
public class Cube {
  
  public int size;
  
  public PVector attitude;      // in radians
  public PVector speedAng;      // Angular speed in rad.s-1
  
  public PVector position;      // in m
  public PVector positionInit;  // in m
  public PVector speedLin;      // Linear speed in m.s-1
  public PVector acceleration;  // in m.s-2
  
  public PVector magneticField; // in mgauss
  
  public Gyroscope gyro;
  public Accelerometer accelero;
  public Magnetometer magneto;
  
  
  /**
   *  Description : Default cube constructor
   */
  public Cube() {
    size = 80;
    
    attitude = new PVector(0, 0, 0);
    speedAng = new PVector(0, 0, 0);
    
    position = new PVector(0, 0, 0);
    positionInit = new PVector(7*width/8, 2*height/5, 0);

    speedLin = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    
    magneticField = new PVector(0, 0, 0);
    
    gyro = new Gyroscope();
    accelero = new Accelerometer();
    magneto = new Magnetometer();

  }
  

  ///========================= Angular motion =========================///

  /**
   *    Description : Update Angular Speed
   */
  protected void updateAngularSpeed() {
    float p, q, r;
    
    p = -radians(gyro.data.x/1000); // Conversion from md.s-1 to rad.s-1
    q = -radians(gyro.data.y/1000);
    r = radians(gyro.data.z/1000);
    
    speedAng.x = p + sin(attitude.x)*tan(attitude.y)*q + cos(attitude.x)*tan(attitude.y)*r;
    speedAng.y = cos(attitude.x)*q - sin(attitude.x)*r;
    speedAng.z = (sin(attitude.x)/cos(attitude.y))*q + (cos(attitude.x)/cos(attitude.y))*r;
  }
  
  
  /**
   *    Description : Calculate anglePosition from speedAngle                    
   *                  anglePosition = integral[ speedAngle ] between T1 and T2 
   */
  public void updateAttitude() {
    updateAngularSpeed();
    
    attitude.x += speedAng.x*gyro.readTimeDelta;
    attitude.y += speedAng.y*gyro.readTimeDelta;
    attitude.z += speedAng.z*gyro.readTimeDelta;
  }
  
  
  /**
   *    Description : 
   *
   *    @param x     : 
   *    @param y     : 
   *    @param z     : 
   */
  public void gyroEvent(float x, float y, float z) {
    gyro.updateReadTime();
    updateAttitude();
    gyro.read(x, y, z);
  }
  
  

  ///========================= Linear motion =========================///
  
  /**
   *    Description : 
   */
  public void updateAcceleration() {
    acceleration = PVector.mult(accelero.data, 0.00981f); // Convertion from mg to m.s-2
  }
  
  
  /**
   *    Description :  Calculate linear speed from acceleration
   */
  public void updateLinearSpeed() {
    updateAcceleration();
    // ... To do
    //Vitesse=Integral( acceleration ) entre T1 et T2
    //cube.speedLin.x = cube.speedLin.x + accelero.x * timesec;
  }
  
  
  /**
   *    Description : Calculate position from linear speed
   */
  public void updatePosition() {
    updateLinearSpeed();
    // ... To do
    //Position=Integral( vitesse ) entre T1 et T2
    //position.x = position.x + speedLin.x*timesec + 1/2*accelero.x * timesec*timesec;
  }
  
  
  /**
   *    Description :              
   *                  
   *    @param x    :                   
   *    @param y    :                   
   *    @param z    : 
   */
  public void acceleroEvent(float x, float y, float z) {
    accelero.updateReadTime();
    updatePosition();
    accelero.read(x, y, z);
  }
  
  
  ///========================= Magnetic field data =========================///

  /**
   *    Description : Calculate position from linear speed
   */
  public void updateMagneticField() {
    magneticField.set(magneto.data.y, -magneto.data.x, magneto.data.z);
  }
  
  /**
   *    Description  : 
   *                  
   *    @param  x    : 
   *    @param  y    : 
   *    @param  z    : 
   */
  public void magnetoEvent(float x, float y, float z) {
    magneto.updateReadTime();
    updateMagneticField();
    magneto.read(x, y, z);
  }
  
  
  ///========================= Display =========================///

  /**
   *    Description : Creates the cube's colored shape             
   *                  
   *    @param      : none
   *    @return     : none
   */
  private void shape(){
    beginShape(QUADS);
    fill(0, 1, 1);      //cyan
    vertex(-1,  1,  1);  vertex( 1,  1,  1);  vertex( 1, -1,  1);  vertex(-1, -1,  1);
    fill(1, 1, 1);      //blanc
    vertex( 1,  1,  1);  vertex( 1,  1, -1);  vertex( 1, -1, -1);  vertex( 1, -1,  1);
    fill(1, 1, 0);      //jaune
    vertex( 1,  1, -1);  vertex(-1,  1, -1);  vertex(-1, -1, -1);  vertex( 1, -1, -1);
    fill(0, 1, 0);      //bleu
    vertex(-1,  1, -1);  vertex(-1,  1,  1);  vertex(-1, -1,  1);  vertex(-1, -1, -1);
    fill(0, 0, 1);      //vert
    vertex(-1,  1, -1);  vertex( 1,  1, -1);  vertex( 1,  1,  1);  vertex(-1,  1,  1);
    fill(1, 0, 0);      //rouge
    vertex(-1, -1, -1);  vertex( 1, -1, -1);  vertex( 1, -1,  1);  vertex(-1, -1,  1);
    endShape();
    
  }
  
  /**
   *    Description : Displays the cube
   */
  public void draw() {
    pushMatrix();
    pushStyle();
    
    translate(position.x+positionInit.x, position.y+positionInit.y, position.z+positionInit.z);
    
    rotateZ(attitude.z);
    rotateY(attitude.y);
    rotateX(attitude.x);
    
    scale(size);
    stroke(255);
    strokeWeight(0.02f);
    colorMode(RGB, 1);
    
    shape(); //box(cube.size);
  
    popMatrix();
    popStyle();
    
    //drawMagneticFieldVector();
  }
  
  
  /**
   *  Description : Draw Magnetometer Vector
   */
  public void drawMagneticFieldVector(){
    //Data rescaled for drawing on screen
    int vectorColor = color(255, 0, 0);
    PVector position = new PVector(this.positionInit.x, this.positionInit.y + 200, 0);
    
    pushStyle();
    pushMatrix();
    
    //Color drawing
    stroke(vectorColor);
    fill(vectorColor);
    strokeWeight(2);
    
    //Positionning
    translate(position.x, position.y, position.z);
    
    
    if(magneticField.mag() != 0) {
      //line(0, 0, 0, drawData.y, -drawData.x, drawData.z);   //on inverse les axes car les mems ne sont pas orient\u00e9 dans le m\u00eame sens
      //line(0, 0, 0, drawData.x, drawData.y, drawData.z);
      line(0, 0, 0, magneticField.x, magneticField.y, magneticField.z);
      //rotate(atan2(drawData.y-position.y,drawData.x-position.x));
      //triangle(-mag/5, -mag/10, 0, 0, -mag/5, mag/10);
    }
    
    popMatrix();
    popStyle();                      
  }
  
}
 /**
  *    Description  : Display data on screen from serial communication          
  *
  *    @param x     : x coordinate which corresponds to the upper corner left
  *    @param y     : y coordinate which corresponds to the upper corner left
  *    @param size  : size of the text
  */
public void writeSerial(float x, float y, int size){
  pushStyle();
  textSize(size);
 
  fill(255,0,0);text("X", x+120, y);fill(0,255,0);text("Y", x+260, y);fill(0,0,255);text("Z", x+400, y);fill(255,255,255);text("Unit", x+520, y);
  
  text("magneto :", x, y+1*size);
    text(cube.magneto.data.x, x+100, y+1*size);
    text(cube.magneto.data.y, x+240, y+1*size);
    text(cube.magneto.data.z, x+380, y+1*size);
    text("mgauss", x+500, y+1*size);
  text("gyro :", x, y+2*size);
    text(cube.gyro.data.x, x+100, y+2*size);
    text(cube.gyro.data.y, x+240, y+2*size);
    text(cube.gyro.data.z, x+380, y+2*size);
    text("mdps", x+500, y+2*size);
  text("attitude :", x, y+3*size);
    text(degrees(cube.attitude.x), x+100, y+3*size);
    text(degrees(cube.attitude.y), x+240, y+3*size);
    text(degrees(cube.attitude.z), x+380, y+3*size);
    text("deg", x+500, y+3*size);
  text("accelero :", x, y+4*size);
    text(cube.accelero.data.x, x+100, y+4*size);
    text(cube.accelero.data.y, x+240, y+4*size);
    text(cube.accelero.data.z, x+380, y+4*size);
    text("mg", x+500, y+4*size);
  text("position :", x, y+5*size);
    text(cube.position.x, x+100, y+5*size);
    text(cube.position.y, x+240, y+5*size);
    text(cube.position.z, x+380, y+5*size);
    text("m", x+500, y+5*size);
 
  popStyle();
}


 /**
  *    Description  : Display help text on screen          
  *
  *    @param x     : x coordinate which corresponds to the upper corner left
  *    @param y     : y coordinate which corresponds to the upper corner left
  *    @param size  : size of the text
  */
public void writeHelp(int x, int y, int size){
  pushStyle();
  textSize(size);
  stroke(255);
  
  text("Camera Help :", x, y-3); 
  line(x, y, x+80, y);
    text("+ Press \"C\" to activate or deactivate", x, y+1*size);
    text("+ Drag the left click to rotate", x, y+2*size);
    text("+ Use the mouse wheel to zoom", x, y+3*size);
    text("+ Double click to reset view", x, y+4*size);
    
  text("Calibration :", x, y+6*size-3);
  line(x, y+6*size, x+80, y+6*size);
    text("+ Press \"SPACEBAR\" to calibrate", x, y+7*size);
  
  text("Graphs :", x, y+8*size-3);
  line(x, y+8*size, x+80, y+8*size);
  text("+ Press \"SPACEBAR\" to calibrate", x, y+7*size);
  
  popStyle();
  
  if(!deviceConnected){
    pushStyle();
    textSize(20);
    fill(255, 0, 0);
    text("PORT NOT FOUND !!!  Connect Your Device", 0.48f*width, 50);
    popStyle();
  }
}
/**
 *    Description : This Class defines Earth object
 *
 */
public class Earth {
     
  private int size;
  private PShape globe;
  private PVector position;
  private float angle;
  
  /**
   *  Description : Constructor which initializes Earth object
   */
  public Earth() {
    size = 150;
    
    pushStyle();
    noStroke();
    sphereDetail(100);
    globe = createShape(SPHERE, size);
    globe.setTexture(loadImage("earth.jpg"));
    popStyle();
    
    position = new PVector(1.3f*width, 1.3f*height, -800);
    angle = 0;
  }
  
  
  /**
   *  Description : Display Earth
   */
  public void draw(){
    pushMatrix();
    
    translate( position.x, position.y, position.z);
    
    rotateX(radians(-20));
    rotateY(radians(angle));
    angle = angle + PI/10;

    shape(globe);
    
    popMatrix();
  }
  
  
}

public class Graph {
  private Graph2D graph2D;
  private RollingLine2DTrace line2DTrace;
  private GridBackground background;
  
  public Graph(int positionX, int positionY, int graphWidth, int graphHeight, ILine2DEquation data, String xLabel, String yLabel, int yMin, int yMax, int R, int V, int B){

    graph2D = new Graph2D(Orientation_Sensors_Reading.this, graphWidth, graphHeight, false);
    line2DTrace = new RollingLine2DTrace(data, 100, 0.1f); //arg[0] = equation, arg[1] = refreshRate in ms, arg[2] = xIncr amount X-axis increase every update
    line2DTrace.setLineWidth(2);
    line2DTrace.setTraceColour(R, V, B);
    background = new GridBackground(new GWColour(240));
    
    graph2D.setBackground(background);
    graph2D.setYAxisMin(yMin);
    graph2D.setYAxisMax(yMax);
    graph2D.setXAxisMax(+10);
    graph2D.setFontColour(255,255,255);
    graph2D.setXAxisLabel(xLabel);
    graph2D.setYAxisLabel(yLabel);
    graph2D.setXAxisTickSpacing(2);
    graph2D.setYAxisTickSpacing((yMax-yMin)/4);//500);//(YMax-YMin)/5);
    
    graph2D.position.x=positionX;
    graph2D.position.y=positionY;
    
    graph2D.addTrace(line2DTrace);     
  }
  
  public void draw(){
    graph2D.draw();
  }
  
}

class EquationGyroX implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.gyro.data.x/1000;
  }
}
class EquationGyroY implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.gyro.data.y/1000;
  }
}
class EquationGyroZ implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.gyro.data.z/1000;
  }
}
class EquationAttitudeX implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return degrees(cube.attitude.x);
  }
}
class EquationAttitudeY implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return degrees(cube.attitude.y);
  }
}
class EquationAttitudeZ implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return degrees(cube.attitude.z);
  }
}
class EquationMagnetoX implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.magneto.data.x;
  }
}
class EquationMagnetoY implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.magneto.data.y;
  }
}
class EquationMagnetoZ implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.magneto.data.z;
  }
}
public class Gyroscope extends SpatialSensor {
    
  public Gyroscope() {
    super();
  }
  
  public void calibrate() {
    calibration = received.copy();
  }

}
public class Magnetometer extends SpatialSensor {
  

  /**
   *  Description : Constructor which initializes magnetometer vector
   */
  public Magnetometer() {
    super();
  }

  
  /**
   *  Description : Calibrate
   */
  public void calibrate() {
    calibration = received.copy();
  }
 
}
/******************************************************************************
 *  Compilation:  javac Matrix.java
 *  Execution:    java Matrix
 *
 *  A bare-bones immutable data type for M-by-N matrices.
 *
 ******************************************************************************/

final public class Matrix {
    private final int M;             // number of rows
    private final int N;             // number of columns
    private final double[][] data;   // M-by-N array

    // create M-by-N matrix of 0's
    public Matrix(int M, int N) {
        this.M = M;
        this.N = N;
        data = new double[M][N];
    }

    // create matrix based on 2d array
    public Matrix(double[][] data) {
        M = data.length;
        N = data[0].length;
        this.data = new double[M][N];
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                    this.data[i][j] = data[i][j];
    }

    // copy constructor
    private Matrix(Matrix A) { this(A.data); }

    // create and return a random M-by-N matrix with values between 0 and 1
    public  Matrix random(int M, int N) {
        Matrix A = new Matrix(M, N);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                A.data[i][j] = Math.random();
        return A;
    }

    // create and return the N-by-N identity matrix
    public  Matrix identity(int N) {
        Matrix I = new Matrix(N, N);
        for (int i = 0; i < N; i++)
            I.data[i][i] = 1;
        return I;
    }

    // swap rows i and j
    private void swap(int i, int j) {
        double[] temp = data[i];
        data[i] = data[j];
        data[j] = temp;
    }

    // create and return the transpose of the invoking matrix
    public Matrix transpose() {
        Matrix A = new Matrix(N, M);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                A.data[j][i] = this.data[i][j];
        return A;
    }

    // return C = A + B
    public Matrix plus(Matrix B) {
        Matrix A = this;
        if (B.M != A.M || B.N != A.N) throw new RuntimeException("Illegal matrix dimensions.");
        Matrix C = new Matrix(M, N);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                C.data[i][j] = A.data[i][j] + B.data[i][j];
        return C;
    }


    // return C = A - B
    public Matrix minus(Matrix B) {
        Matrix A = this;
        if (B.M != A.M || B.N != A.N) throw new RuntimeException("Illegal matrix dimensions.");
        Matrix C = new Matrix(M, N);
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                C.data[i][j] = A.data[i][j] - B.data[i][j];
        return C;
    }

    // does A = B exactly?
    public boolean eq(Matrix B) {
        Matrix A = this;
        if (B.M != A.M || B.N != A.N) throw new RuntimeException("Illegal matrix dimensions.");
        for (int i = 0; i < M; i++)
            for (int j = 0; j < N; j++)
                if (A.data[i][j] != B.data[i][j]) return false;
        return true;
    }

    // return C = A * B
    public Matrix times(Matrix B) {
        Matrix A = this;
        if (A.N != B.M) throw new RuntimeException("Illegal matrix dimensions.");
        Matrix C = new Matrix(A.M, B.N);
        for (int i = 0; i < C.M; i++)
            for (int j = 0; j < C.N; j++)
                for (int k = 0; k < A.N; k++)
                    C.data[i][j] += (A.data[i][k] * B.data[k][j]);
        return C;
    }


    // return x = A^-1 b, assuming A is square and has full rank
    public Matrix solve(Matrix rhs) {
        if (M != N || rhs.M != N || rhs.N != 1)
            throw new RuntimeException("Illegal matrix dimensions.");

        // create copies of the data
        Matrix A = new Matrix(this);
        Matrix b = new Matrix(rhs);

        // Gaussian elimination with partial pivoting
        for (int i = 0; i < N; i++) {

            // find pivot row and swap
            int max = i;
            for (int j = i + 1; j < N; j++)
                if (Math.abs(A.data[j][i]) > Math.abs(A.data[max][i]))
                    max = j;
            A.swap(i, max);
            b.swap(i, max);

            // singular
            if (A.data[i][i] == 0.0f) throw new RuntimeException("Matrix is singular.");

            // pivot within b
            for (int j = i + 1; j < N; j++)
                b.data[j][0] -= b.data[i][0] * A.data[j][i] / A.data[i][i];

            // pivot within A
            for (int j = i + 1; j < N; j++) {
                double m = A.data[j][i] / A.data[i][i];
                for (int k = i+1; k < N; k++) {
                    A.data[j][k] -= A.data[i][k] * m;
                }
                A.data[j][i] = 0.0f;
            }
        }

        // back substitution
        Matrix x = new Matrix(N, 1);
        for (int j = N - 1; j >= 0; j--) {
            double t = 0.0f;
            for (int k = j + 1; k < N; k++)
                t += A.data[j][k] * x.data[k][0];
            x.data[j][0] = (b.data[j][0] - t) / A.data[j][j];
        }
        return x;
   
    }

    // print matrix to standard output
    public void show() {
        for (int i = 0; i < M; i++) {
            for (int j = 0; j < N; j++) 
                print("%9.4f ", data[i][j]);
            println();
        }
    }



    // test client
    /*public static void main(String[] args) {
        double[][] d = { { 1, 2, 3 }, { 4, 5, 6 }, { 9, 1, 3} };
        Matrix D = new Matrix(d);
        D.show();        
        StdOut.println();

        Matrix A = Matrix.random(5, 5);
        A.show(); 
        StdOut.println();

        A.swap(1, 2);
        A.show(); 
        StdOut.println();

        Matrix B = A.transpose();
        B.show(); 
        StdOut.println();

        Matrix C = Matrix.identity(5);
        C.show(); 
        StdOut.println();

        A.plus(B).show();
        StdOut.println();

        B.times(A).show();
        StdOut.println();

        // shouldn't be equal since AB != BA in general    
        StdOut.println(A.times(B).eq(B.times(A)));
        StdOut.println();

        Matrix b = Matrix.random(5, 1);
        b.show();
        StdOut.println();

        Matrix x = A.solve(b);
        x.show();
        StdOut.println();

        A.times(x).show();
        
    }*/
}
/**
 *  Description : This Class defines Quaternion object 
 *
 */
public class Quaternion{
    
  private float w;
  private PVector v;
  
  /**
   *  Description : Constructor which Quaternion object
   *
   *  @param  w   : scalar
   *  @param  x   : vector component 
   *  @param  y   : vector component 
   *  @param  z   : vector component
   */
  public Quaternion(float w, float x, float y, float z) {
    this.w = w;
    this.v.x = x;
    this.v.y = y;
    this.v.z = z;
  }
  
  /**
   *  Description : Get the conjugate Quaternion
   *
   *  @return     : conjugate quaternion (quaternion data type)
   */
  public Quaternion getConjugate(){
    return new Quaternion(this.w, -this.v.x, -this.v.y, -this.v.z);  
  }
  
  /**
   *  Description :  Add the current quaternion to a second one
   *  
   *  @param      :  operand is a quaternion
   *  @return     :  result of addition (quaternion data type)
   */
  public Quaternion plus(Quaternion b) {
    return new Quaternion(this.w+b.w, this.v.x+b.v.x, this.v.y+b.v.y, this.v.z+b.v.z);
  }
  
  /**
   *  Description :  Multiply the current quaternion to a second one
   *
   *  @param      :  operand is a quaternion
   *  @return     :  result of addition (quaternion data type)
   */
  public Quaternion times(Quaternion b) {
    float y0 = this.w*b.w - this.v.x*b.v.x - this.v.y*b.v.y - this.v.z*b.v.z;
    float y1 = this.w*b.v.x + this.v.x*b.w + this.v.y*b.v.z - this.v.z*b.v.y;
    float y2 = this.w*b.v.y - this.v.x*b.v.z + this.v.y*b.w + this.v.y*b.v.x;
    float y3 = this.w*b.v.z + this.v.x*b.v.y - this.v.y*b.v.x + this.v.y*b.w;
    return new Quaternion(y0, y1, y2, y3);
  }
  
  /**
   *  Description :  Get the norm of the current Quaternion
   *
   *  @return     :  norm (float data type)
   */ 
  public float getNorm(){
    return sqrt(this.w*this.w+this.v.x*this.v.x+this.v.y*this.v.y+this.v.z*this.v.z);
  }
  
  
  /**
   *  Description : Multiply the current quaternion to a second one
   *
   *  @return     :  result of addition
   */
  public Quaternion getInverse() {
    float square = this.getNorm() * this.getNorm() ;
    return new Quaternion(this.w/square, -this.v.x/square, -this.v.y/square, -this.v.z/square);
  }
    
}
//Rotation Matrices
float[][] rotationMatrix = new float[3][3];
float[][] alphaMatrix = new float[3][3];
float[][] betaMatrix = new float[3][3];
float[][] gammaMatrix = new float[3][3];


 /**
  *    Description : Rotational Matrix 
  *
  *    @param      : none
  *    @return     : none
  */
  public void initRotMatrix(PVector rotation){
    
      /*alphaMatrix[0][0] = cos(gyro.z);
      alphaMatrix[0][1] = -sin(gyro.z);
      alphaMatrix[0][2] = 0;
      alphaMatrix[1][0] = sin(gyro.z);
      alphaMatrix[1][1] = cos(gyro.z);
      alphaMatrix[1][2] = 0;
      alphaMatrix[2][0] = 0;
      alphaMatrix[2][1] = 0;
      alphaMatrix[2][2] = 1;
      
      betaMatrix[0][0] = cos(gyro.y);
      betaMatrix[0][1] = 0;
      betaMatrix[0][2] = sin(gyro.y);
      betaMatrix[1][0] = 0;
      betaMatrix[1][1] = 1;
      betaMatrix[1][2] = 0;
      betaMatrix[2][0] = -sin(gyro.y);
      betaMatrix[2][1] = 0;
      betaMatrix[2][2] = cos(gyro.y);
      
      gammaMatrix[0][0] = 1;
      gammaMatrix[0][1] = 0;
      gammaMatrix[0][2] = 0;
      gammaMatrix[1][0] = 0;
      gammaMatrix[1][1] = cos(gyro.x);
      gammaMatrix[1][2] = -sin(gyro.x);
      gammaMatrix[2][0] = 0;
      gammaMatrix[2][1] = sin(gyro.x);
      gammaMatrix[2][0] = cos(gyro.x);*/
      
      float cx = cos(rotation.x);
      float cy = cos(rotation.y);
      float cz = cos(rotation.z);
      float sx = sin(rotation.x);
      float sy = sin(rotation.y);
      float sz = sin(rotation.z);   
      
      rotationMatrix[0][0] = cz*cy;
      rotationMatrix[1][0] = sz*cy ;
      rotationMatrix[2][0] = -sy;
      rotationMatrix[0][1] = cz*sy*sx - sz*cx;
      rotationMatrix[1][1] = sz*sy*sx + cz*cx;
      rotationMatrix[2][1] = cy*sx;
      rotationMatrix[0][2] = cz*sy*cx + sz*sx;
      rotationMatrix[1][2] = sz*sy*cx - cz*sx;
      rotationMatrix[2][2] = cy*cx;
  }


 /**
  *    Description : Rotational Matrix 
  *
  *    @param      : none
  *    @return     : none
  */
  public PVector PVectorRotation(PVector original, float rotation[][]) {
    
    PVector rotated = new PVector(0,0,0);
  
    rotated.x += original.x*rotation[0][0] + original.y*rotation[0][1] + original.z*rotation[0][2];
    rotated.y += original.x*rotation[1][0] + original.y*rotation[1][1] + original.z*rotation[1][2];
    rotated.z += original.x*rotation[2][0] + original.y*rotation[2][1] + original.z*rotation[2][2];
  
    return rotated;
  }
// Create object from Serial class
Serial myPort;
Boolean deviceConnected = false;
/**
 *  Description : Serial Initialization
 *
 *  @param      : none
 */
public void serialInit(){
  if(Serial.list().length >= 1) {
    myPort = new Serial(this, Serial.list()[0], 9600);
    myPort.bufferUntil('\r');
    deviceConnected = true;
  }
  else {
    deviceConnected = false;
    println("PORT NOT FOUND !!!" + "\n" + "Connect Your Device");
  }
}

/**
 *  Description   : Serial event
 *
 *  @param myPort : Serial Port to use
 *  @return       : none
 */
public void serialEvent(Serial myPort) {
  
  String inString = myPort.readString();
  println("----- Serial Entry : -------" + inString);  // Display received string in console
  String[] decoupe = inString.split("/");             //D\u00e9coupage de la string suivant le caract\u00e8re "/"
  
  if(decoupe.length == 5) { // To discard the first string received that is likely truncated
    //R\u00e9cup\u00e8re magnetometer string
    if(match(inString,"m") != null)
      cube.magnetoEvent(Float.parseFloat(decoupe[1].trim()), Float.parseFloat(decoupe[2].trim()), Float.parseFloat(decoupe[3].trim()));
    
    //R\u00e9cup\u00e8re accelerometer string
    else if(match(inString,"a") != null)
      cube.acceleroEvent(Float.parseFloat(decoupe[1].trim()), Float.parseFloat(decoupe[2].trim()), Float.parseFloat(decoupe[3].trim()));
    
    //R\u00e9cup\u00e8re gyrometer string
    else if(match(inString,"g") != null)
      cube.gyroEvent(Float.parseFloat(decoupe[1].trim()), Float.parseFloat(decoupe[2].trim()), Float.parseFloat(decoupe[3].trim()));
  }

}
/**
 *  Description : This Class defines Spatial Sensor object 
 *
 */
public abstract class SpatialSensor {
  
  protected PVector received;
  protected PVector calibration;
  public PVector data;
  
  protected int sampleSize;
  protected ArrayList<PVector> sample;
  public PVector smoothed;
  
  protected double lastReadTime; // in seconds
  protected float readTimeDelta; // in seconds
  
  //private int discardedPrecision;
  
  /**
   *  Description : Constructor which initializes Spatial Sensor object
   */
  public SpatialSensor() {
    received = new PVector(0, 0, 0);
    calibration = new PVector(0, 0, 0);
    data = new PVector(0, 0, 0);
    
    sampleSize = 50;
    sample = new ArrayList(sampleSize);
    smoothed = new PVector(0, 0, 0);
    
    lastReadTime = 0;
    readTimeDelta = 0;
  }
  
  /**
   *  Description : Update Time
   */
  public void updateReadTime() {
    if(lastReadTime == 0) // For the first reading
      lastReadTime = (double)(System.currentTimeMillis()) / 1000.0f;
      
    else {
      readTimeDelta = (float)((double)(System.currentTimeMillis()) / 1000.0f - lastReadTime);
      lastReadTime += readTimeDelta;
    }
    
  }
  
  
  /**
   *  Description : Read
   */
  public void read(float x, float y, float z) {
    received.set(x, y, z);
    update();
  }
  
  /**
   *  Description : Update Data
   */  
  public void updateData() {
    data = PVector.sub(received, calibration);
  }
  
  
  
  /**
   *  Description : Smooth data
   *
   *  @param newReading     : New reading to add to the sample list used to smooth the data
   */  
  public void updateSmoothed(PVector newReading) {
    PVector sum = new PVector(0, 0, 0);
    
    sample.add(newReading);
    
    while(sample.size() > sampleSize)
      sample.remove(0);
    
    for(int i=0; i<sample.size(); i++)
      sum.add(sample.get(i));
    
    smoothed = sum.div(sample.size());
  }
  
  
  /**
   *  Description : Update
   */
  public void update() {
    updateData();
    updateSmoothed(data);
  }
  
  
  public abstract void calibrate();
  
  
}
  public void settings() {  size(1500, 900, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Orientation_Sensors_Reading" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
