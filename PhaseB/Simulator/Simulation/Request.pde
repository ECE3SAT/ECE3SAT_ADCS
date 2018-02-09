
String requestBuffer;
boolean clearBuffer = false;

void serialSplitCommand(Cube cube, String request)
{
   requestBuffer += request;
   String[] command = requestBuffer.split("\n");
   
   for(int i = 0; i < command.length - 1 ; i ++){
       println(command[i]);
       interpretCommand(command[i]);
   }
}

//////////////////////////////////////////////////////////////////
//                          Syntax                              //
//////////////////////////////////////////////////////////////////
/*

activate magnetorquer X 5       = activate the magnetorquer along X-axis with a 5A intensity
                                 this command will keep the magnetorquer activate until the command desactivate is called
                                 if another activate command is receive, the intensity value will be overwritted
desactivate gyroscope          = desactivate the reading of the gyroscope sensor. When activated, the sensor will send at each loop it's value 
                                 via serial port. If desactivated, it will stop sending data at every loop
*/

void interpretCommand(String command)
{
  String[] commandParts = command.split(" ");
  switch(commandParts[0])
  {
    case "activate":
    //println(command);
      switch(commandParts[1])
      {
        case "magnetorquer":
        try{
          enableMagnetorquer(cube,commandParts[2],Float.parseFloat(commandParts[3]));
        }
        catch(Exception e){}
          break;
        case "gyroscope":
          cube.gyro.setSendingData(true);
          break;
        case "accelerometer":
          cube.accelero.setSendingData(true);
          break;
        case "magnetometer":
          cube.magneto.setSendingData(true);
          break;
        case "sunSensor":
          cube.sunSensor.setSendingData(true);
          break;
      }
      break;
    case "desactivate":
      switch(commandParts[1])
      {
        case "magnetorquer":
          disableMagnetorquer(cube,commandParts[2]);
          break;
        case "gyroscope":
          cube.gyro.setSendingData(false);
          break;
        case "accelerometer":
          cube.accelero.setSendingData(false);
          break;
        case "magnetometer":
          cube.magneto.setSendingData(false);
          break;
        case "sunSensor":
          cube.sunSensor.setSendingData(false);
          break;
      }
      break;
  }
  requestBuffer = requestBuffer.substring(command.length());
}

void writeDataInSerial(Serial serial)
{
  cube.magneto.sendDataToSerial(serial);
}

void enableMagnetorquer(Cube cube, String axis, float intensity)
{
  switch(axis)
  {
    case "X":
      cube.magnetorquerX.changeIntensity(intensity);
      break;
    case "Y":
      cube.magnetorquerY.changeIntensity(intensity);
      break;
    case "Z":
      cube.magnetorquerZ.changeIntensity(intensity);
      break;
  }
}

void disableMagnetorquer(Cube cube, String axis)
{
  switch(axis)
  {
    case "X":
      cube.magnetorquerX.changeIntensity(0);
      break;
    case "Y":
      cube.magnetorquerY.changeIntensity(0);
      break;
    case "Z":
      cube.magnetorquerZ.changeIntensity(0);
      break;
  }
}

void sendCoilData(Cube cube, Serial serial)
{
    byte[] intensityArray = new byte[3];
    intensityArray[0] =  (byte)cube.magnetorquerX.getIntensity();
    intensityArray[1] =  (byte)cube.magnetorquerY.getIntensity();
    intensityArray[2] =  (byte)cube.magnetorquerZ.getIntensity();
    serial.write(intensityArray);
}

void SerialReceive()
{
  
  String serialRequest = "";
  if(serialPort.available() > 0)
  {
    serialRequest = serialPort.readString();
    //println(serialRequest);
  }
  
  serialSplitCommand(cube, serialRequest);
}