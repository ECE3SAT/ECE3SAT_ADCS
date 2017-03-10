
class Test_PID {
  ////////////Edital parts///////////
  float commandMultiplier = .3;
  float disp=0.2; //It represent the dispersion
  float KP=1; //The proportial factor
  float KI=0; //The integrator factor
  float KD=0; //The derivator factor
  ///////////////////////
  float currentValue, prevValue;  
  int i;
  float pidVal;
  Pid pid;
  float measure;


  //Constructor
  Test_PID() {
    i=0;
    measure=currentValue;
    pidVal=0;
    pid=new Pid(KP, KI, KD, measure);
    pid.consigne=20.;
  }


  // Simulate the varation of the measure. 
  public float systemSimulator(float command) {

    measure=command*commandMultiplier +currentValue;

    measure=measure+disp*pid.varSens;
    prevValue = currentValue;
    currentValue=measure;


    return measure;
  }


  public float myEvaluation(int consignFrom, float Measure) {
    currentValue=degrees(Measure);
    pid.consigne= consignFrom; 
    i++;

    Measure= degrees(Measure);
    pidVal=pid.calculatePID(Measure);
    measure=systemSimulator(pidVal);


    return measure;
  }
}
