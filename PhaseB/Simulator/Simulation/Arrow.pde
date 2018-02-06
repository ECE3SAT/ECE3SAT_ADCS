

public class Arrow {
  
  private float cc_x1, cc_y1, cc_z1, cc_x2, cc_y2, cc_z2;
  
  public Arrow (float x1, float y1,float z1, float x2, float y2,float z2) {
    cc_x1 = x1;
    cc_y1 = y1;
    cc_z1 = z1;
    cc_x2 = x2;
    cc_y2 = y2;
    cc_z2 = z2;
  }
  
  public Arrow (PVector f_point, PVector s_point) {
    cc_x1 = f_point.x;
    cc_y1 = f_point.y;
    cc_z1 = f_point.z;
    cc_x2 = s_point.x;
    cc_y2 = s_point.y;
    cc_z2 = s_point.z;
  }
  
  public void changeArrow (PVector p_vector) {
    cc_x1 = 0;
    cc_y1 = 0;
    cc_z1 = 0;
    cc_x2 = p_vector.x;
    cc_y2 = p_vector.y;
    cc_z2 = p_vector.z;
  }
  
  public void draw()
  {
    translate(width-100, height/2);
    
    stroke(255,0,0);
    line(cc_x1,cc_y1,cc_z1,cc_x2,cc_y2,cc_z2);
    //line(cc_x1,cc_z1,cc_y1,cc_x2,cc_z2,cc_y2);
  
    
    translate(-width+100, -height/2);
    
  }
  
}