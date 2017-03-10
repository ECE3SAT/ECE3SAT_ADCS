import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartUtilities;

import java.awt.Color;
import java.awt.Dimension;
import java.io.File;

import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.ui.ApplicationFrame;
import org.jfree.ui.RefineryUtilities;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;


public class GraphikInterface extends ApplicationFrame {
	int type;
	public XYSeries	PointSeries;
	public XYSeries	LineSeries, LineSeries2, LineSeries3;
	XYPlot Plot;
	String ChartTitle;
	double x,y;
	int w, h;
        boolean tester = true;
	String pngFileName, text;
	
	
	public void newPointSeries(String name) { PointSeries=new XYSeries(name); }
	public void newLineSeries(String name) { LineSeries=new XYSeries(name); }
	public void newLineSeries2(String name) { LineSeries2=new XYSeries(name); }
	public void newLineSeries3(String name) { LineSeries3=new XYSeries(name); }
	public void addPoint(double x, double y) { PointSeries.add(x,y); }
	public void addLine(double x, double y) { LineSeries.add(x,y); }
	public void addLine2(double x, double y) { LineSeries2.add(x,y); }
	
	public void addLine3(double x, double y) { 
		LineSeries3.add(x,y);
		//System.out.println("addline3 x="+x+" y="+y);
	}
	
	public void setPos(double x, double y, int w, int h){
		this.x=x; this.y=y; this.w=w; this.h=h;
	}
	
   public XYDataset getScatterPlotData() {
		if(PointSeries.isEmpty()==true) {
			//System.out.println("point serie null");
			return null;
		}

		XYSeriesCollection xySeriesCollection= new XYSeriesCollection();
       xySeriesCollection.addSeries(PointSeries);
       return xySeriesCollection;	   
   }

   public XYDataset getLinePlotData() {
		if(LineSeries.isEmpty()==true) return null;

		XYSeriesCollection xySeriesCollection= new XYSeriesCollection();
       xySeriesCollection.addSeries(LineSeries);
       return xySeriesCollection;	   
   }

   public XYDataset getLinePlotData2() {
		if(LineSeries2.isEmpty()==true) return null;

		XYSeriesCollection xySeriesCollection= new XYSeriesCollection();
       xySeriesCollection.addSeries(LineSeries2);
       return xySeriesCollection;	   
   }
   

   public XYDataset getLinePlotData3() {
		if(LineSeries3.isEmpty()==true) return null;

		XYSeriesCollection xySeriesCollection= new XYSeriesCollection();
       xySeriesCollection.addSeries(LineSeries3);
       return xySeriesCollection;	   
   }

   public GraphikInterface ( String applicationTitle , String chartTitle, String XName, String YName,  int type ) {
	      super(applicationTitle);
	      this.type=type;

	      ChartTitle=chartTitle;
	      // Create a single plot containing both the scatter and line
	      Plot = new XYPlot();
            // Dimention d;
            Dimension d = new Dimension(800,600);
              //this.setSize(d);
              this.setPreferredSize(d);  // this line put a preferd size MOST IMPORTANT TO SEE THE WINDOWS
              //this.setBounds(1500, 1500, 2000, 2000);
              this.isVisible();
             // this.pack();
	  	  PointSeries=new XYSeries("Point");
		  LineSeries=new XYSeries("Line");
		  LineSeries2=new XYSeries("Line2");
		  LineSeries3=new XYSeries("Line3");
                  
   }

   public void Display() throws Exception {
      /* SETUP SCATTER */
      
      // Create the scatter data, renderer, and axis
      XYDataset collection1 = getScatterPlotData();
      if(collection1!=null && tester) {
    	  //System.out.println(ChartTitle+" collpointcount="+collection1.getSeriesCount());
    	  XYItemRenderer renderer1 = new XYLineAndShapeRenderer(false, true);   // Shapes only
    	  renderer1.setSeriesPaint(0, Color.RED);
    	  ValueAxis domain1 = new NumberAxis("Domain1");
    	  ValueAxis range1 = new NumberAxis("Range1");

	      // Set the scatter data, renderer, and axis into plot
	      Plot.setDataset(0, collection1);
	      Plot.setRenderer(0, renderer1);
	      Plot.setDomainAxis(0, domain1);
	      Plot.setRangeAxis(0, range1);
	      
	      // Map the scatter to the first Domain and first Range
	      Plot.mapDatasetToDomainAxis(0, 1);
	      Plot.mapDatasetToRangeAxis(0, 1);
              tester=false;
      }
      

      /* SETUP LINE */

      // Create the line data, renderer, and axis
      XYDataset collection2 = getLinePlotData();
      if(collection2!=null) {
    	  //System.out.println(ChartTitle+" coll2count="+collection2.getSeriesCount());

    	  XYItemRenderer renderer2 = new XYLineAndShapeRenderer(true, false);   // Lines only
    	  renderer2.setSeriesPaint(0, Color.BLACK);
    	  ValueAxis domain2 = new NumberAxis("Domain2");
    	  ValueAxis range2 = new NumberAxis("Range2");
    	  
          // Set the line data, renderer, and axis into plot
          Plot.setDataset(1, collection2);
          Plot.setRenderer(1, renderer2);
          Plot.setDomainAxis(1, domain2);
          Plot.setRangeAxis(1, range2);
          
          // Map the line to the second Domain and second Range
          Plot.mapDatasetToDomainAxis(1, 1);
          Plot.mapDatasetToRangeAxis(1, 1);
      }



      // Create the line data, renderer, and axis
      XYDataset collection3 = getLinePlotData2();
      if(collection3!=null) {
    	  //System.out.println(ChartTitle+" coll3count="+collection3.getSeriesCount());

    	  XYItemRenderer renderer3 = new XYLineAndShapeRenderer(true, false);   // Lines only
    	  renderer3.setSeriesPaint(0, Color.RED);
    	  if(text==null) text="Domain3";
    	  ValueAxis domain3 = new NumberAxis(text);
    	  ValueAxis range3 = new NumberAxis("Range3");
    	  
          // Set the line data, renderer, and axis into plot
          Plot.setDataset(2, collection3);
          Plot.setRenderer(2, renderer3);
          Plot.setDomainAxis(2, domain3);
          Plot.setRangeAxis(2, range3);
          
          // Map the line to the second Domain and second Range
          Plot.mapDatasetToDomainAxis(2, 1);
          Plot.mapDatasetToRangeAxis(2, 1);
      }

      // Create the line data, renderer, and axis
      XYDataset collection4 = getLinePlotData3();
      if(collection4!=null) {
    	  //System.out.println(ChartTitle+" coll4count="+collection4.getSeriesCount());

    	  XYItemRenderer renderer4 = new XYLineAndShapeRenderer(true, false);   // Lines only
    	  renderer4.setSeriesPaint(0, Color.BLUE);
    	  ValueAxis domain4 = new NumberAxis("Domain4");
    	  ValueAxis range4 = new NumberAxis("Range4");
    	  domain4.setAxisLineVisible(true);
    	  domain4.setVisible(true);
    	  
          // Set the line data, renderer, and axis into plot
          Plot.setDataset(3, collection4);
          Plot.setRenderer(3, renderer4);
          Plot.setDomainAxis(3, domain4);
          Plot.setRangeAxis(3, range4);
          Plot.setDomainZeroBaselineVisible(true);
          
          // Map the line to the second Domain and second Range
          Plot.mapDatasetToDomainAxis(3, 1);
          Plot.mapDatasetToRangeAxis(3, 1);
      }


      // Create the chart with the plot and a legend
      JFreeChart chart = new JFreeChart(ChartTitle, JFreeChart.DEFAULT_TITLE_FONT, Plot, true);  
      
      if(pngFileName!=null) {
    	  File pngFile=new File(pngFileName);
    	  //System.out.println("file="+pngFile+" chart="+chart);
    	  ChartUtilities.saveChartAsPNG(pngFile, chart, 720, 720);
      }
      
      ChartPanel chartPanel = new ChartPanel( chart );
      chartPanel.setPreferredSize( new java.awt.Dimension( w, h ) );
      RefineryUtilities.positionFrameOnScreen(this , x, y);

      setContentPane( chartPanel );
      
      pack( );
      //RefineryUtilities.centerFrameOnScreen( chart );
      setVisible( true );      
      
      
      
 /*     
      JFreeChart lineChart = ChartFactory.createLineChart(
         chartTitle,
         XName,YName,
         createDataset(),
         PlotOrientation.VERTICAL,
         true,true,false);
         
      CategoryPlot plot=(CategoryPlot) lineChart.getPlot();
      plot.getRenderer().setSeriesPaint(0, Color.BLACK);
      
      
      XYDataset xyDataSet=createXYDataSet();
      XYItemRenderer renderer1 = new XYLineAndShapeRenderer(false, true);
      XYPlot pointPlot=new XYPlot();
      pointPlot.setDataset(xyDataSet);
      pointPlot.setRenderer(renderer1);
//      JFreeChart pointChart=ChartFactory.createScatterPlot("scatter", "blop", "blip", xyDataSet);
      
      ChartPanel chartPanel = new ChartPanel( lineChart );
      chartPanel.setPreferredSize( new java.awt.Dimension( 560 , 367 ) );
      setContentPane( chartPanel );
      */
   }

   final static int ARRAYSIZE=4096;
   static double[] freqTab, realTab, imgTab, valTab;
   static int dataNum;
   public static int addData(double freq, double real, double imaginary, double value) {
	   if(freqTab==null) {
		   freqTab=new double[ARRAYSIZE];
		   realTab=new double[ARRAYSIZE];
		   imgTab=new double[ARRAYSIZE];
		   valTab=new double[ARRAYSIZE];
	   }
	   if(dataNum>=ARRAYSIZE) return -1;
	   freqTab[dataNum]=freq;
	   realTab[dataNum]=real;
	   imgTab[dataNum]=imaginary;
	   valTab[dataNum]=value;
	   dataNum++;
	   return 1;
   }
   
   private DefaultCategoryDataset createDataset(String name, int[] tab, int offset, int len ) {
      int i, max=0;
      DefaultCategoryDataset dataset = new DefaultCategoryDataset( );
            
      for(i=0; i<len; i++) dataset.addValue(tab[i+offset], name, Integer.toString(i)); 
      return dataset;
   }
   
}