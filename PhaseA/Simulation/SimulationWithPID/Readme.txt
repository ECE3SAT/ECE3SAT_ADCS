The processing code is the most recent version, it is a more updated and recent code adapted to this software

Details :

For PID_Java:

- Work on netbeans 8.2 or later

editable :
 
Test_PID
	measure : initialise the first measure; it's where the algo starts
	commandMultiplier : modify the amplification of the commande from PID
	maxIteration : edit how many calcul do the code 
	disp : it is the perpetual loose of the system	
	KP; : proportionate factor of the PID
	KI : integrator factor of the PID
	KD : derivator factor of the PID

Pid2

	threshold : the default of the captor it represents his precision (when we are between command+threshold and command - threshold we think we are at the command so we chose not to act) 
	precisionRound :the precision round for example 1000 for 3 number after the point (10000 for 4 and so on)
	maxChangePerIterateration : we can limit the change possible between 2 iterations 
	delayTime :  delay beetween when the commande is sent and went it's executate 

/////////////////////////////////////////////////////////////////////////////////////////////////////////

For PID_Processing

- Work on processing 3.3 or later

To use it :
- Double click on one of the processing file
- Say yes when they ask you to create a folder
- Put the all the files inside
- Instal library ControlP5 and tools G4P GUI builder (tool->add a tool->libraries->find controlP5->install then tools->find G4P GUI builder->install)
- Launch it 

editable :

 
Test_PID

	measure : initialise the first measure; it's where algo start
	commandMultiplier : modify the amplification of the commande from PID
	maxIteration : edit how many calcul do the code 
	disp : it is the perpetual loose of the system	
	KP : proportionate factor of the PID
	KI : integrator factor of the PID
	KD : derivator factor of the PID


Pid

	threshold : the default of the captor it represents his precision (when we are between command+threshold and command - threshold we think we are at the command so we chose not to act) 
	precisionRound :the precision round for example 1000 for 3 number after the point (10000 for 4 and so on)
	maxChangePerIterateration : we can limit the change possible between 2 iterations 
	delayTime :  delay beetween when the commande is sent and went it's executate 
