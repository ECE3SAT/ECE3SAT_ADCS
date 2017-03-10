
/******Write the entries of the serial communication******/
void writeParam(int x, int y, int size) {
  textSize(size);
  /*text("magnetoX (mGauss) : "+magneto[0] ,x,y);
   text("magnetoY (mGauss) : "+magneto[1] ,x,y+1*size);
   text("magnetoZ (mGauss) : "+magneto[2] ,x,y+2*size);
   text("acceleroX : "+acceleroSmoothed[0] ,x,y+3*size);
   text("acceleroY : "+accelero[1] ,x,y+4*size);
   text("acceleroZ : "+accelero[2] ,x,y+5*size);
   text("gyroX (mdps) : "+gyro[0] ,x,y+6*size);
   text("gyroY (mdps) : "+gyro[1] ,x,y+7*size);
   text("gyroZ (mdps) : "+gyro[2] ,x,y+8*size);
   */
  text("TheatX : "+degrees(thetaX), x, y);
  text("TheatY : "+degrees(thetaY), x, y+1*size);
  text("TheatZ : "+degrees(thetaZ), x, y+2*size);
  text("Threshold : ", 10, 74);
  text("Value to be achieved", x, 120);
  text("Threshold : "+procX.pid.threshold, 10, 74); // just to prind threshold on screen
  text("Edit Value", 1700, 820);
}

//Draw the earth on screen (after computing the new orientation)//
/******Draw earth*****/
void drawEarth(float x, float y, float size) {
  pushMatrix();
  pushStyle();
  noStroke();
  translate(x, y);
  rotateZ(radians(earthAngle));
  earthAngle=earthAngle+PI/20;
  sphereDetail(100);
  globe=createShape(SPHERE, size);
  globe.setTexture(earthImage);
  shape(globe);
  popStyle();
  popMatrix();
}

//Draw the cube on screen (after computing the new orientation)//
/******Draw CubeSat******/
void drawCube(float x, float y, float z, float thetaX, float thetaY, float thetaZ, int size) {
  pushMatrix();
  pushStyle();
  fill(100, 100, 100, 50);
  translate(x, y, z);
  rotateX(thetaX);
  rotateY(thetaZ);
  rotateZ(thetaY);
  Cube(size);
  popMatrix();
  popStyle();
}

//Create the cube and colorise it//
void Cube(int size) {

  scale(size);
  colorMode(RGB, 1); 
  beginShape(QUADS);

  strokeWeight(0.05);
  fill(0, 1, 1);
  vertex(-1, 1, 1);
  vertex( 1, 1, 1);
  vertex( 1, -1, 1);
  vertex(-1, -1, 1);

  fill(1, 1, 1);
  vertex( 1, 1, 1);
  vertex( 1, 1, -1);
  vertex( 1, -1, -1);
  vertex( 1, -1, 1);

  fill(1, 1, 0);
  vertex( 1, 1, -1);
  vertex(-1, 1, -1);
  vertex(-1, -1, -1);
  vertex( 1, -1, -1);

  fill(0, 1, 0);
  vertex(-1, 1, -1);
  vertex(-1, 1, 1);
  vertex(-1, -1, 1);
  vertex(-1, -1, -1);

  fill(0, 0, 1);
  vertex(-1, 1, -1);
  vertex( 1, 1, -1);
  vertex( 1, 1, 1);
  vertex(-1, 1, 1);

  fill(1, 0, 0);
  vertex(-1, -1, -1);
  vertex( 1, -1, -1);
  vertex( 1, -1, 1);
  vertex(-1, -1, 1);

  endShape();
}
