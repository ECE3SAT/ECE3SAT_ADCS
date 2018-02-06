/**
 *    Description :  This Class defines a Cube object
 */
public class Cube {
  
  public int size;
  
  public PVector attitude;      // in radians
  public PVector speedAng;      // Angular speed in rad.s-1
  public Quaternion attitudeQ;
  public Quaternion speedAngQ;
  
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
    attitudeQ = new Quaternion(1, 0, 0, 0);
    speedAngQ = new Quaternion(1, 0, 0, 0);
    
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
    speedAng.z = (sin(attitude.x)/cos(attitude.y))*q + (cos(attitude.x)/cos(attitude.y))*r; // will cause problems when attitude.y is close to PI/2 or -PI/2 due to the cos(attitude.y) being a denominator
    
    Quaternion gyroQ = new Quaternion(0, p, q, r);
    speedAngQ = attitudeQ.times(gyroQ).times(0.5);
  }
  
  
  /**
   *    Description : Calculate anglePosition from speedAngle                    
   *                  anglePosition = integral[ speedAngle ] between T1 and T2 
   */
  public void updateAttitude() {
    updateAngularSpeed();
    
    // Euler angles rotation
    attitude.x += speedAng.x*gyro.readTimeDelta;
    attitude.y += speedAng.y*gyro.readTimeDelta;
    attitude.z += speedAng.z*gyro.readTimeDelta;
    
    // Quaternion rotation
    attitudeQ = attitudeQ.plus(speedAngQ.times(gyro.readTimeDelta));
    attitudeQ.normalize();
    
    // Attitude angles range : ]-PI;PI]
    while(attitude.x <= -PI) attitude.x += TWO_PI;
    while(attitude.x > PI) attitude.x -= TWO_PI;
    while(attitude.y <= -PI) attitude.y += TWO_PI;
    while(attitude.y > PI) attitude.y -= TWO_PI;
    while(attitude.z <= -PI) attitude.z += TWO_PI;
    while(attitude.z > PI) attitude.z -= TWO_PI;
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
    // Cube's vertices stored in quaternions prior to rotation
    Quaternion v1 = new Quaternion(0,  1,  1,  1);
    Quaternion v2 = new Quaternion(0,  1, -1,  1);
    Quaternion v3 = new Quaternion(0, -1, -1,  1);
    Quaternion v4 = new Quaternion(0, -1,  1,  1);
    Quaternion v5 = new Quaternion(0,  1,  1, -1);
    Quaternion v6 = new Quaternion(0,  1, -1, -1);
    Quaternion v7 = new Quaternion(0, -1, -1, -1);
    Quaternion v8 = new Quaternion(0, -1,  1, -1);
    
    // Cube's orientation applied to vertices
    v1 = attitudeQ.times(v1).times(attitudeQ.conjugated());
    v2 = attitudeQ.times(v2).times(attitudeQ.conjugated());
    v3 = attitudeQ.times(v3).times(attitudeQ.conjugated());
    v4 = attitudeQ.times(v4).times(attitudeQ.conjugated());
    v5 = attitudeQ.times(v5).times(attitudeQ.conjugated());
    v6 = attitudeQ.times(v6).times(attitudeQ.conjugated());
    v7 = attitudeQ.times(v7).times(attitudeQ.conjugated());
    v8 = attitudeQ.times(v8).times(attitudeQ.conjugated());
    
    beginShape(QUADS);
    fill(0, 1, 1);      //-Z cyan
    vertex(v4.x, v4.y, v4.z);  vertex(v1.x, v1.y, v1.z);  vertex(v2.x, v2.y, v2.z);  vertex(v3.x, v3.y, v3.z);
    fill(1, 1, 1);      //+X blanc
    vertex(v1.x, v1.y, v1.z);  vertex(v5.x, v5.y, v5.z);  vertex(v6.x, v6.y, v6.z);  vertex(v2.x, v2.y, v2.z);
    fill(1, 1, 0);      //+Z jaune
    vertex(v5.x, v5.y, v5.z);  vertex(v8.x, v8.y, v8.z);  vertex(v7.x, v7.y, v7.z);  vertex(v6.x, v6.y, v6.z);
    fill(0, 1, 0);      //-X vert
    vertex(v8.x, v8.y, v8.z);  vertex(v4.x, v4.y, v4.z);  vertex(v3.x, v3.y, v3.z);  vertex(v7.x, v7.y, v7.z);
    fill(0, 0, 1);      //+Y bleu
    vertex(v8.x, v8.y, v8.z);  vertex(v5.x, v5.y, v5.z);  vertex(v1.x, v1.y, v1.z);  vertex(v4.x, v4.y, v4.z);
    fill(1, 0, 0);      //-Y rouge
    vertex(v7.x, v7.y, v7.z);  vertex(v6.x, v6.y, v6.z);  vertex(v2.x, v2.y, v2.z);  vertex(v3.x, v3.y, v3.z);
    endShape();
    
    /*beginShape(QUADS);
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
    endShape();*/
    
  }
  
  /**
   *    Description : Displays the cube
   */
  public void draw() {
    pushMatrix();
    pushStyle();
    
    translate(position.x+positionInit.x, position.y+positionInit.y, position.z+positionInit.z);
    
    //rotateZ(attitude.z);    THE CUBE IS ROTATED WITH QUATERNIONS IN shape()
    //rotateY(attitude.y);
    //rotateX(attitude.x);
    
    scale(size);
    stroke(255);
    strokeWeight(0.02);
    colorMode(RGB, 1);
    
    shape();
    
    line(-attitudeQ.x/sin(acos(attitudeQ.w))/2*5, -attitudeQ.y/sin(acos(attitudeQ.w))/2*5, -attitudeQ.z/sin(acos(attitudeQ.w))/2*5, attitudeQ.x/sin(acos(attitudeQ.w))/2*5, attitudeQ.y/sin(acos(attitudeQ.w))/2*5, attitudeQ.z/sin(acos(attitudeQ.w))/2*5);
  
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