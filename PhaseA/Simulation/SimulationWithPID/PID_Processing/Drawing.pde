
/******Write information about cubesat******/
void writeParam(int x, int y, int size) {
  textSize(size);
  fill(0,180,180);
  text("TheatX : "+degrees(thetaX), x, y+1*size);
  fill(255,125,180);
  text("TheatY : "+degrees(thetaY), x, y+2*size);
  fill(255,0,255);
  text("TheatZ : "+degrees(thetaZ), x, y+3*size);
  fill(255,255,255);
  text("Threshold : "+procX.pid.threshold, 10, y+4*size); // just to prind threshold on screen
  text("KP :" +procX.pid.KP+"  KI :"+procX.pid.KI+"   KD :"+procX.pid.KD,10,y+5*size);
  text("Value to be achieved", x, y+7*size);
  
  text("Edit Value", 1700, 650+size);
  
}


/******Draw earth*****/
void drawEarth(float x, float y, float size) {
  pushMatrix();
  pushStyle();
  noStroke();
  translate(x, y+200);
  rotateZ(radians(earthAngle));
  earthAngle=earthAngle+PI/20;
  sphereDetail(100);
  globe=createShape(SPHERE, size/2);
  globe.setTexture(earthImage);
  shape(globe);
  popStyle();
  popMatrix();
}

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


void Cube(int size) {

  scale(size);
  colorMode(RGB, 1); 
  beginShape(QUADS);
  stroke(255,255,255);
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