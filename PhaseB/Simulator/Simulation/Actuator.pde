

public abstract class Actuator {
  
  public Actuator(){}
  
  private float noiseAmplitude;
  
  public abstract void updateActuator(Cube cube);
  
}