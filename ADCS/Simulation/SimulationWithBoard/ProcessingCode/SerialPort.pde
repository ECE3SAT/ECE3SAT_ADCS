// Create object from Serial class
Serial myPort;
Boolean deviceConnected = false;


void serialEvent(Serial myPort) {
  
  String inString = myPort.readString();
  println("-----Serial Entry : -------" + inString);  // Display received string in console
  String[] decoupe = inString.split("/");           //Découpage de la string suivant le caractère "/"
  
  if(decoupe.length == 5) {
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