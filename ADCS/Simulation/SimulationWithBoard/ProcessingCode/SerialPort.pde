// Create object from Serial class
Serial myPort;
Boolean deviceConnected = false;
/**
 *  Description : Serial Initialization
 *
 *  @param      : none
 */
void serialInit(){
  if(Serial.list().length >= 1) {
    myPort = new Serial(this, Serial.list()[0], 9600);
    myPort.bufferUntil('\r');
    deviceConnected = true;
  }
  else {
    deviceConnected = false;
    println("PORT NOT FOUND !!!" + "\n" + "Connect Your Device");
  }
}

/**
 *  Description   : Serial event
 *
 *  @param myPort : Serial Port to use
 *  @return       : none
 */
void serialEvent(Serial myPort) {
  
  String inString = myPort.readString();
  println("----- Serial Entry : -------" + inString);  // Display received string in console
  String[] decoupe = inString.split("/");             //Découpage de la string suivant le caractère "/"
  
  if(decoupe.length == 5) { // To discard the first string received that is likely truncated
    //Récupère magnetometer string
    if(match(inString,"m") != null)
      cube.magnetoEvent(Float.parseFloat(decoupe[1].trim()), Float.parseFloat(decoupe[2].trim()), Float.parseFloat(decoupe[3].trim()));
    
    //Récupère accelerometer string
    else if(match(inString,"a") != null)
      cube.acceleroEvent(Float.parseFloat(decoupe[1].trim()), Float.parseFloat(decoupe[2].trim()), Float.parseFloat(decoupe[3].trim()));
    
    //Récupère gyrometer string
    else if(match(inString,"g") != null)
      cube.gyroEvent(Float.parseFloat(decoupe[1].trim()), Float.parseFloat(decoupe[2].trim()), Float.parseFloat(decoupe[3].trim()));
  }

}