/**
 *    Description : This Class defines Earth object
 *
 */
public class Earth {
     
  private int size;
  private PShape globe;
  private PVector position;
  private float angle;
  
  /**
   *  Description : Constructor which initializes Earth object
   */
  public Earth() {
    size = 150;
    
    pushStyle();
    noStroke();
    sphereDetail(100);
    globe = createShape(SPHERE, size);
    globe.setTexture(loadImage("earth.jpg"));
    popStyle();
    
    position = new PVector(1.3*width, 1.3*height, -800);
    angle = 0;
  }
  
  
  /**
   *  Description : Display Earth
   */
  public void draw(){
    pushMatrix();
    
    translate( position.x, position.y, position.z);
    
    rotateX(radians(-20));
    rotateY(radians(angle));
    angle = angle + PI/10;

    shape(globe);
    
    popMatrix();
  }
  
  
}