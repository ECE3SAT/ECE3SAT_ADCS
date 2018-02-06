
public class SunSensor extends Sensor {
  
  private PVector sunVector;
  
  public SunSensor() {
    super();
  }
  
  @Override
  public void updateSensor(Cube cube)
  {
    sunVector = sun.getIllumination(cube.cubePosition);
  }
  
  public void calibrate() {
    calibration = received.copy();
  }


  @Override
  public void sendDataToSerial(Serial serial)
  {
    serial.write("SunSensor Direction:"+sunVector);
  }
}