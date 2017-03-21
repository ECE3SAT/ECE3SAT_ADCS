public class Earth {
  
  public Earth() {
    size = 250;
    
    pushStyle();
    noStroke();
    sphereDetail(100);
    globe = createShape(SPHERE, size);
    globe.setTexture(loadImage("earth.jpg"));
    popStyle();
    
    position = new PVector(width/4, 3*height/4, 0);
    angle = 0;
  }
  
  
  public void draw(){
    pushMatrix();
    
    translate(position.x, position.y, position.z);
    
    rotateX(radians(-20));
    rotateY(radians(angle));
    angle = angle + PI/40;
    
    shape(globe);
    
    popMatrix();
  }
  
  
  
  int size;
  PShape globe;
  PVector position;
  float angle;
  
}