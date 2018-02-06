//Rotation Matrices
float[][] rotationMatrix = new float[3][3];
float[][] alphaMatrix = new float[3][3];
float[][] betaMatrix = new float[3][3];
float[][] gammaMatrix = new float[3][3];


 /**
  *    Description : Rotational Matrix 
  *
  *    @param      : none
  *    @return     : none
  */
  void initRotMatrix(PVector rotation){
    
      /*alphaMatrix[0][0] = cos(gyro.z);
      alphaMatrix[0][1] = -sin(gyro.z);
      alphaMatrix[0][2] = 0;
      alphaMatrix[1][0] = sin(gyro.z);
      alphaMatrix[1][1] = cos(gyro.z);
      alphaMatrix[1][2] = 0;
      alphaMatrix[2][0] = 0;
      alphaMatrix[2][1] = 0;
      alphaMatrix[2][2] = 1;
      
      betaMatrix[0][0] = cos(gyro.y);
      betaMatrix[0][1] = 0;
      betaMatrix[0][2] = sin(gyro.y);
      betaMatrix[1][0] = 0;
      betaMatrix[1][1] = 1;
      betaMatrix[1][2] = 0;
      betaMatrix[2][0] = -sin(gyro.y);
      betaMatrix[2][1] = 0;
      betaMatrix[2][2] = cos(gyro.y);
      
      gammaMatrix[0][0] = 1;
      gammaMatrix[0][1] = 0;
      gammaMatrix[0][2] = 0;
      gammaMatrix[1][0] = 0;
      gammaMatrix[1][1] = cos(gyro.x);
      gammaMatrix[1][2] = -sin(gyro.x);
      gammaMatrix[2][0] = 0;
      gammaMatrix[2][1] = sin(gyro.x);
      gammaMatrix[2][0] = cos(gyro.x);*/
      
      float cx = cos(rotation.x);
      float cy = cos(rotation.y);
      float cz = cos(rotation.z);
      float sx = sin(rotation.x);
      float sy = sin(rotation.y);
      float sz = sin(rotation.z);   
      
      rotationMatrix[0][0] = cz*cy;
      rotationMatrix[1][0] = sz*cy ;
      rotationMatrix[2][0] = -sy;
      rotationMatrix[0][1] = cz*sy*sx - sz*cx;
      rotationMatrix[1][1] = sz*sy*sx + cz*cx;
      rotationMatrix[2][1] = cy*sx;
      rotationMatrix[0][2] = cz*sy*cx + sz*sx;
      rotationMatrix[1][2] = sz*sy*cx - cz*sx;
      rotationMatrix[2][2] = cy*cx;
  }


 /**
  *    Description : Rotational Matrix 
  *
  *    @param      : none
  *    @return     : none
  */
  PVector PVectorRotation(PVector original, float rotation[][]) {
    
    PVector rotated = new PVector(0,0,0);
  
    rotated.x += original.x*rotation[0][0] + original.y*rotation[0][1] + original.z*rotation[0][2];
    rotated.y += original.x*rotation[1][0] + original.y*rotation[1][1] + original.z*rotation[1][2];
    rotated.z += original.x*rotation[2][0] + original.y*rotation[2][1] + original.z*rotation[2][2];
  
    return rotated;
  }