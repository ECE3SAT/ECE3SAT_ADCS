
public class Graph {
  private Graph2D graph2D;
  private RollingLine2DTrace line2DTrace;
  private GridBackground background;
  
  public Graph(int positionX, int positionY, int graphWidth, int graphHeight, ILine2DEquation data, String xLabel, String yLabel, int yMin, int yMax, int R, int V, int B){

    graph2D = new Graph2D(Orientation_Sensors_Reading.this, graphWidth, graphHeight, false);
    line2DTrace = new RollingLine2DTrace(data, 100, 0.1); //arg[0] = equation, arg[1] = refreshRate in ms, arg[2] = xIncr amount X-axis increase every update
    line2DTrace.setLineWidth(2);
    line2DTrace.setTraceColour(R, V, B);
    background = new GridBackground(new GWColour(240));
    
    graph2D.setBackground(background);
    graph2D.setYAxisMin(yMin);
    graph2D.setYAxisMax(yMax);
    graph2D.setXAxisMax(+10);
    graph2D.setFontColour(255,255,255);
    graph2D.setXAxisLabel(xLabel);
    graph2D.setYAxisLabel(yLabel);
    graph2D.setXAxisTickSpacing(2);
    graph2D.setYAxisTickSpacing((yMax-yMin)/4);//500);//(YMax-YMin)/5);
    
    graph2D.position.x=positionX;
    graph2D.position.y=positionY;
    
    graph2D.addTrace(line2DTrace);     
  }
  
  public void draw(){
    graph2D.draw();
  }
  
}

class EquationGyroX implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.gyro.data.x/1000;
  }
}
class EquationGyroY implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.gyro.data.y/1000;
  }
}
class EquationGyroZ implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.gyro.data.z/1000;
  }
}
class EquationAttitudeX implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return degrees(cube.attitude.x);
  }
}
class EquationAttitudeY implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return degrees(cube.attitude.y);
  }
}
class EquationAttitudeZ implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return degrees(cube.attitude.z);
  }
}
class EquationMagnetoX implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.magneto.data.x;
  }
}
class EquationMagnetoY implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.magneto.data.y;
  }
}
class EquationMagnetoZ implements ILine2DEquation{
  public double computePoint(double x,int pos) {
    return cube.magneto.data.z;
  }
}