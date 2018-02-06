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