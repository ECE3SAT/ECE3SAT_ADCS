 /**
  *    Description  : Display data on screen from serial communication          
  *
  *    @param x     : x coordinate which corresponds to the upper corner left
  *    @param y     : y coordinate which corresponds to the upper corner left
  *    @param size  : size of the text
  */
void writeSerial(float x, float y, int size){
  pushStyle();
  textSize(size);
 
  fill(255,0,0);text("X", x+120, y);fill(0,255,0);text("Y", x+260, y);fill(0,0,255);text("Z", x+400, y);fill(255,255,255);text("Unit", x+520, y);
  
  text("magneto :", x, y+1*size);
    text(cube.magneto.data.x, x+100, y+1*size);
    text(cube.magneto.data.y, x+240, y+1*size);
    text(cube.magneto.data.z, x+380, y+1*size);
    text("mgauss", x+500, y+1*size);
  text("gyro :", x, y+2*size);
    text(cube.gyro.data.x, x+100, y+2*size);
    text(cube.gyro.data.y, x+240, y+2*size);
    text(cube.gyro.data.z, x+380, y+2*size);
    text("mdps", x+500, y+2*size);
  text("attitude :", x, y+3*size);
    text(degrees(cube.attitude.x), x+100, y+3*size);
    text(degrees(cube.attitude.y), x+240, y+3*size);
    text(degrees(cube.attitude.z), x+380, y+3*size);
    text("deg", x+500, y+3*size);
  text("accelero :", x, y+4*size);
    text(cube.accelero.data.x, x+100, y+4*size);
    text(cube.accelero.data.y, x+240, y+4*size);
    text(cube.accelero.data.z, x+380, y+4*size);
    text("mg", x+500, y+4*size);
  text("position :", x, y+5*size);
    text(cube.position.x, x+100, y+5*size);
    text(cube.position.y, x+240, y+5*size);
    text(cube.position.z, x+380, y+5*size);
    text("m", x+500, y+5*size);
  text("attitude (q) :", x, y+6*size);
    text(cube.attitudeQ.x/sin(acos(cube.attitudeQ.w)), x+100, y+6*size);
    text(cube.attitudeQ.y/sin(acos(cube.attitudeQ.w)), x+240, y+6*size);
    text(cube.attitudeQ.z/sin(acos(cube.attitudeQ.w)), x+380, y+6*size);
    text(degrees(2*acos(cube.attitudeQ.w)), x+500, y+6*size);
 
  popStyle();
}


 /**
  *    Description  : Display help text on screen          
  *
  *    @param x     : x coordinate which corresponds to the upper corner left
  *    @param y     : y coordinate which corresponds to the upper corner left
  *    @param size  : size of the text
  */
void writeHelp(int x, int y, int size){
  pushStyle();
  textSize(size);
  stroke(255);
  
  text("Camera Help :", x, y-3); 
  line(x, y, x+100, y);
    text("+ Press \"C\" to activate or deactivate", x, y+1*size);
    text("+ Drag the left click to rotate", x, y+2*size);
    text("+ Use the mouse wheel to zoom", x, y+3*size);
    text("+ Double click to reset view", x, y+4*size);
    
  text("Calibration :", x, y+6*size-3);
  line(x, y+6*size, x+80, y+6*size);
    text("+ Press \"SPACEBAR\" to calibrate", x, y+7*size);
  
  text("Graphs :", x, y+9*size-3);
  line(x, y+9*size, x+60, y+9*size);
  text("+ Press \"P\" to pause", x, y+10*size);
  
  popStyle();
  
  if(!deviceConnected){
    pushStyle();
    textSize(20);
    fill(255, 0, 0);
    text("PORT NOT FOUND !!!  Connect Your Device", 0.48*width, 50);
    popStyle();
  }
}