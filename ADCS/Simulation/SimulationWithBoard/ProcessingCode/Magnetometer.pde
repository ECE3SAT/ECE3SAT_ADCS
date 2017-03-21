public class Magnetometer extends SpatialSensor {
  
  public Magnetometer() {
    super();
  }
  
  public void calibrate() {
    calibration = received.copy();
  }
  
}


  /*////Recadre les valeurs dans la fenetre d'affichage
  magnetoSmoothed.x = map(magneto.x, -1000, +1000, -200, +200);   //map(value, start1, stop1, start2, stop2)    value : incoming value | start1, stop1 : range 2 | start2,stop2 : range 2
  magnetoSmoothed.y = map(magneto.y, -1000, +1000, -200, +200);
  magnetoSmoothed.z = map(magneto.z, -1000, +1000, -50, +50);*/