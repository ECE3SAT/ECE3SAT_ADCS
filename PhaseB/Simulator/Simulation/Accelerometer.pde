

public class Accelerometer extends Sensor {
  
  private PVector totalAcceleration;
  private PVector tangAcceleration;
  private PVector radialAcceleration;
  
  private final PVector distanceToCenter = new PVector(10,10,10); // in mm
  
  public Accelerometer() {
    super();
  }
  
  
  @Override
  public void updateSensor(Cube cube)
  {
    PVector angAccX = cube.magnetorquerX.getAngularAcceleration();
    float angularSpeedX = cube.magnetorquerX.getAngularSpeed();
    
    PVector angAccY = cube.magnetorquerY.getAngularAcceleration();
    float angularSpeedY = cube.magnetorquerY.getAngularSpeed();
    
    PVector angAccZ = cube.magnetorquerZ.getAngularAcceleration();
    float angularSpeedZ = cube.magnetorquerZ.getAngularSpeed();
    
    tangAcceleration = getTangAcceleration(angAccX).add(getTangAcceleration(angAccY)).add(getTangAcceleration(angAccZ));
    
    radialAcceleration = getRadialAcceleration(angAccX,angularSpeedX).add(getRadialAcceleration(angAccY,angularSpeedY)).add(getRadialAcceleration(angAccZ,angularSpeedZ));
    
    totalAcceleration = tangAcceleration.add(radialAcceleration);
  }
  
  public PVector getTotalAcceleration()
  {
    return totalAcceleration;
  }
  
  public PVector getRadialAcceleration(PVector angularAcc, float angularSpeed)
  {
    PVector radialAcc = new PVector(-distanceToCenter.x,-distanceToCenter.y,-distanceToCenter.z).mult(angularSpeed*angularSpeed);
    return radialAcc;
  }
  
  public PVector getTangAcceleration(PVector angularAcc)
  {
    PVector tangAcc = angularAcc.cross(distanceToCenter);
    return tangAcc;
  }
  
  @Override
  public void sendDataToSerial(Serial serial)
  {
    serial.write("Accelerometer Acceleration:"+totalAcceleration);
  }
}