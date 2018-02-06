

class Pid {
  ////////////Edital parts///////////
  float threshold=5;  // Captors precision
  float precisionRound=100; //the precision round for example 1000 for 3 number after the point (10000 for 4 and so on)
  float maxChangePerIterateration=2000000; //variation max per tic
  int delayTime=5; // delay between captor and actor
  ///////////////////////
  public float sumError, previousMistake, previousConsigne;
  float consigne;
  float varSens=1;
  float delay[];  
  float KP;
  float KD;
  float KI;
  float error;




  public Pid(float KP, float KD, float KI, float measure) {
    delay= new float[delayTime];

    for (int i = 0; i<delayTime; i++) {
      delay[i]=measure;
    } 
    this.KP=KP;
    this.KD=KD;
    this.KI=KI;
  }


  float calculatePID(float measure) {
    float pid = 0;

    float errorVariation;
    error=consigne-measure;
    sumError += abs(error);
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


  public float Delay3() {
    if (threshold>=Math.abs(error)) {
      previousConsigne=0;
    }
    for (int i = 0; i<delayTime-1; i++) {
      delay[i]=delay[i+1];
    } 
    delay[delayTime-1]=previousConsigne;
    if (delayTime>2) {
      if (abs(delay[delayTime-1])>abs(delay[delayTime-2]))
      {
        varSens=-varSens;
      }
    }
    return delay[0];
  }
}