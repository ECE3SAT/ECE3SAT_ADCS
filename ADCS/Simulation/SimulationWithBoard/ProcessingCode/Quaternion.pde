/**
 *  Description : This Class defines Quaternion object 
 *
 */
public class Quaternion{
    
  private float w;
  private PVector v;
  
  /**
   *  Description : Constructor which Quaternion object
   *
   *  @param  w   : scalar
   *  @param  x   : vector component 
   *  @param  y   : vector component 
   *  @param  z   : vector component
   */
  public Quaternion(float w, float x, float y, float z) {
    this.w = w;
    this.v.x = x;
    this.v.y = y;
    this.v.z = z;
  }
  
  /**
   *  Description : Get the conjugate Quaternion
   *
   *  @return     : conjugate quaternion (quaternion data type)
   */
  public Quaternion getConjugate(){
    return new Quaternion(this.w, -this.v.x, -this.v.y, -this.v.z);  
  }
  
  /**
   *  Description :  Add the current quaternion to a second one
   *  
   *  @param      :  operand is a quaternion
   *  @return     :  result of addition (quaternion data type)
   */
  public Quaternion plus(Quaternion b) {
    return new Quaternion(this.w+b.w, this.v.x+b.v.x, this.v.y+b.v.y, this.v.z+b.v.z);
  }
  
  /**
   *  Description :  Multiply the current quaternion to a second one
   *
   *  @param      :  operand is a quaternion
   *  @return     :  result of addition (quaternion data type)
   */
  public Quaternion times(Quaternion b) {
    float y0 = this.w*b.w - this.v.x*b.v.x - this.v.y*b.v.y - this.v.z*b.v.z;
    float y1 = this.w*b.v.x + this.v.x*b.w + this.v.y*b.v.z - this.v.z*b.v.y;
    float y2 = this.w*b.v.y - this.v.x*b.v.z + this.v.y*b.w + this.v.y*b.v.x;
    float y3 = this.w*b.v.z + this.v.x*b.v.y - this.v.y*b.v.x + this.v.y*b.w;
    return new Quaternion(y0, y1, y2, y3);
  }
  
  /**
   *  Description :  Get the norm of the current Quaternion
   *
   *  @return     :  norm (float data type)
   */ 
  public float getNorm(){
    return sqrt(this.w*this.w+this.v.x*this.v.x+this.v.y*this.v.y+this.v.z*this.v.z);
  }
  
  
  /**
   *  Description : Multiply the current quaternion to a second one
   *
   *  @return     :  result of addition
   */
  public Quaternion getInverse() {
    float square = this.getNorm() * this.getNorm() ;
    return new Quaternion(this.w/square, -this.v.x/square, -this.v.y/square, -this.v.z/square);
  }
    
}