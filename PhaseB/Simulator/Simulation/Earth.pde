

public class Earth {
  
  private float timeRotation;
  private PVector earthPosition;
  private PVector earthAttitude;
  private final float dayDuration = 60 * 60 * 24; //=86400
  private final float selfRotationSpeed = 2 * PI / dayDuration; // in rad/s
  private final float orbitalDuration = 5542; // One orbit is equal to 5542s at 400km from earth sea level
  private final float orbitalSpeed = 2 * PI / orbitalDuration; // in rad/s
  private final float angleOrbit = 90 - 51.6;
  PImage earthTexture; 
  PShape globe;
 
  public Quaternion orbiteVector; // Cube orbite around Earth
  public Quaternion selfRotation; // Rotation around itself
  public Quaternion orbitCube; // Rotation around itself
  public float radius = 6371000;
  
  public static final int NORTH = 1;
  public static final int SOUTH = 2;
  public static final int EAST = 5;
  public static final int WEST = 7;
  
  public Earth()
  {
    
    earthTexture = loadImage( "img/Earth.JPG5a55ca7f-1d7c-41d7-b161-80501e00d095Larger.jpg");
    globe = createShape(SPHERE, 500); 
    noStroke();
    globe.setTexture(earthTexture);
    
    // Define Quaternion for cube rotation and self rotation
    orbiteVector = new Quaternion(timeCoefficient * orbitalSpeed / framePerSecond, 0, -1, 0).fromAxis();
    selfRotation = new Quaternion(timeCoefficient * selfRotationSpeed / framePerSecond, -1, 1.2616, 0).fromAxis();
    orbiteVector.normalize();
    selfRotation.normalize();
    
    earthAttitude =  new PVector(1,0,0);
    
    Quaternion temp_quater = new Quaternion(radians(angleOrbit),0,0,1).fromAxis();
    PVector temp_vector = new PVector();
    temp_vector.x = orbiteVector.getEulerAxe().x;
    temp_vector.y = orbiteVector.getEulerAxe().y;
    temp_vector.z = orbiteVector.getEulerAxe().z;
    temp_vector = temp_quater.rotateVectorUnnormalized(temp_vector);
    orbitCube = new Quaternion(timeCoefficient * orbitalSpeed / framePerSecond, temp_vector.normalize()).fromAxis();
    
    globe.rotateZ(radians(angleOrbit));
    
  }
  
  public void changeTime()
  {
    orbiteVector = new Quaternion(timeCoefficient * orbitalSpeed / framePerSecond, 0, -1, 0).fromAxis();
    selfRotation = new Quaternion(timeCoefficient * selfRotationSpeed / framePerSecond, -1, 1.2616, 0).fromAxis();
    
    Quaternion temp_quater = new Quaternion(radians(angleOrbit),0,0,1).fromAxis();
    PVector temp_vector = orbiteVector.getEulerAxe();
    temp_vector = temp_quater.rotateVectorUnnormalized(temp_vector);
    orbitCube = new Quaternion(timeCoefficient * orbitalSpeed / framePerSecond, temp_vector.normalize()).fromAxis();
  }
  
  public PVector rotateAround(PVector p_objectPos)
  {
    return orbitCube.rotateVectorUnnormalized(p_objectPos);
  }
  
  // Rotate earth relative to orbit
  public void rotateOrbital()
  {
    globe.rotateX(orbiteVector.getEulerAngle().x);
    globe.rotateY(orbiteVector.getEulerAngle().y);
    globe.rotateZ(orbiteVector.getEulerAngle().z);
  }
  
  // Rotate earth around itself
  public void selfRotate()
  {
    selfRotation.v = orbiteVector.getConjugate().rotateVectorUnnormalized(selfRotation.v);
    globe.rotateX(selfRotation.getEulerAngle().x);
    globe.rotateY(selfRotation.getEulerAngle().y);
    globe.rotateZ(selfRotation.getEulerAngle().z);
  }
  
  // Return Geographic Coordinates
  public PVector getGeoCoordinates(PVector cubeAttitude)
  {
    PVector normal = orbitCube.getEulerAxe();
    normal.normalize();
    PVector cubeAttitudeCopy = new PVector(cubeAttitude.x,cubeAttitude.y,cubeAttitude.z);
    PVector projection = normal.mult( cubeAttitudeCopy.dot(normal) / normal.dot(normal));
    PVector orthoVector = new PVector (0,0,0);
    
    orthoVector.x = cubeAttitudeCopy.x - projection.x;
    orthoVector.y = cubeAttitudeCopy.y - projection.y;
    orthoVector.z = cubeAttitudeCopy.z - projection.z;
    
    float latitude = 90 - degrees( acos( orthoVector.x / (sqrt(pow(orthoVector.y,2)+pow(orthoVector.z,2)+pow(orthoVector.x,2)))) );
    float longitude =  - degrees(atan2 (orthoVector.z , orthoVector.y ));
    
    float north = orthoVector.dot(cubeAttitudeCopy);
    float east = orthoVector.dot(earthAttitude);
    
    println("Latitude:"+latitude+" Longitude:"+longitude);
    
    int hemisphere;
    
    if(north>0)hemisphere = NORTH;
    else hemisphere = SOUTH;
    
    if(east>0)hemisphere += EAST;
    else hemisphere += WEST;
    
    PVector geoCoord = new PVector (latitude,longitude,hemisphere);
    return geoCoord; 
  }
  
  public float getAngleOrbit()
  {
    return angleOrbit;
  }
  
  public void draw()
  {
    translate(0, height/2, 0);
    shape(globe);
    translate(0, -height/2, 0);
  }
}