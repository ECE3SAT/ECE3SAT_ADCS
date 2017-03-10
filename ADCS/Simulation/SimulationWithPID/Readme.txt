The processing code is the most recent version, it is a more updated and recent code adapted to this software

Details :

For PID_Java:

- Work on netbeans 8.2 or later

editable :
 
Test_PID
	measure=10; initialise the first measure; it's where the algo starts
	commandMultiplier = 0.3; modify the amplification of the commande from PID
	maxIteration = 1000; // edit how many calcul do the code 
	disp=0.2; it's perpetual loose of the system	
	KP=1;
	KI=2;
	KD=0;

Pid2

	threshold=0.1; the default of the captor it represents his precision (when we are between command+threshold and command - threshold we think we are at the command so we chose not to act) 
	precisionRound=10000; //the precision round for example 1000 for 3 number after the point (10000 for 4 and so on)
	maxChangePerIterateration=1; 
	delayTime=5; // delay beetween when the commande is sent and went it's executate 



For PID_Processing

- Work on processing 3.3 or later
- Instal library ControlP5 and tools G4P GUI builder

editable :

 
Test_PID

	measure=10; initialise the first measure; it's where algo start
	commandMultiplier = 0.3; modify the amplification of the commande from PID
	maxIteration = 1000; // edit how many calcul do the code 
	disp=0.2; it's perpetual loose of the system	
	KP=1;
	KI=2;
	KD=0;


Pid2

	threshold=0.1; the default of the captor 
	precisionRound=10000; //the precision round for example 1000 for 3 number after the point (10000 for 4 and so on)
	maxChangePerIterateration=1; 
	delayTime=5; // delay beetween when the commande it's send and went it's executate