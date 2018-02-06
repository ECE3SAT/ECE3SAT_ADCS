
public class Magnetorquer extends Actuator {
  
  private float currentIntensity;
  private float currentVoltage;
  private float surface = 0.005; // 7cm * 7cm
  private int nbSpire = 200;
  private float intensityMax = 1;
  private float intensityMin = intensityMax / 255;
  public PVector normalVector;
  
  public float miniIntensityPossible = 1.0/50.0; // the minimal intensity our magnetorquers can be alimented with
  
  private PVector angular_acceleration;
  private float angularSpeed = 0;
  
  public Magnetorquer(PVector p_normalVector) {
    super();
    normalVector = p_normalVector;
  }
  
  public PVector getNormalVector()
  {
    return new PVector(normalVector.x,normalVector.y,normalVector.z); 
  }
  
  public float getIntensity()
  {
    return currentIntensity;
  }
  
  public PVector getAngularAcceleration()
  {
    return angular_acceleration;
  }
  
  public float getAngularSpeed()
  {
    return angularSpeed;
  }
  
  @Override
  public void updateActuator(Cube cube)
  {
    // Update magnetorquer's normal vector
    this.normalVector = cube.axeRotation.rotateVector(this.normalVector).normalize();
  }
  
  // Change current intensity, with limited value
  public void changeIntensity(float p_intensity)
  {
    if(p_intensity!=-15000)
    {
      if(abs(p_intensity) != 0){
        currentIntensity = p_intensity * miniIntensityPossible;
          
          
        if(abs(p_intensity)< (intensityMin * miniIntensityPossible))
          currentIntensity = 0;
       println(currentIntensity);
      }
      }// If value is unusable, force the value to 0. This is used because serial data can read/write too fast and transfer 0 because it has nothing left to send, so these value are ignored
    else currentIntensity = 0;
   
    /*
    if(p_intensity!=-15000)
    {
      p_intensity *= -200; // K, gain
      if(abs(p_intensity) != 0)
      {
        currentIntensity = p_intensity;
        
        if(abs(p_intensity)>intensityMax)
          currentIntensity = Math.signum(p_intensity) * intensityMax;
         
        if(abs(p_intensity)<intensityMin)
          currentIntensity = 0;
      }
      if(!enableCom)currentIntensity = 0;
    }// If value is unusable, force the value to 0. This is used because serial data can read/write too fast and transfer 0 because it has nothing left to send, so these value are ignored
    else currentIntensity = 0;*/
  }
  
  public void actualizeForce(PVector p_magnetism)
  {
    // C = N I S (N-> cross product B->);
    // Torque = Inertia Moment * Angular acceleration
    // For a solid cuboid : Ih = (m/12)*(coteW^2 + coteD^2)
    
    // https://www.researchgate.net/publication/263008407_Comparison_of_Control_Laws_for_Magnetic_Detumbling
    
    PVector val = new PVector(normalVector.x,normalVector.y,normalVector.z);
    
    PVector torque = val.mult(currentIntensity).cross(p_magnetism).mult(timeCoefficient / framePerSecond);
    //PVector torque = val.mult(val.mag() * nbSpire * currentIntensity * surface * timeCoefficient / framePerSecond);
    //PVector temp_acceleration = torque.div((cube.mass/12)*(2*pow(cube.edgeSize,2)));
    angular_acceleration = torque;
    println(torque);
    
    angularSpeed += angular_acceleration.dot(normalVector);    // Signed angular speed
  }
  
}