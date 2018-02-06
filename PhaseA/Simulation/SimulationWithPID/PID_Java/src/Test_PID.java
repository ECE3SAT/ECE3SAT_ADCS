//delais -> pchit et l'action
//travailler sur un seul 
//remettre tous les graph sur une même échelle
//intégrer des variations temporelles (pertes de chaleur/vitesse/frottement)
//régler le PID

public class Test_PID {
	double measure=10;
        static double commandMultiplier = 0.3;
        int maxIteration = 1000;
        double disp=0.2;
        
        double KP=1;
	double KI=2;
	double KD=0;
        
        
        
	////////////////////////////////
        int i;
        double currentValue=measure;
	public double systemSimulator(double command) {
		System.out.println("measure:"+measure);
		measure=command*commandMultiplier +currentValue;
		if(i%2==0){
                    measure=measure-disp;
                }
                currentValue=measure;
                System.out.println("measure:"+measure);
		return measure;
	}
	
	public void myEvaluation() {
		try {
			i=0;
			double pidVal=0;
                        
			Pid2 pid=new Pid2(KP,KI,KD,measure);
			pid.consigne=230.;
			//measure=systemSimulator(0.);
			
                        
			GraphikInterface graph;
			graph=new GraphikInterface("PID", "pid1", "val", "iteration", 0);
			graph.newLineSeries("pid");
			graph.newLineSeries2("command");
			graph.newLineSeries3("consigne");
                        
			
	
			while(true) {
				
                                System.out.println("Ite "+i+": measure="+measure+" command="+pidVal);
				graph.addLine(i, measure);
				graph.addLine2(i, pidVal);
				graph.addLine3(i, pid.consigne);
				
				
				pidVal=pid.PID2(measure);
				measure=systemSimulator(pidVal);
				
                                
				
				i++;
                                graph.Display();
				if(i>maxIteration) break;
			}
			graph.Display();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}		
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		new Test_PID().myEvaluation();
               

	}

}