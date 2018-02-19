// Pin positions
#define FET_PA_1 (3)
#define FET_NB_1 (2)
#define FET_NA_1 (4)
#define FET_PB_1 (5)
#define FET_PA_2 (6)
#define FET_NB_2 (7)
#define FET_NA_2 (8)
#define FET_PB_2 (9)
#define FET_PA_3 (10)
#define FET_NB_3 (A1)
#define FET_NA_3 (A0)
#define FET_PB_3 (11)

// Maximum autorized delta between previous
// value and current (in gauss)
#define PARAMETER_MAX_DELTA       1.0f

// Input voltage in volts, for an accurate
// calculation of the PWM values
#define PARAMETER_INPUT_VOLTAGE   30.0f
#define PARAMETER_COIL_RESISTANCE 23.0f

// Physical calcultation parameters
#define PARAMETER_MU_0            0.0126f
#define PARAMETER_N               80.0f
#define PARAMETER_R               0.4f
#define PARAMETER_CONSTANT        0.716f
#define PARAMETER_MIN_I 0.0f
#define PARAMETER_MAX_I (PARAMETER_INPUT_VOLTAGE / PARAMETER_COIL_RESISTANCE)
#define PARAMETER_MAX_GAUSS ( (PARAMETER_CONSTANT * PARAMETER_N * PARAMETER_MU_0 * PARAMETER_MAX_I ) / PARAMETER_R )

//Variables
float previousXField=0,previousYField=0,previousZField=0;

//0=constant, 1=triangle, 2=field matrix
#define HELMHOLTS_MODE 2

// SETUP : 
const unsigned long fieldDelay = 2000;
const int fieldMatrixSize = 25;
const float fieldMatrix[][3] = { 
  {0.0f         ,0.0f         ,0.0f         },
  {0.647047613f ,0.647047613f ,0.647047613f },
  {1.25f        ,1.25f        ,1.25f        },
  {1.767766953f ,1.767766953f ,1.767766953f },
  {2.165063509f ,2.165063509f ,2.165063509f },
  {2.414814566f ,2.414814566f ,2.414814566f },
  {2.5f         ,2.5f         ,2.5f         },
  {2.414814566f ,2.414814566f ,2.414814566f },
  {2.165063509f ,2.165063509f ,2.165063509f },
  {1.767766953f ,1.767766953f ,1.767766953f },
  {1.25f        ,1.25f        ,1.25f        },
  {0.647047613f ,0.647047613f ,0.647047613f },
  {3.06287E-16f ,3.06287E-16f ,3.06287E-16f },
  {-0.647047613f,-0.647047613f,-0.647047613f},
  {-1.25f       ,-1.25f       ,-1.25f       },
  {-1.767766953f,-1.767766953f,-1.767766953f},
  {-2.165063509f,-2.165063509f,-2.165063509f},
  {-2.414814566f,-2.414814566f,-2.414814566f},
  {-2.5f        ,-2.5f        ,-2.5f        },
  {-2.414814566f,-2.414814566f,-2.414814566f},
  {-2.165063509f,-2.165063509f,-2.165063509f},
  {-1.767766953f,-1.767766953f,-1.767766953f},
  {-1.25f       ,-1.25f       ,-1.25f       },
  {-0.647047613f,-0.647047613f,-0.647047613f},
  {0.0f         ,0.0f         ,0.0f         }
};

void setup() {
  coilSetup();
}

void loop() {
  #if HELMHOLTS_MODE == 0
        coilXField(PARAMETER_MAX_GAUSS);
  #elif HELMHOLTS_MODE == 1
      for(float i = -PARAMETER_MAX_GAUSS; i < PARAMETER_MAX_GAUSS ; i += 0.05f){
        coilXField(i);
        delay(fieldDelay);
      }
      for(float i = PARAMETER_MAX_GAUSS; i > -PARAMETER_MAX_GAUSS ; i -= 0.05f){
        coilXField(i);
        delay(fieldDelay);
      }
    #elif HELMHOLTS_MODE == 2
      for(int i = 0; i < fieldMatrixSize ; i ++){
        coilXField(fieldMatrix[i][0]);
        coilYField(fieldMatrix[i][1]);
        coilZField(fieldMatrix[i][2]);
        delay(fieldDelay);
      }
  #endif
}

//High level coil control
void coilXField(float gauss){
  if (fabsf(gauss-previousXField) > PARAMETER_MAX_DELTA) return;
  previousXField=gauss;
  coilX(fieldToPWM(gauss),gauss>0);
}
void coilYField(float gauss){
  if (fabsf(gauss-previousYField) > PARAMETER_MAX_DELTA) return;
  previousYField=gauss;
  coilY(fieldToPWM(gauss),gauss>0);
}
void coilZField(float gauss){
  if (fabsf(gauss-previousZField) > PARAMETER_MAX_DELTA) return;
  previousZField=gauss;
  coilZ(fieldToPWM(gauss),gauss>0);
}
uint8_t fieldToPWM(float gauss){
  if(fabsf(gauss)>PARAMETER_MAX_GAUSS) gauss = PARAMETER_MAX_GAUSS;
  return (uint8_t)mapfloat(PARAMETER_R * fabsf(gauss) /( PARAMETER_CONSTANT * PARAMETER_N * PARAMETER_MU_0 ),PARAMETER_MIN_I,PARAMETER_MAX_I,0.0f,255.0f);
}

//LOW LEVEL COIL CONTROL
void coilSetup(){
  pinMode(FET_PA_1,OUTPUT);
  pinMode(FET_NB_1,OUTPUT);
  pinMode(FET_NA_1,OUTPUT);
  pinMode(FET_PB_1,OUTPUT);
  pinMode(FET_PA_2,OUTPUT);
  pinMode(FET_NB_2,OUTPUT);
  pinMode(FET_NA_2,OUTPUT);
  pinMode(FET_PB_2,OUTPUT);
  pinMode(FET_PA_3,OUTPUT);
  pinMode(FET_NB_3,OUTPUT);
  pinMode(FET_NA_3,OUTPUT);
  pinMode(FET_PB_3,OUTPUT);

  digitalWrite(FET_PA_1,LOW);
  digitalWrite(FET_NB_1,LOW);
  digitalWrite(FET_NA_1,LOW);
  digitalWrite(FET_PB_1,LOW);
  digitalWrite(FET_PA_2,LOW);
  digitalWrite(FET_NB_2,LOW);
  digitalWrite(FET_NA_2,LOW);
  digitalWrite(FET_PB_2,LOW);
  digitalWrite(FET_PA_3,LOW);
  digitalWrite(FET_NB_3,LOW);
  digitalWrite(FET_NA_3,LOW);
  digitalWrite(FET_PB_3,LOW);
}
void coilX(byte duty, byte dir){
  if(dir){
    digitalWrite(FET_NA_1,HIGH);
    digitalWrite(FET_NB_1,LOW);
    analogWrite(FET_PA_1,duty);
    digitalWrite(FET_PB_1,LOW);
  }

  else{
    digitalWrite(FET_NB_1,HIGH);
    digitalWrite(FET_NA_1,LOW);
    analogWrite(FET_PB_1,duty);
    digitalWrite(FET_PA_1,LOW);
  }
}
void coilY(byte duty, byte dir){
  if(dir){
    digitalWrite(FET_NA_2,HIGH);
    digitalWrite(FET_NB_2,LOW);
    analogWrite(FET_PA_2,duty);
    digitalWrite(FET_PB_2,LOW);
  }

  else{
    digitalWrite(FET_NB_2,HIGH);
    digitalWrite(FET_NA_2,LOW);
    analogWrite(FET_PB_2,duty);
    digitalWrite(FET_PA_2,LOW);
  }
}
void coilZ(byte duty, byte dir){
  if(dir){
    digitalWrite(FET_NA_3,HIGH);
    digitalWrite(FET_NB_3,LOW);
    analogWrite(FET_PA_3,duty);
    digitalWrite(FET_PB_3,LOW);
  }

  else{
    digitalWrite(FET_NB_3,HIGH);
    digitalWrite(FET_NA_3,LOW);
    analogWrite(FET_PB_3,duty);
    digitalWrite(FET_PA_3,LOW);
  }
}

float mapfloat(float x, float in_min, float in_max, float out_min, float out_max) {
  if(x<=in_min) return out_min;
  else if (x>=in_max) return out_max;
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

