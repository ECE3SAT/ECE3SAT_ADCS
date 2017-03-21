public abstract class SpatialSensor {
  
  public SpatialSensor() {
    received = new PVector(0, 0, 0);
    calibration = new PVector(0, 0, 0);
    data = new PVector(0, 0, 0);
    
    sampleSize = 50;
    sample = new ArrayList(sampleSize);
    smoothed = new PVector(0, 0, 0);
    
    lastReadTime = 0;
    readTimeDelta = 0;
  }
  
  
  public void updateReadTime() {
    if(lastReadTime == 0) // For the first reading
      lastReadTime = (double)(System.currentTimeMillis()) / 1000.0;
      
    else {
      readTimeDelta = (float)((double)(System.currentTimeMillis()) / 1000.0 - lastReadTime);
      lastReadTime += readTimeDelta;
    }
  }
  
  
  public void read(float x, float y, float z) {
    received.set(x, y, z);
    update();
  }
  
  
  public void updateData() {
    data = PVector.sub(received, calibration);
  }
  
  
  public void updateSmoothed(PVector newReading) {
    PVector sum = new PVector(0, 0, 0);
    
    sample.add(newReading);
    
    while(sample.size() > sampleSize)
      sample.remove(0);
    
    for(int i=0; i<sample.size(); i++)
      sum.add(sample.get(i));
    
    smoothed = sum.div(sample.size());
  }
  
  
  public void update() {
    updateData();
    updateSmoothed(data);
  }
  
  
  public abstract void calibrate();
  
  
  
  protected PVector received;
  protected PVector calibration;
  public PVector data;
  
  protected int sampleSize;
  protected ArrayList<PVector> sample;
  public PVector smoothed;
  
  protected double lastReadTime; // in seconds
  protected float readTimeDelta; // in seconds
  
  //private int discardedPrecision;
  
}