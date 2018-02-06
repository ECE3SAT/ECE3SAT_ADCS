

public class Pid2 {
	double threshold=0.1;
	static double precisionRound=10000; //the precision round for example 1000 for 3 number after the point (10000 for 4 and so on)
	static double maxChangePerIterateration=1;
	static int delayTime=5;
	
///////////////////////
        double KP;
	double KD;
	double KI;
        double error;
	///////////////////////
	public double consigne, sumError, previousMistake, previousConsigne;
	
	
    Double delay[];  
    //int timeForNextAction;
    
      
        
	public Pid2(double KP, double KD, double KI,double mesure){
                delay= new Double[delayTime];
                
                for(int i = 0; i<delayTime;i++){
                delay[i]=mesure;
                
                } 
                
                this.KP=KP;
		this.KD=KD;
		this.KI=KI;
		//timeForNextAction=delayTime;
	}

	public double PID2(double measure) {
		double pid = 0;
		
		double errorVariation;
		int x;
		//double somme_errors=0;


		error=consigne-measure;

		if(measure>0) sumError += consigne - measure;
		errorVariation = error - previousMistake;
		//	pid = KP * error + KI * sumError + KD * errorVariation;
		pid = KP * error +KI * sumError + KD* errorVariation;
		previousMistake = error;
		//System.out.println("PID : measure="+measure+" error="+error+" pidres="+pid+" Rounded value of pidres  "+(double)(Math.round(pid*precisionRound)/precisionRound)+" PreviousConsigne "+previousConsigne);
		pid= (double)(Math.round(pid*precisionRound)/precisionRound);//we round the value to be closer to the reality, we want the precision of the command to be equals to the "precision" constant
		
		//We limit the possibility of change between 2 command 
		if (Math.abs(previousConsigne-pid)>maxChangePerIterateration)
			{
				if (previousConsigne-pid<0)
				{previousConsigne=previousConsigne+maxChangePerIterateration;}
				else 
				{previousConsigne=previousConsigne-maxChangePerIterateration;}
			}
		else
			{previousConsigne=pid;}
		
		return Delay();// We take into consideration the delay
	}
        
	
	//This delay stock the successive decisions in an array and those decisions are then taken successively respecting the delay (which leads to an amplification of decisions and an amplified sinusoid)
       public double Delay(){
        	
            for(int i = 0; i<delayTime-1;i++){
                delay[i]=delay[i+1];
            } 
            delay[delayTime-1]=previousConsigne;
            //ystem.out.print("delay0:"+delay[0]);
            return delay[0];
        }
        
        //As we know there is a delay between the decision and the actions, we don't want to do the same decision during the amounth of time determined by the delay (this would create a phenomena of amplification which leads to a chaotic behaviour (amplified sinusoidal moovement)
        //In order to avoid this phenomena, we will wait delayTime to take a more effective decision 
        /*public double Delay2(){
            if (timeForNextAction==0) // We count the time when we will act
		{
			timeForNextAction=delayTime;
			return previousConsigne;
		}
		else//Here we don't act, we just decrement our counter
		{
			timeForNextAction--;
			return 0;
		}		
	}*/
        
        public double Delay3(){
            if(threshold>Math.abs(error)){
                previousConsigne=0;
            }
            for(int i = 0; i<delayTime-1;i++){
                delay[i]=delay[i+1];
            } 
            delay[delayTime-1]=previousConsigne;
            //System.out.print("delay0:"+delay[0]+" error:"+error);
            return delay[0];
        }
                
              
}

		