

public class Sun {
  
  private float orbitalDuration;
  private PVector illumination; // Vector of light incidence from Sun
  private boolean illuminated; //If sun is visible from cube
  PImage sunTexture; 
  PShape globe;
  private float altitude = 8000000; // Altitude of Sun from Earth (not actual distance)
 
  // Position on screen
  public PVector sunPositionScreen;
  // Position on screen
  public PVector sunPosition;
  //public Quaternion orbiteVector; // Orbite around Earth
  public Quaternion selfRotation; // Rotation around itself
  
  public Sun()
  {
    sunTexture = loadImage( "img/Sun.jpg");
    globe = createShape(SPHERE, 50); 
    noStroke();
    globe.setTexture(sunTexture);
    
    
    //orbitalDuration = 5542; // One orbit is equal to 5542s at 400km from earth sea level
    orbitalDuration = 5542;
    
    sunPositionScreen = new PVector(-700, 0, -1000);
    sunPosition = new PVector(-4587100*2, 0, -6553000*2);
    illumination = new PVector(0,0,0);
  }
  
  public void rotate()
  {
    rotatePos(sunPositionScreen,orbitalDuration);
    rotatePos(sunPosition, 60 * 60 * 24);
  }
  
  private void rotatePos(PVector p_vector, float orbit)
  {
    float newPosx, newPosz,angle=timeCoefficient*2*PI/orbit/framePerSecond;
    newPosx = p_vector.x*cos(angle) - p_vector.z*sin(angle);
    newPosz = p_vector.x*sin(angle) + p_vector.z*cos(angle);
    p_vector.x = newPosx;
    p_vector.z = newPosz;
  }
  
  public PVector getIllumination(PVector cubePosition)
  {
    PVector lightRay = new PVector( cubePosition.x - sunPosition.x , cubePosition.y - sunPosition.y , cubePosition.z - sunPosition.z );
    PVector sunToEarthVector = new PVector( 0 - sunPosition.x , 0 - sunPosition.y , 0 - sunPosition.z );
    float raySide = lightRay.mag();
    float earthSide = sunToEarthVector.mag();
    float cubeSide = cubePosition.mag();
    
    float illumAngle = acos((cubeSide*cubeSide+raySide*raySide-earthSide*earthSide)/(2*raySide*cubeSide));
    
    if( degrees(illumAngle) > 110) // If Sun is behind Earth
    {
      return null;
    }
    else
    {
      return lightRay;
    }
    
  }
  
  public void draw()
  {
    translate(sun.sunPositionScreen.x, sun.sunPositionScreen.y, sun.sunPositionScreen.z);
    translate(width/2, height/2, 0);
    shape(globe);
    translate(-width/2, -height/2, 0);
    translate(-sun.sunPositionScreen.x, -sun.sunPositionScreen.y, -sun.sunPositionScreen.z);
  }
  
}