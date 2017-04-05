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
    
    //  -PI < angle <= +PI 
    while(attitude.x <= -PI) attitude.x += 2*PI;
    while(attitude.x > PI) attitude.x -= 2*PI;
    while(attitude.y <= -PI) attitude.y += 2*PI;
    while(attitude.y > PI) attitude.y -= 2*PI;
    while(attitude.z <= -PI) attitude.z += 2*PI;
    while(attitude.z > PI) attitude.z -= 2*PI;
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
    acceleration = PVector.mult(accelero.data, 0.00981); // Convertion from mg to m.s-2
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
    float p, q, r;
    
    p = magneto.data.x;
    q = magneto.data.y;
    r = magneto.data.z;
    
    magneticField.x = p + sin(attitude.x)*tan(attitude.y)*q + cos(attitude.x)*tan(attitude.y)*r;
    magneticField.y = cos(attitude.x)*q - sin(attitude.x)*r;
    magneticField.z = (sin(attitude.x)/cos(attitude.y))*q + (cos(attitude.x)/cos(attitude.y))*r;
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
    strokeWeight(0.02);
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
    color vectorColor = color(255, 0, 0);
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
      //line(0, 0, 0, drawData.y, -drawData.x, drawData.z);   //on inverse les axes car les mems ne sont pas orienté dans le même sens
      //line(0, 0, 0, drawData.x, drawData.y, drawData.z);
      line(0, 0, 0, magneticField.x, magneticField.y, magneticField.z);
      //rotate(atan2(drawData.y-position.y,drawData.x-position.x));
      //triangle(-mag/5, -mag/10, 0, 0, -mag/5, mag/10);
    }
    
    popMatrix();
    popStyle();                      
  }
  
}
