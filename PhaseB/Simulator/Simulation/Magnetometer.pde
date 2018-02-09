

public class Magnetometer extends Sensor {
  
  private float timerRequest = 0;
  private PVector magneticVector; // { Declination , Inclination, Intensity Total}
  private float horIntensity;
  private PVector magneticVectorXYZ; // { X , Y, Z }
  public PVector originVector;
  
  public Magnetometer() {
    super();
    magneticVector = new PVector();
    magneticVectorXYZ = new PVector();
    originVector = new PVector();
  }
  
  public PVector getMagnVector()
  {
    return new PVector(magneticVectorXYZ.x,magneticVectorXYZ.y,magneticVectorXYZ.z);
  }
  
  @Override
  public void updateSensor(Cube cube)
  {
    //requestLatLong(cube);
    basicLatLong(cube);
    //magneticVectorXYZ = cube.axeRotation.getConjugate().rotateVector(magneticVectorXYZ).normalize();
  }
  
  // Convert geographic coordinates into approximated vector
  private void basicLatLong(Cube cube)
  {
    PVector temp = earth.getGeoCoordinates(cube.cubePosition);
    float declination = 0;
    float inclination = radians(temp.x);
    
    magneticVectorXYZ.x = - 1 * sin(inclination) / 10;
    magneticVectorXYZ.y = 1 * cos(inclination) / 10;
    magneticVectorXYZ.z = 1 * sin(declination) / 10;
  }
  
  //Retrieve magnetic vector from online web service
  private void requestLatLong(Cube cube)
  {
    if(millis() > timerRequest + 1000)
    {
      PVector temp = earth.getGeoCoordinates(cube.cubePosition);
      GetRequest linhas = new GetRequest("https:" + "//www.ngdc.noaa.gov/geomag-web/calculators/calculateIgrfwmm?lat1="+temp.x+"&lon1="+temp.y+"&elevation="+400+"&model=WMM&startYear=2015&endYear=2019&resultFormat=csv");
      
      linhas.send();
      
      String text = linhas.getContent();
      
      String[] parts = text.split("\n");
      text = parts[24];
      String[] magnComp = text.split(",");
      
      magneticVector.x = Float.parseFloat(magnComp[1]);
      magneticVector.y = Float.parseFloat(magnComp[2]);
      magneticVector.z = Float.parseFloat(magnComp[4]);
      
      horIntensity = Float.parseFloat(magnComp[3]);
      
      magneticVectorXYZ.x = Float.parseFloat(magnComp[5]);
      magneticVectorXYZ.y = Float.parseFloat(magnComp[6]);
      magneticVectorXYZ.z = Float.parseFloat(magnComp[7]);
      
      System.out.println("Reponse Content: \n" + magnComp[1] + " - " + magnComp[2] + " - " + magnComp[4]);
      
      timerRequest = millis();
    }
  }
  
  @Override
  public void sendDataToSerial(Serial serial)
  {
      thread("serialWrite");
  }
  
  public PVector prevValue = new PVector(0,0,0);
}

  // Write magnetic data to serial port
  void serialWrite() {
    PVector baseChangedMagnVector = cube.getAttitudeDifference().getConjugate().rotateVectorUnnormalized(cube.magneto.getMagnVector());
    
    if(enableCom)
    {
      String value1 = str(baseChangedMagnVector.x)+" "+str(baseChangedMagnVector.y)+" "+str(baseChangedMagnVector.z);
      String valueX = str(cube.magnetorquerX.getNormalVector().x)+" "+str(cube.magnetorquerX.getNormalVector().y)+" "+str(cube.magnetorquerX.getNormalVector().z);
      String valueY = str(cube.magnetorquerY.getNormalVector().x)+" "+str(cube.magnetorquerY.getNormalVector().y)+" "+str(cube.magnetorquerY.getNormalVector().z);
      String valueZ = str(cube.magnetorquerZ.getNormalVector().x)+" "+str(cube.magnetorquerZ.getNormalVector().y)+" "+str(cube.magnetorquerZ.getNormalVector().z);
    
      try{
        serialPort.write("<"+"A "+value1+">");
        serialPort.write("<"+"X "+valueX+">");
        serialPort.write("<"+"Y "+valueY+">");
        serialPort.write("<"+"Z "+valueZ+">");
      }
      catch(Exception e){
        cube.magnetorquerX.changeIntensity(-15000);
        cube.magnetorquerY.changeIntensity(-15000);
        cube.magnetorquerZ.changeIntensity(-15000);
      }
    }
    else // Send unusable value to shutdown magnetorquers
    {
      cube.magnetorquerX.changeIntensity(-15000);
      cube.magnetorquerY.changeIntensity(-15000);
      cube.magnetorquerZ.changeIntensity(-15000);
    }
  }