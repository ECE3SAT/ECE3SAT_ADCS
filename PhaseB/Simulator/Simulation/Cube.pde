/**
 *    Description :  This Class defines a Cube object
 */
public class Cube {
  
  /**        USED FOR SIMULATION        **/
  
  public int size;
  public int mass = 1330; //in g
  public int edgeSize = 100; //in mm
  
  // Quaternion representing the angular velocity
  public Quaternion axeRotation;
  // Quaternion representing the cube attitude
  public Quaternion cubeAttitude;
  
  private PVector originVector;
  
  // Vertex used for cube drawing
  private PVector APoint; // Point -1 / -1 / -1
  private PVector BPoint; // Point 1 / -1 / -1
  private PVector CPoint; // Point 1 / -1 / 1
  private PVector DPoint; // Point -1 / -1 / 1
  private PVector EPoint; // Point -1 / 1 / -1
  private PVector FPoint; // Point 1 / 1 / -1
  private PVector GPoint; // Point 1 / 1 / 1
  private PVector HPoint; // Point -1 / 1 / 1
  
  // Earth relative position
  private PVector cubePosition; 
  // Altitude of cube from Earth center
  private float altitude = 6771000; 
  
  // Sensors and Atuators
  public Gyroscope gyro;
  public Accelerometer accelero;
  public Magnetometer magneto;
  public SunSensor sunSensor;
  
  public Magnetorquer magnetorquerX;
  public Magnetorquer magnetorquerY;
  public Magnetorquer magnetorquerZ;
  
  // Default cube constructor
  public Cube(float angularVelocity, float xAxis, float yAxis, float zAxis) {
    size = 50;
    
    angularVelocity = 2 * PI * angularVelocity / 360;
    
    // Define Quaternion
    axeRotation = new Quaternion(timeCoefficient * angularVelocity / framePerSecond , xAxis, yAxis, zAxis).fromAxis();
    cubeAttitude = new Quaternion(axeRotation);
    
    originVector = new PVector(xAxis,yAxis,zAxis);
    
    //Init vertex value
    APoint = new PVector(-1,-1,-1);
    BPoint = new PVector(1,-1,-1);
    CPoint = new PVector(1,-1,1);
    DPoint = new PVector(-1,-1,1);
    
    EPoint = new PVector(-1,1,-1);
    FPoint = new PVector(1,1,-1);
    GPoint = new PVector(1,1,1);
    HPoint = new PVector(-1,1,1);
    
    // Create Sensors and Actuators obj
    gyro = new Gyroscope(cubeAttitude);
    accelero = new Accelerometer();
    magneto = new Magnetometer();
    sunSensor = new SunSensor();
    
    magnetorquerX = new Magnetorquer(new PVector(1,0,0));
    magnetorquerY = new Magnetorquer(new PVector(0,1,0));
    magnetorquerZ = new Magnetorquer(new PVector(0,0,1));
    
  }
  
  // Reset the time change in rotation (needed to remove actual time acceleration and change into a new one)
  public void resetSpeed()
  {
    PVector temp_vector = axeRotation.getEulerAxe();
    axeRotation.setVector(new PVector(temp_vector.x / timeCoefficient,temp_vector.y / timeCoefficient,temp_vector.z / timeCoefficient));
  }
  
  // Apply change on rotation
  public void changeTime()
  {
    PVector temp_vector = axeRotation.getEulerAxe();
    axeRotation = new Quaternion(axeRotation.getAngle() , temp_vector.x * timeCoefficient, temp_vector.y * timeCoefficient, temp_vector.z * timeCoefficient);
  }
  
  // Set the cube initial position so it match it's orbit around earth
  public void initializePosition()
  {
    cubePosition = new PVector(altitude, 0 , 0);
    cubePosition = new Quaternion(radians(90-earth.getAngleOrbit()),0,0,1).fromAxis().rotateVectorUnnormalized(cubePosition);
  }
  
  // Creates the cube's colored shape  
  private void shape(){
    beginShape(QUADS);
    noStroke();
    fill(0, 1, 1);      //cyan FACE Z + 1
    vertex(HPoint.x, -HPoint.y, HPoint.z);  vertex(GPoint.x, -GPoint.y, GPoint.z);  vertex(CPoint.x, -CPoint.y, CPoint.z);  vertex(DPoint.x, -DPoint.y, DPoint.z);
    fill(1, 1, 1);      //blanc FACE X + 1
    vertex(GPoint.x, -GPoint.y, GPoint.z);  vertex(FPoint.x, -FPoint.y, FPoint.z);  vertex(BPoint.x, -BPoint.y, BPoint.z);  vertex(CPoint.x, -CPoint.y, CPoint.z);
    fill(1, 1, 0);      //jaune FACE Z - 1
    vertex(FPoint.x, -FPoint.y, FPoint.z);  vertex(EPoint.x, -EPoint.y, EPoint.z);  vertex(APoint.x, -APoint.y, APoint.z);  vertex(BPoint.x, -BPoint.y, BPoint.z);
    fill(0, 1, 0);      //bleu FACE X - 1
    vertex(EPoint.x, -EPoint.y, EPoint.z);  vertex(HPoint.x, -HPoint.y, HPoint.z);  vertex(DPoint.x, -DPoint.y, DPoint.z);  vertex(APoint.x, -APoint.y, APoint.z);
    fill(0, 0, 1);      //vert FACE Y + 1
    vertex(EPoint.x, -EPoint.y, EPoint.z);  vertex(FPoint.x, -FPoint.y, FPoint.z);  vertex(GPoint.x, -GPoint.y, GPoint.z);  vertex(HPoint.x, -HPoint.y, HPoint.z);
    fill(1, 0, 0);      //rouge FACE Y - 1
    vertex(APoint.x, -APoint.y, APoint.z);  vertex(BPoint.x, -BPoint.y, BPoint.z);  vertex(CPoint.x, -CPoint.y, CPoint.z);  vertex(DPoint.x, -DPoint.y, DPoint.z);
    endShape();
  }
  
  // Rotate all vertex around rotation axis, and store attitude change
  public void rotateCube(Quaternion p_quaternion) {
    
    this.APoint = p_quaternion.rotateVector(this.APoint);
    this.BPoint = p_quaternion.rotateVector(this.BPoint);
    this.CPoint = p_quaternion.rotateVector(this.CPoint);
    this.DPoint = p_quaternion.rotateVector(this.DPoint);
    
    this.EPoint = p_quaternion.rotateVector(this.EPoint);
    this.FPoint = p_quaternion.rotateVector(this.FPoint);
    this.GPoint = p_quaternion.rotateVector(this.GPoint);
    this.HPoint = p_quaternion.rotateVector(this.HPoint);
    
    cubeAttitude = cubeAttitude.times(p_quaternion);
    
  }
  
  // Apply a new rotation to the current one
  public void changeRotation(Quaternion p_rotation)
  {
    axeRotation = axeRotation.plusComponent(p_rotation);
  }
  
  // Displays the cube
  public void draw() {
    pushMatrix();
    pushStyle();
    
    translate(width/2, height/2, 500);
    scale(size/2);
    stroke(255);
    strokeWeight(0.02);
    colorMode(RGB, 1);
    
    shape(); 
  
  
    translate(-width/2, -height/2, -500);
    popMatrix();
    popStyle();
  }
  
  // Get the current attitude
  public Quaternion getAttitudeDifference()
  {
    Quaternion attitudeRotation = new Quaternion(cubeAttitude);
    return attitudeRotation;
  }
  
  // Update all magnetorquer change
  public void actuatorHandler()
  {
    
    cube.magnetorquerX.actualizeForce(cube.magneto.getMagnVector());
    cube.magnetorquerY.actualizeForce(cube.magneto.getMagnVector());
    cube.magnetorquerZ.actualizeForce(cube.magneto.getMagnVector());
    
    Quaternion rotationMagnX = new Quaternion(1,cube.magnetorquerX.getAngularAcceleration());
    Quaternion rotationMagnY = new Quaternion(1,cube.magnetorquerY.getAngularAcceleration());
    Quaternion rotationMagnZ = new Quaternion(1,cube.magnetorquerZ.getAngularAcceleration());
    
    //Quaternion rotationMagnZ = new Quaternion(cube.magnetorquerZ.getAngularSpeed(),cube.magnetorquerZ.getAngularAcceleration());
    
    Quaternion totalRotation = rotationMagnX.plusComponent(rotationMagnY).plusComponent(rotationMagnZ);
    
    totalRotation.printValue("Rotation 2");
    
    cube.changeRotation(totalRotation);
    
    cube.magnetorquerX.updateActuator(cube);
    cube.magnetorquerY.updateActuator(cube);
    cube.magnetorquerZ.updateActuator(cube);
  }
}