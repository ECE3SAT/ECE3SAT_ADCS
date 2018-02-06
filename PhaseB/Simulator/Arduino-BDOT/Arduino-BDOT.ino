 #include <string.h>
 
 #define SIZETAB 20
  float K = 0.78;
  int I=1;
  /*******************/
  short int index = 0;

  short int loopTab=0;
  unsigned long timeStart = 0;
  String bufferString;

  int frameRate = 30;
  
  String request = "activate magnetorquer ";

  float magnX = 0;
  float magnY = 0;
  float magnZ = 0;
  
  float prevMagnX = 0;
  float prevMagnY = 0;
  float prevMagnZ = 0;

  float vectorXx = 0;
  float vectorXy = 0;
  float vectorXz = 0;

  float vectorYx = 0;
  float vectorYy = 0;
  float vectorYz = 0;

  float vectorZx = 0;
  float vectorZy = 0;
  float vectorZz = 0;

  float intensityX = 0;
  float intensityY = 0;
  float intensityZ = 0;

  bool receivedDataA = false;  // baseChangedMagnVector
  bool receivedDataX = false; // X magnetorquer
  bool receivedDataY = false; // Y magnetorquer
  bool receivedDataZ = false; // Z magnetorquer
  
void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);

  //we initialize our tabs
  
  
}
char inChar=-1; // Where to store the character read
bool test = HIGH;

const byte numChars = 64;
char receivedChars[numChars];

boolean newData = false;

void loop() {
  // put your main code here, to run repeatedly:
  timeStart = millis();

  index=(index+1)%SIZETAB;
  //get sensor data and put it in our tab

  String bufferLine;
  byte temp[25];
  
  
  recvWithStartEndMarkers();
  showNewData();
  
  char * pch;


  if(receivedChars[0] == 'A') // baseChangedMagnVector
  {
    pch = strtok (receivedChars," ");
    pch = strtok (NULL, " ");
    magnX = atof(pch);
    pch = strtok (NULL, " ");
    magnY = atof(pch);
    pch = strtok (NULL, " ");
    magnZ = atof(pch);
    
    receivedDataA = true;
  }
  else if(receivedChars[0] == 'X') // X magnetorquer
  {
    pch = strtok (receivedChars," ");
    pch = strtok (NULL, " ");
    vectorXx = atof(pch);
    pch = strtok (NULL, " ");
    vectorXy = atof(pch);
    pch = strtok (NULL, " ");
    vectorXz = atof(pch);
    
    receivedDataX = true;
  }
  else if(receivedChars[0] == 'Y') // Y magnetorquer
  {
    pch = strtok (receivedChars," ");
    pch = strtok (NULL, " ");
    vectorYx = atof(pch);
    pch = strtok (NULL, " ");
    vectorYy = atof(pch);
    pch = strtok (NULL, " ");
    vectorYz = atof(pch);
    
    receivedDataY = true;
  }
  else if(receivedChars[0] == 'Z') // Z magnetorquer
  {
    pch = strtok (receivedChars," ");
    pch = strtok (NULL, " ");
    vectorZx = atof(pch);
    pch = strtok (NULL, " ");
    vectorZy = atof(pch);
    pch = strtok (NULL, " ");
    vectorZz = atof(pch);
    
    receivedDataZ = true;
  }


  float derivativeX = 0;
  float derivativeY = 0;
  float derivativeZ = 0;
  
  // Bdot
  //B' = db/dt
  //I = - K B'
  derivativeX = (magnX - prevMagnX) * frameRate * ( - K);
  derivativeY = (magnY - prevMagnY) * frameRate * ( - K);
  derivativeZ = (magnZ - prevMagnZ) * frameRate * ( - K);

  intensityX = derivativeX * vectorXx + derivativeY * vectorXy + derivativeZ * vectorXz;
  intensityY = derivativeX * vectorYx + derivativeY * vectorYy + derivativeZ * vectorYz;
  intensityZ = derivativeX * vectorZx + derivativeY * vectorZy + derivativeZ * vectorZz;
  
  if(receivedDataA && receivedDataX && receivedDataY && receivedDataZ)
  {
    char test[20];
    
    Serial.println(request+"X "+String(intensityX,10));
    Serial.println(request+"Y "+String(intensityY,10));
    Serial.println(request+"Z "+String(intensityZ,10));
  }
  
  prevMagnX = magnX;
  prevMagnY = magnY;
  prevMagnZ = magnZ;

  //delay(30);
}


//Split the data using the special delimiter []
void recvWithStartEndMarkers() {
    static boolean recvInProgress = false;
    static byte ndx = 0;
    char startMarker = '<';
    char endMarker = '>';
    char rc;
 
    while (Serial.available() > 0 && newData == false) {
        rc = Serial.read();

        if (recvInProgress == true) {
            if (rc != endMarker) {
                receivedChars[ndx] = rc;
                ndx++;
                if (ndx >= numChars) {
                    ndx = numChars - 1;
                }
            }
            else {
                receivedChars[ndx] = '\0'; // terminate the string
                recvInProgress = false;
                ndx = 0;
                newData = true;
            }
        }

        else if (rc == startMarker) {
            recvInProgress = true;
        }
    }
}

//print the data received
void showNewData() {
    if (newData == true) {
      //Serial.println(receivedChars);
        newData = false;
    }
}
