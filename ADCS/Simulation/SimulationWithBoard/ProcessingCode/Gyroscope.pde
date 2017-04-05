public class Gyroscope extends SpatialSensor {
    
  public Gyroscope() {
    super();
  }
  
  public void calibrate() {
    calibration = received.copy();
  }

}