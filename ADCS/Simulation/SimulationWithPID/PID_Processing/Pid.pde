

class Pid {
  ////////////Edital parts///////////
  float threshold=5;  // Captors precision
  float precisionRound=100; //the precision round for example 1000 for 3 number after the point (10000 for 4 and so on)
  float maxChangePerIterateration=2000000; //variation max per tic
  int delayTime=5; // delay between captor and actor
  ///////////////////////
  public float sumError, previousMistake, previousConsigne;
  float consigne;
  float varSens=1; //this variable is used to plot the graphic
  float delay[];  //This array will store the successiv decisions
  float KP; //proportionate factor of the PID
  float KD; //derivator factor of the PID
  float KI; //integrator factor of the PID
  float error;



//Constructor of the Pid
  public Pid(float KP, float KD, float KI, float measure) {
    delay= new float[delayTime];

    for (int i = 0; i<delayTime; i++) {
      delay[i]=measure;
    } 
    this.KP=KP;
    this.KD=KD;
    this.KI=KI;
  }
  
//Compute the PID algorithm and return the new consign with respect to the delay//
//This function return the consign that will be applied. To do it calculates the difference between the actual angle and the angle desired. Then with the PID it calculates the consign to apply 
  float calculatePID(float measure) {
    float pid = 0;

    float errorVariation;
    error=consigne-measure;
    if (measure>0) sumError += consigne - measure;
    errorVariation = error - previousMistake;
    pid = KP * error +KI * sumError + KD* errorVariation;
    previousMistake = error;
    pid= (float)(Math.round(pid*precisionRound)/precisionRound); //we round the value to be closer to the reality, we want the precision of the command to be equals to the "precision" constant

    //We limit the possibility of change between 2 command 
    if (Math.abs(previousConsigne-pid)>maxChangePerIterateration)
    {
      if (previousConsigne-pid<0)
      {
        previousConsigne=previousConsigne+maxChangePerIterateration;
      } else 
      {
        previousConsigne=previousConsigne-maxChangePerIterateration;
      }
    } else
    {
      previousConsigne=pid;
    }

    return Delay3();// We take into consideration the delay
  }

  //Returns the decision taken some moment ago //
  //This delay stock the successive decisions in an array and those decisions are then taken successively respecting the delay (which leads to an amplification of decisions and an amplified sinusoid)
  public float Delay3() {
    //if we are close enough to the consigne, we do not act
    if (threshold>=Math.abs(error)) {
      previousConsigne=0;
    }
    //we shift the list of consignes
    for (int i = 0; i<delayTime-1; i++) {
      delay[i]=delay[i+1];
    } 
    //we put our new decision at the end
    delay[delayTime-1]=previousConsigne;
    if(delayTime>2){
    if (abs(delay[delayTime-1])>abs(delay[delayTime-2]))
    {
      varSens=-varSens; //Used to plot
    }
    }
    return delay[0];
  }
  
       //As we know there is a delay between the decision and the actions, we don't want to do the same decision during the amounth of time determined by the delay 
    //In order to avoid this phenomena, we can wait delayTime to take a more effective decision. That is what implement this function 
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
}
