/**
 *  Description : This Class defines Quaternion object 
 *
 */
public class Quaternion{
    
  private float w;
  private PVector v;
  
  //Description : Constructor which Quaternion object
  public Quaternion(float w, float x, float y, float z) {
    this.w = w;
    this.v = new PVector(x, y, z);
  }
  
  /**
   *  Description : Constructor which Quaternion object from existing vector
   *
   *  @param  w   : scalar
   *  @param  v   : vector axis
   */
  public Quaternion(float p_w, PVector p_v) {
    w = p_w;
    v = new PVector(p_v.x,p_v.y,p_v.z);
  }
  
  public Quaternion(Quaternion p_quaternion) {
    this.w = p_quaternion.w;
    this.v = p_quaternion.v;
  }
  
  /**
   *  Description : Constructor which Quaternion object from Euler angle
   *
   *  @param  ax   : Euler rotation around x axis
   *  @param  ay   : Euler rotation around y axis
   *  @param  az   : Euler rotation around z axis
   */
  public Quaternion(float ax, float ay, float az) {
    
    ax = ax / framePerSecond;
    ay = ay / framePerSecond;
    az = az / framePerSecond;
    
    this.w = cos(ax/2)*cos(ay/2)*cos(az/2) + sin(ax/2)*sin(ay/2)*sin(az/2);
    float tempX= sin(ax/2)*cos(ay/2)*cos(az/2) - cos(ax/2)*sin(ay/2)*sin(az/2);
    float tempY = cos(ax/2)*sin(ay/2)*cos(az/2) + sin(ax/2)*cos(ay/2)*sin(az/2);
    float tempZ = cos(ax/2)*cos(ay/2)*sin(az/2) - sin(ax/2)*sin(ay/2)*cos(az/2);
    
    this.v = new PVector(tempX, tempY, tempZ);
  }
  
  public float getAngularSpeed()
  {
    return 2 * acos(this.w);
  }
  
  public PVector getEulerAxe() {
    return new PVector(this.v.x,this.v.y,this.v.z);
  }
  
  public PVector getDirectionAxis(){
    float xComp = v.x / sqrt(1-w*w);
    float yComp = v.y / sqrt(1-w*w);
    float zComp = v.z / sqrt(1-w*w);
    return new PVector(xComp,yComp,zComp);
  }
  
  public void setVector(PVector p_vector)
  {
    this.v = p_vector;
  }

  public float getAngle()
  {
    return this.w;
  }
  
  public void changeAngle(float p_angle)
  {
    this.w = p_angle;
  }
  
  public Quaternion getConjugate(){
    return new Quaternion(this.w, -this.v.x, -this.v.y, -this.v.z);  
  }
  
  public void printValue(String name)
  {
    println(name+" W="+this.w+" X:"+this.v.x+" Y:"+this.v.y+" Z:"+this.v.z);
  }
  
  public Quaternion plus(Quaternion b) {
    return new Quaternion(this.w+b.w, this.v.x+b.v.x, this.v.y+b.v.y, this.v.z+b.v.z);
  }
  
  public Quaternion plusComponent(Quaternion b) {
    return new Quaternion(this.w, this.v.x+b.v.x, this.v.y+b.v.y, this.v.z+b.v.z);
  }
  
  public Quaternion substract(Quaternion b) {
    return new Quaternion(this.w - b.w,this.v.x - b.v.x,this.v.y - b.v.y,this.v.z - b.v.z);
  }
  
  public Quaternion times(Quaternion b) {
    
   float y0 = this.w*b.w - this.v.x*b.v.x - this.v.y*b.v.y - this.v.z*b.v.z;
   float y1 = this.w*b.v.x + this.v.x*b.w - this.v.y*b.v.z + this.v.z*b.v.y;
   float y2 = this.w*b.v.y + this.v.x*b.v.z + this.v.y*b.w - this.v.z*b.v.x;
   float y3 = this.w*b.v.z - this.v.x*b.v.y + this.v.y*b.v.x + this.v.z*b.w;
   /*
   float y0 = this.w*b.w - this.v.x*b.v.x - this.v.y*b.v.y - this.v.z*b.v.z;
   float y1 = this.w*b.v.x + this.v.x*b.w + this.v.y*b.v.z - this.v.z*b.v.y;
   float y2 = this.w*b.v.y - this.v.x*b.v.z + this.v.y*b.w + this.v.z*b.v.x;
   float y3 = this.w*b.v.z + this.v.x*b.v.y - this.v.y*b.v.x + this.v.z*b.w;*/
    
    return new Quaternion(y0, y1, y2, y3);
  }
  
  public float getNorm(){
    return sqrt(this.w*this.w+this.v.x*this.v.x+this.v.y*this.v.y+this.v.z*this.v.z);
  }
  
  public float getVectorNorm() {
    return sqrt(this.v.x*this.v.x+this.v.y*this.v.y+this.v.z*this.v.z);
  }
  
  public PVector getNormalizedVector()
  {
    float ux = this.v.x / getVectorNorm();
    float uy = this.v.y / getVectorNorm();
    float uz = this.v.z / getVectorNorm();
   return new PVector(ux, uy, uz); 
  }
  
  public void normalize()
  {
    //this.v.normalize();
    float norm = getNorm();
    w = w / norm;
    v.x = v.x / norm;
    v.y = v.y / norm;
    v.z = v.z / norm;
  }
  
  public PVector getEulerAngle()
  {
    float roll,pitch,yaw;
    
    // roll (x-axis rotation)
    float sinr = +2.0 * (this.w * this.v.x + this.v.y * this.v.z);
    float cosr = +1.0 - 2.0 * (this.v.x * this.v.x + this.v.y * this.v.y);
    roll = atan2(sinr, cosr);
    
    // pitch (y-axis rotation)
    float sinp = +2.0 * (this.w * this.v.y - this.v.z * this.v.x);
    if (abs(sinp) >= 1)
        pitch = (abs(sinp)/sinp) * PI / 2; // use 90 degrees if out of range
    else
    pitch = asin(sinp);
    
    // yaw (z-axis rotation)
    float siny = +2.0 * (this.w * this.v.z + this.v.x * this.v.y);
    float cosy = +1.0 - 2.0 * (this.v.y * this.v.y + this.v.z * this.v.z);  
    yaw = atan2(siny, cosy);
    
    return new PVector(roll,pitch,yaw);
  }
  
  // Create Quaternion from an angle and an axis
  public Quaternion fromAxis()
  {
    return new Quaternion(cos(this.w/2),this.v.x*sin(this.w/2),this.v.y*sin(this.w/2),this.v.z*sin(this.w/2));
  }
  
  // Rotate a vector around an axis, and keep it's a value at a magnetitude of 1
  public PVector rotateVector(PVector p_vector) {
    //P' = RPR'
    Quaternion P = new Quaternion(0,p_vector);
    Quaternion H = P.times(this);
    Quaternion finalQuaternion = this.getConjugate().times(H);
    return finalQuaternion.getEulerAxe().normalize();
  }
  
  // Rotate a vector around an axis, and keep it's original magnetitude
  public PVector rotateVectorUnnormalized(PVector p_vector) {
    //P' = RPR'
    Quaternion P = new Quaternion(0,p_vector.x,p_vector.y,p_vector.z);
    Quaternion H = P.times(this);
    Quaternion finalQuaternion = this.getConjugate().times(H);
    return finalQuaternion.getEulerAxe();
  }
  
  public void rotateQuaternion(Quaternion p_quater)
  {
    this.v = p_quater.rotateVectorUnnormalized(this.v);
  }
  
  // Invert rotation axis
  public Quaternion getInverse() {
    float square = this.getNorm() * this.getNorm() ;
    return new Quaternion(this.w/square, -this.v.x/square, -this.v.y/square, -this.v.z/square);
  }
}