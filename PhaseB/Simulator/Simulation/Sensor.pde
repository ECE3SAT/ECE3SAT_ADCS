

public abstract class Sensor {
  
  float voltage;
  float powerConsumption;
  private float noiseAmplitude;
    
  double lastReadTime;
  float readTimeDelta;
  
  private boolean sendingData = false;
    
  private ArrayList<PVector> sample;
  protected int sampleSize;
  public PVector data;
  public PVector smoothed;
    
  public Sensor(){}
    
  protected PVector received;
  protected PVector calibration;

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
  
  public abstract void updateSensor(Cube cube);
  public abstract void sendDataToSerial(Serial serial);
  
  public void setSendingData(boolean p_sending)
  {
    sendingData = p_sending;
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
  
}