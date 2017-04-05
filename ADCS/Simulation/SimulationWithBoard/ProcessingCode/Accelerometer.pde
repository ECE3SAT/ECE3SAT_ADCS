public class Accelerometer extends SpatialSensor {
  
  public Accelerometer() {
    super();
  }
  
  public void calibrate() {
    calibration = received.copy();
  }
  
}