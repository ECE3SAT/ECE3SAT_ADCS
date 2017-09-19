public class Quaternion {
  private float w, x, y, z;
  
  public Quaternion() { // Default construtor initialized to 0
    set(0, 0, 0, 0);
  }
  public Quaternion(float _w, float _x, float _y, float _z) {
    set(_w, _x, _y, _z);
  }
  public Quaternion(float _w, PVector _v) {
    set(_w, _v);
  }
  public Quaternion(Quaternion _q) {
    set(_q);
  }
  
  public void set(float _w, float _x, float _y, float _z) {
    w = _w;
    x = _x;
    y = _y;
    z = _z;
  }
  public void set(float _w, PVector _v) {
    w = _w;
    x = _v.x;
    y = _v.y;
    z = _v.z;
  }
  public void set(Quaternion _q) {
    w = _q.w;
    x = _q.x;
    y = _q.y;
    z = _q.z;
  }
  
  public Quaternion plus(Quaternion q) {
    return new Quaternion(w+q.w, x+q.x, y+q.y, z+q.z);
  }
  
  public Quaternion add(Quaternion q) {
    set(plus(q));
    return this;
  }
  
  public Quaternion times(Quaternion q) {
    float _w = w*q.w - (x*q.x + y*q.y + z*q.z);
    float _x = w*q.x + q.w*x + y*q.z - z*q.y;
    float _y = w*q.y + q.w*y + z*q.x - x*q.z;
    float _z = w*q.z + q.w*z + x*q.y - y*q.x;
    return new Quaternion(_w, _x, _y, _z);
  }
  public Quaternion times(float n) {
    return new Quaternion(w*n, x*n, y*n, z*n);
  }
  
  public Quaternion mult(Quaternion q) {
    set(times(q));
    return this;
  }
  public Quaternion mult(float n) {
    set(times(n));
    return this;
  }
  
  public Quaternion division(float n) {
    if(n != 0)
      return new Quaternion(w/n, x/n, y/n, z/n);
    else
      return new Quaternion(1, 0, 0, 0);
  }
  
  public Quaternion divide(float n) {
    set(division(n));
    return this;
  }
  
  public float norm() {
    return sqrt(w*w + x*x + y*y + z*z);
  }
  
  public Quaternion normalized() {
    float norm = norm();
    
    if(norm != 0)
      return division(norm);
    else
      return new Quaternion(1, 0, 0, 0);
  }
  
  public Quaternion normalize() {
    set(normalized());
    return this;
  }
  
  public Quaternion conjugated() {
    return new Quaternion(w, -x, -y, -z);
  }
  
  public Quaternion conjugate() {
    set(conjugated());
    return this;
  }
  
  public PVector vectorPart() {
    return new PVector(x, y, z);
  }
}