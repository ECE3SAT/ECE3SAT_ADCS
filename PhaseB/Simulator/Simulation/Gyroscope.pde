

public class Gyroscope extends Sensor {
  
  private Quaternion initAttitude;
  private Quaternion currentAttitude;
  
  public Gyroscope(Quaternion p_initAttitude) {
    super();
    initAttitude = p_initAttitude;
  }
  
  public Quaternion getCurrentAttitude()
  {
    return currentAttitude;
  }
  
  @Override
  public void updateSensor(Cube cube)
  {
    currentAttitude = initAttitude.substract(cube.cubeAttitude);
  }
  
  @Override
  public void sendDataToSerial(Serial serial)
  {
    //serial.write("Gyroscope "+currentAttitude.convertToString());
  }

}