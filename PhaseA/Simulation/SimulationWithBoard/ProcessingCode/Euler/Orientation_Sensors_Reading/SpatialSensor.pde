/**
 *  Description : This Class defines Spatial Sensor object 
 *
 */
public abstract class SpatialSensor {
  
  protected PVector received;
  protected PVector calibration;
  public PVector data;
  
  protected int sampleSize;
  protected ArrayList<PVector> sample;
  public PVector smoothed;
  
  protected double lastReadTime; // in seconds
  protected float readTimeDelta; // in seconds
  
  //private int discardedPrecision;
  
  /**
   *  Description : Constructor which initializes Spatial Sensor object
   */
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
  
  /**
   *  Description : Update Time
   */
  public void updateReadTime() {
    if(lastReadTime == 0) // For the first reading
      lastReadTime = (double)(System.currentTimeMillis()) / 1000.0;
      
    else {
      readTimeDelta = (float)((double)(System.currentTimeMillis()) / 1000.0 - lastReadTime);
      lastReadTime += readTimeDelta;
    }
    
  }
  
  
  /**
   *  Description : Read
   */
  public void read(float x, float y, float z) {
    received.set(x, y, z);
    update();
  }
  
  /**
   *  Description : Update Data
   */  
  public void updateData() {
    data = PVector.sub(received, calibration);
  }
  
  
  
  /**
   *  Description : Smooth data
   *
   *  @param newReading     : New reading to add to the sample list used to smooth the data
   */  
  public void updateSmoothed(PVector newReading) {
    PVector sum = new PVector(0, 0, 0);
    
    sample.add(newReading);
    
    while(sample.size() > sampleSize)
      sample.remove(0);
    
    for(int i=0; i<sample.size(); i++)
      sum.add(sample.get(i));
    
    smoothed = sum.div(sample.size());
  }
  
  
  /**
   *  Description : Update
   */
  public void update() {
    updateData();
    updateSmoothed(data);
  }
  
  
  public abstract void calibrate();
  
  
}