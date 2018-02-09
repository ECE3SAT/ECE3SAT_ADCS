import http.requests.*;
  
void draw() {
  
  //  Initialize screen
  background(0);
  
  println("Framerate:"+frameRate);
  
  //Read from Serial
  
  if(enableCom)
  {
    try{
      SerialReceive();
    }
    catch(Exception e){}
  }
  
  //Update sensors
  cube.magneto.updateSensor(cube);
  cube.gyro.updateSensor(cube);
  
  //Update earth position and rotation
  earth.rotateOrbital();
  earth.selfRotate();
  
  //Write in Serial
  if(enableCom){
    writeDataInSerial(serialPort);
  }
  
  cube.actuatorHandler();
  
  // Rotate cube on screen
  //cube.rotateCube(earth.orbiteVector.getConjugate());
  cube.rotateCube(cube.axeRotation);
  
  //Draw earth
  earth.draw();
  
  //Update cube position around earth
  cube.cubePosition = earth.rotateAround(cube.cubePosition);
  
  //Get illumination vector from the sun
  PVector illumVector = new PVector(sun.sunPositionScreen.x,sun.sunPositionScreen.y,sun.sunPositionScreen.z);
  illumVector = sun.getIllumination(cube.cubePosition);
 
  // Draw cube and sun
  
  cube.draw();
  
  sun.rotate();
  sun.draw();
  
  // Draw UI
  
  if(displayUI)
  {
    
    addPlotGraph1(cube.magneto.getMagnVector().x,cube.magneto.getMagnVector().y,cube.magneto.getMagnVector().z,"Magnetic Vector");
    addPlotGraph2(cube.magnetorquerX.getIntensity(),cube.magnetorquerY.getIntensity(),cube.magnetorquerZ.getIntensity(),"Magnetorquer");
    addPlotGraph3(cube.axeRotation.getEulerAxe().x,cube.axeRotation.getEulerAxe().y,cube.axeRotation.getEulerAxe().z,"Cube Rotation");
    
    float angle = cube.axeRotation.getVectorNorm() * cube.axeRotation.getAngle();
    angle = angle * framePerSecond / timeCoefficient;
    angle = 360 * angle / (2*PI);
    //angle = 2 * acos(angle);
    
    displayValue1("Time x"+timeCoefficient,timeSpend);
    displayValue2("Angular speed",angle);
  
    drawUI();
  }
  
  if(displayUIReset)
  {
    drawUIReset();
  }
  
  timeSpend += timeCoefficient / frameRate;
  
  println("======================================================================");
  
  stroke(255);

}