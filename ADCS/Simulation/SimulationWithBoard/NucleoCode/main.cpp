/**
 ******************************************************************************
 * @file    main.cpp
 * @author  Gael Guegan
 * @version V0.0.1
 * @date    06-April-2017
 * @brief   Simple Example application for using the X_NUCLEO_IKS01A1 
 *          MEMS Inertial & Environmental Sensor Nucleo expansion board.
 ******************************************************************************
**/ 

/* Includes */
#include "mbed.h"
#include "x_nucleo_iks01a1.h"

/* Instantiate the expansion board */
static X_NUCLEO_IKS01A1 *mems_expansion_board = X_NUCLEO_IKS01A1::Instance(D14, D15);

/* Retrieve the composing elements of the expansion board */
static GyroSensor *gyroscope = mems_expansion_board->GetGyroscope();
static MotionSensor *accelerometer = mems_expansion_board->GetAccelerometer();
static MagneticSensor *magnetometer = mems_expansion_board->magnetometer;

Serial pc(SERIAL_TX, SERIAL_RX);

DigitalOut myled(LED2);

/* Simple main function */
int main() {
  pc.baud(300000);
  int32_t axes[3];
  
  while(1) {
      
    myled=!myled;

    magnetometer->Get_M_Axes(axes);
    pc.printf("m/%6ld/%6ld/%6ld/  \r\n", axes[0], axes[1], axes[2]);    //LIS3MDL [mag/mgauss]

    accelerometer->Get_X_Axes(axes);
    pc.printf("a/%6ld/%6ld/%6ld/  \r\n", axes[0], axes[1], axes[2]);    //LSM6DS0 [acc/mg]

    gyroscope->Get_G_Axes(axes);
    pc.printf("g/%6ld/%6ld/%6ld/  \r\n", axes[0], axes[1], axes[2]);    //LSM6DS0 [gyro/mdps]
    
  }
}
