/***********    Ecrit les entrées de la communication série    ********/
void writeSerial(int x, int y, int size){
  pushStyle();
  textSize(size);
  text("magnetoX (mGauss) : " + cube.magneto.data.x, x, y);
  text("magnetoY (mGauss) : " + cube.magneto.data.y, x, y+1*size);
  text("magnetoZ (mGauss) : " + cube.magneto.data.z, x, y+2*size);
  text("acceleroX (mg) : " + cube.accelero.data.x, x, y+3*size);
  text("acceleroY (mg) : " + cube.accelero.data.y, x, y+4*size);
  text("acceleroZ (mg) : " + cube.accelero.data.z, x, y+5*size);
  text("gyroX (mdps) : " + cube.gyro.data.x, x, y+6*size);
  text("gyroY (mdps) : " + cube.gyro.data.y, x, y+7*size);
  text("gyroZ (mdps) : " + cube.gyro.data.z, x, y+8*size);
  
  text("calibrationX (mdps) : " + cube.gyro.calibration.x, x, y+10*size);
  text("calibrationY (mdps) : " + cube.gyro.calibration.y, x, y+11*size);
  text("calibrationZ (mdps) : " + cube.gyro.calibration.z, x, y+12*size);
  
  text("attitudeX (d) : " + String.format("%,8.3f", cube.attitude.x), x, y+14*size);
  text("attitudeY (d) : " + String.format("%,8.3f", cube.attitude.y), x, y+15*size);
  text("attitudeZ (d) : " + String.format("%,8.3f", cube.attitude.z), x, y+16*size);
  popStyle();
}



/***************    Ecrit aide    ****************/
void writeHelp(int x, int y, int size){
  pushStyle();
  textSize(size);
  text("Camera Help :", x, y-3);
  stroke(255);
  line(x, y, x+80, y);
  text("Drag the left click to rotate", x, y+1*size);
  text("Use the mouse wheel to zoom", x, y+2*size);
  text("Double click to reset view", x, y+3*size);
  popStyle();
  
  if(!deviceConnected){
    pushStyle();
    textSize(30);
    fill(255, 0, 0);
    text("PORT NOT FOUND !!!  Connect Your Device", width/4, 50);
    popStyle();
  }
}



/******************    Dessine une flèche    ****************/
void drawArrow(PVector arrowPos, float xcenter, float ycenter, float zcenter, color c){
  pushStyle();
  pushMatrix();
  
  //Epaisseur, Couleur
  stroke(c);
  strokeWeight(2);
  
  //Dessin
  line(arrowPos.y+xcenter, -arrowPos.x+ycenter, arrowPos.z+zcenter, xcenter, ycenter, zcenter);   //on inverse les axes car les mems ne sont pas orienté dans le même sens
  //text("x " + xcenter + " y " + ycenter, xcenter, ycenter);
  
  popMatrix();
  popStyle();
}