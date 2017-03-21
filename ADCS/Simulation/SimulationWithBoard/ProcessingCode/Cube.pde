public class Cube {
  
  public Cube() {
    size = 80;
    
    attitude = new PVector(0, 0, 0);
    speedAng = new PVector(0, 0, 0);
    
    position = new PVector(2*width/3, height/3, 0);
    speedLin = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    
    gyro = new Gyroscope();
    accelero = new Accelerometer();
    magneto = new Magnetometer();
  }
  
  
  public void updateAngularSpeed() {
    speedAng = PVector.div(gyro.data, 1000); // Conversion from md.s-1 to d.s-1
    /*speedAng.rotateX(radians(-attitude.x));
    speedAng.rotateY(radians(-attitude.y));
    speedAng.rotateZ(radians(-attitude.z));*/
    //...
    //initRotMatrix(PVector.sub(new PVector(0, 0, 0), attitude));
    //speedAng = PVectorRotation(gyro.data, rotationMatrix);
  }
  
  public void updateAttitude() {
    updateAngularSpeed();
    
    attitude.x = degrees(radians(attitude.x)+radians(speedAng.x)*gyro.readTimeDelta);
    attitude.y = degrees(radians(attitude.y)+radians(speedAng.y)*gyro.readTimeDelta);
    attitude.z = degrees(radians(attitude.z)+radians(speedAng.z)*gyro.readTimeDelta);
  }
  
  public void gyroEvent(float x, float y, float z) {
    gyro.updateReadTime();
    
    updateAttitude();
    
    gyro.read(x, y, z);
  }
  
  
  public void updateAcceleration() {
    acceleration = PVector.mult(accelero.data, 0.00981); // Convertion from mg to m.s-2
  }
  
  public void updateLinearSpeed() {
    updateAcceleration();
    // ... To do
    //Vitesse=Integral( acceleration ) entre T1 et T2
    //cube.speedLin.x = cube.speedLin.x + accelero.x * timesec;
  }
  
  public void updatePosition() {
    updateLinearSpeed();
    // ... To do
    //Position=Integral( vitesse ) entre T1 et T2
    //cube.position.x = cube.position.x + cube.speedLin.x*timesec + 1/2*accelero.x * timesec*timesec;
  }
  
  public void acceleroEvent(float x, float y, float z) {
    accelero.updateReadTime();
    
    updatePosition();
    
    accelero.read(x, y, z);
  }
  
  
  public void magnetoEvent(float x, float y, float z) {
    magneto.updateReadTime();
    
    magneto.read(x, y, z);
  }
  
  /*public void calibrate() {
    
  }*/
  
  
  
  private void shape() {
    beginShape(QUADS);
    fill(0, 1, 1);      //cyan
    vertex(-1,  1,  1);  vertex( 1,  1,  1);  vertex( 1, -1,  1);  vertex(-1, -1,  1);
    fill(1, 1, 1);      //blanc
    vertex( 1,  1,  1);  vertex( 1,  1, -1);  vertex( 1, -1, -1);  vertex( 1, -1,  1);
    fill(1, 1, 0);      //jaune
    vertex( 1,  1, -1);  vertex(-1,  1, -1);  vertex(-1, -1, -1);  vertex( 1, -1, -1);
    fill(0, 1, 0);      //bleu
    vertex(-1,  1, -1);  vertex(-1,  1,  1);  vertex(-1, -1,  1);  vertex(-1, -1, -1);
    fill(0, 0, 1);      //vert
    vertex(-1,  1, -1);  vertex( 1,  1, -1);  vertex( 1,  1,  1);  vertex(-1,  1,  1);
    fill(1, 0, 0);      //rouge
    vertex(-1, -1, -1);  vertex( 1, -1, -1);  vertex( 1, -1,  1);  vertex(-1, -1,  1);
    endShape();
  }
  
  public void draw(){
    pushMatrix();
    pushStyle();
    
    translate(position.x, position.y, position.z);
    
    rotateZ(radians(attitude.z));
    rotateY(radians(attitude.y));
    rotateX(radians(attitude.x));
    
    scale(size);
    stroke(255);
    strokeWeight(0.02);
    colorMode(RGB, 1);
    
    shape(); //box(cube.size);
  
    popMatrix();
    popStyle();
  }
  
  
  
  public int size;
  
  public PVector attitude; // in d
  public PVector speedAng; // Angular speed in d.s-1
  
  public PVector position; // in m
  public PVector speedLin; // Linear speed in m.s-1
  public PVector acceleration; // in m.s-2
  
  public Gyroscope gyro;
  public Accelerometer accelero;
  public Magnetometer magneto;
  
}