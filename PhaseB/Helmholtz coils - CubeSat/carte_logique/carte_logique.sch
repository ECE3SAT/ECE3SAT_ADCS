EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Conn_01x05 J3
U 1 1 5A6B1AE0
P 5500 1300
F 0 "J3" H 5580 1342 50  0000 L CNN
F 1 "Conn_01x05" H 5580 1251 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 5500 1300 50  0001 C CNN
F 3 "~" H 5500 1300 50  0001 C CNN
	1    5500 1300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05 J4
U 1 1 5A6B1B32
P 5500 1950
F 0 "J4" H 5580 1992 50  0000 L CNN
F 1 "Conn_01x05" H 5580 1901 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 5500 1950 50  0001 C CNN
F 3 "~" H 5500 1950 50  0001 C CNN
	1    5500 1950
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05 J5
U 1 1 5A6B1B54
P 5500 2550
F 0 "J5" H 5580 2592 50  0000 L CNN
F 1 "Conn_01x05" H 5580 2501 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 5500 2550 50  0001 C CNN
F 3 "~" H 5500 2550 50  0001 C CNN
	1    5500 2550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05 J8
U 1 1 5A6B1B76
P 6400 2550
F 0 "J8" H 6480 2592 50  0000 L CNN
F 1 "Conn_01x05" H 6480 2501 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 6400 2550 50  0001 C CNN
F 3 "~" H 6400 2550 50  0001 C CNN
	1    6400 2550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05 J7
U 1 1 5A6B1B9F
P 6400 1950
F 0 "J7" H 6480 1992 50  0000 L CNN
F 1 "Conn_01x05" H 6480 1901 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 6400 1950 50  0001 C CNN
F 3 "~" H 6400 1950 50  0001 C CNN
	1    6400 1950
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x05 J6
U 1 1 5A6B1BC1
P 6400 1300
F 0 "J6" H 6480 1342 50  0000 L CNN
F 1 "Conn_01x05" H 6480 1251 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 6400 1300 50  0001 C CNN
F 3 "~" H 6400 1300 50  0001 C CNN
	1    6400 1300
	1    0    0    -1  
$EndComp
$Comp
L device:R R1
U 1 1 5A6B1C65
P 4700 1200
F 0 "R1" H 4770 1246 50  0000 L CNN
F 1 "100" H 4770 1155 50  0000 L CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4630 1200 50  0001 C CNN
F 3 "" H 4700 1200 50  0001 C CNN
	1    4700 1200
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x02 J1
U 1 1 5A6B1D88
P 4800 3050
F 0 "J1" H 4880 3042 50  0000 L CNN
F 1 "Conn_01x02" H 4880 2951 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 4800 3050 50  0001 C CNN
F 3 "~" H 4800 3050 50  0001 C CNN
	1    4800 3050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x15 J9
U 1 1 5A6B2C85
P 9450 1500
F 0 "J9" H 9530 1542 50  0000 L CNN
F 1 "Conn_01x15" H 9530 1451 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x15_Pitch2.54mm" H 9450 1500 50  0001 C CNN
F 3 "~" H 9450 1500 50  0001 C CNN
	1    9450 1500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x15 J15
U 1 1 5A6B3183
P 10600 1500
F 0 "J15" H 10680 1542 50  0000 L CNN
F 1 "Conn_01x15" H 10680 1451 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x15_Pitch2.54mm" H 10600 1500 50  0001 C CNN
F 3 "~" H 10600 1500 50  0001 C CNN
	1    10600 1500
	1    0    0    -1  
$EndComp
Text Label 10200 800  0    50   ~ 0
VIN
Wire Wire Line
	10200 800  10400 800 
Text Label 10200 900  0    50   ~ 0
GND1
Text Label 10200 1000 0    50   ~ 0
RST1
Text Label 10200 1100 0    50   ~ 0
5V
Text Label 10200 1200 0    50   ~ 0
A7
Text Label 10200 1300 0    50   ~ 0
A6
Text Label 10200 1400 0    50   ~ 0
A5
Text Label 10200 1500 0    50   ~ 0
A4
Text Label 10200 1600 0    50   ~ 0
A3
Text Label 10200 1700 0    50   ~ 0
A2
Text Label 10200 1800 0    50   ~ 0
A1
Text Label 10200 1900 0    50   ~ 0
A0
Text Label 10200 2000 0    50   ~ 0
REF
Text Label 10200 2100 0    50   ~ 0
3.3V
Text Label 10200 2200 0    50   ~ 0
D13
Wire Wire Line
	10200 900  10400 900 
Wire Wire Line
	10400 1000 10200 1000
Wire Wire Line
	10200 1100 10400 1100
Wire Wire Line
	10400 1200 10200 1200
Wire Wire Line
	10200 1300 10400 1300
Wire Wire Line
	10400 1400 10200 1400
Wire Wire Line
	10200 1500 10400 1500
Wire Wire Line
	10400 1600 10200 1600
Wire Wire Line
	10200 1700 10400 1700
Wire Wire Line
	10400 1800 10200 1800
Wire Wire Line
	10200 1900 10400 1900
Wire Wire Line
	10400 2000 10200 2000
Wire Wire Line
	10200 2100 10400 2100
Wire Wire Line
	10400 2200 10200 2200
Text Label 9150 800  0    50   ~ 0
TX
Text Label 9150 900  0    50   ~ 0
RX
Text Label 9150 1000 0    50   ~ 0
RST0
Text Label 9150 1100 0    50   ~ 0
GND0
Text Label 9150 1200 0    50   ~ 0
D2
Text Label 9150 1300 0    50   ~ 0
D3
Text Label 9150 1400 0    50   ~ 0
D4
Text Label 9150 1500 0    50   ~ 0
D5
Text Label 9150 1600 0    50   ~ 0
D6
Text Label 9150 1700 0    50   ~ 0
D7
Text Label 9150 1800 0    50   ~ 0
D8
Text Label 9150 1900 0    50   ~ 0
D9
Text Label 9150 2000 0    50   ~ 0
D10
Text Label 9150 2100 0    50   ~ 0
D11
Text Label 9150 2200 0    50   ~ 0
D12
Wire Wire Line
	9150 800  9250 800 
Wire Wire Line
	9250 900  9150 900 
Wire Wire Line
	9150 1000 9250 1000
Wire Wire Line
	9250 1100 9150 1100
Wire Wire Line
	9150 1200 9250 1200
Wire Wire Line
	9250 1300 9150 1300
Wire Wire Line
	9150 1400 9250 1400
Wire Wire Line
	9250 1500 9150 1500
Wire Wire Line
	9150 1600 9250 1600
Wire Wire Line
	9250 1700 9150 1700
Wire Wire Line
	9150 1800 9250 1800
Wire Wire Line
	9250 1900 9150 1900
Wire Wire Line
	9150 2000 9250 2000
Wire Wire Line
	9250 2100 9150 2100
Wire Wire Line
	9150 2200 9250 2200
Text Label 2550 1350 0    50   ~ 0
RX
Text Label 2550 1450 0    50   ~ 0
TX
Text Label 2550 1550 0    50   ~ 0
D2
Text Label 2550 1650 0    50   ~ 0
D3
Text Label 2550 1750 0    50   ~ 0
D4
Text Label 2550 1850 0    50   ~ 0
D5
Text Label 2550 1950 0    50   ~ 0
D6
Text Label 2550 2050 0    50   ~ 0
D7
Text Label 2550 2150 0    50   ~ 0
D8
Text Label 2550 2250 0    50   ~ 0
D9
Text Label 2550 2350 0    50   ~ 0
D10
Text Label 2550 2450 0    50   ~ 0
D11
Text Label 2550 2550 0    50   ~ 0
D12
Text Label 2550 2650 0    50   ~ 0
D13
Text Label 3350 800  0    50   ~ 0
3.3V
Text Label 3450 800  0    50   ~ 0
5V
Text Label 3250 3250 0    50   ~ 0
GND0
Text Label 3350 3250 0    50   ~ 0
GND1
Text Label 3850 1950 0    50   ~ 0
A0
Text Label 3850 2050 0    50   ~ 0
A1
Text Label 3850 2150 0    50   ~ 0
A2
Text Label 3850 2250 0    50   ~ 0
A3
Text Label 3850 2350 0    50   ~ 0
A4
Text Label 3850 2450 0    50   ~ 0
A5
Text Label 3850 2550 0    50   ~ 0
A6
Text Label 3850 2650 0    50   ~ 0
A7
Text Label 3850 1750 0    50   ~ 0
REF
Text Label 3850 1450 0    50   ~ 0
RST0
Text Label 3850 1350 0    50   ~ 0
RST1
Wire Wire Line
	3350 950  3350 800 
Wire Wire Line
	3450 800  3450 850 
Wire Wire Line
	3850 1350 3750 1350
Wire Wire Line
	3750 1450 3850 1450
Wire Wire Line
	3850 1750 3750 1750
Wire Wire Line
	3750 1950 3850 1950
Wire Wire Line
	3850 2050 3750 2050
Wire Wire Line
	3750 2150 3850 2150
Wire Wire Line
	3850 2250 3750 2250
Wire Wire Line
	3750 2350 3850 2350
Wire Wire Line
	3850 2450 3750 2450
Wire Wire Line
	3750 2550 3850 2550
Wire Wire Line
	3850 2650 3750 2650
Wire Wire Line
	3350 3250 3350 2950
Wire Wire Line
	2750 2650 2550 2650
Wire Wire Line
	2550 2550 2750 2550
Wire Wire Line
	2750 2450 2550 2450
Wire Wire Line
	2550 2350 2750 2350
Wire Wire Line
	2750 2250 2550 2250
Wire Wire Line
	2550 2150 2750 2150
Wire Wire Line
	2750 2050 2550 2050
Wire Wire Line
	2550 1950 2750 1950
Wire Wire Line
	2750 1850 2550 1850
Wire Wire Line
	2550 1750 2750 1750
Wire Wire Line
	2750 1650 2550 1650
Wire Wire Line
	2550 1550 2750 1550
Wire Wire Line
	2750 1450 2550 1450
Wire Wire Line
	2550 1350 2750 1350
Text Label 5050 1300 0    50   ~ 0
GND
Text Label 5050 1950 0    50   ~ 0
GND
Text Label 5100 2550 0    50   ~ 0
GND
Text Label 5050 1100 0    50   ~ 0
D3
Text Label 4300 1200 0    50   ~ 0
D2
Text Label 4300 1400 0    50   ~ 0
D4
Text Label 5050 1500 0    50   ~ 0
D5
Text Label 5050 1750 0    50   ~ 0
D6
Text Label 4300 1850 0    50   ~ 0
D7
Text Label 4300 2050 0    50   ~ 0
D8
Text Label 5050 2150 0    50   ~ 0
D9
Text Label 5050 2350 0    50   ~ 0
D10
Text Label 4300 2450 0    50   ~ 0
A1
Text Label 4300 2650 0    50   ~ 0
A0
Text Label 5050 2750 0    50   ~ 0
D11
Wire Wire Line
	5300 1100 5050 1100
Wire Wire Line
	5300 1300 5050 1300
Wire Wire Line
	5300 1500 5050 1500
Wire Wire Line
	5050 1750 5300 1750
Wire Wire Line
	4550 1850 4300 1850
Wire Wire Line
	5050 1950 5300 1950
Wire Wire Line
	4550 2050 4300 2050
Wire Wire Line
	5050 2150 5300 2150
Wire Wire Line
	5300 2350 5050 2350
Wire Wire Line
	4300 2450 4550 2450
Wire Wire Line
	5300 2550 5100 2550
Wire Wire Line
	4300 2650 4550 2650
Wire Wire Line
	5050 2750 5300 2750
Wire Wire Line
	5300 1100 6200 1100
Connection ~ 5300 1100
Wire Wire Line
	6200 1200 5300 1200
Wire Wire Line
	5300 1300 6200 1300
Connection ~ 5300 1300
Wire Wire Line
	6200 1400 5300 1400
Wire Wire Line
	5300 1500 6200 1500
Connection ~ 5300 1500
Wire Wire Line
	5300 1850 6200 1850
Wire Wire Line
	6200 1950 5300 1950
Connection ~ 5300 1950
Wire Wire Line
	5300 2050 6200 2050
Wire Wire Line
	6200 2150 5300 2150
Connection ~ 5300 2150
Wire Wire Line
	5300 2350 6200 2350
Connection ~ 5300 2350
Wire Wire Line
	6200 2450 5300 2450
Wire Wire Line
	5300 2550 6200 2550
Connection ~ 5300 2550
Wire Wire Line
	5300 2650 6200 2650
Wire Wire Line
	6200 2750 5300 2750
Connection ~ 5300 2750
$Comp
L Connector:Conn_01x02 J2
U 1 1 5A736967
P 7650 1000
F 0 "J2" H 7730 992 50  0000 L CNN
F 1 "Conn_01x02" H 7730 901 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 7650 1000 50  0001 C CNN
F 3 "~" H 7650 1000 50  0001 C CNN
	1    7650 1000
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02 J10
U 1 1 5A7369C7
P 7650 1250
F 0 "J10" H 7730 1242 50  0000 L CNN
F 1 "Conn_01x02" H 7730 1151 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 7650 1250 50  0001 C CNN
F 3 "~" H 7650 1250 50  0001 C CNN
	1    7650 1250
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02 J11
U 1 1 5A7369FA
P 7650 1700
F 0 "J11" H 7730 1692 50  0000 L CNN
F 1 "Conn_01x02" H 7730 1601 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 7650 1700 50  0001 C CNN
F 3 "~" H 7650 1700 50  0001 C CNN
	1    7650 1700
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02 J12
U 1 1 5A736A39
P 7650 1950
F 0 "J12" H 7730 1942 50  0000 L CNN
F 1 "Conn_01x02" H 7730 1851 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 7650 1950 50  0001 C CNN
F 3 "~" H 7650 1950 50  0001 C CNN
	1    7650 1950
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02 J13
U 1 1 5A736A70
P 7650 2350
F 0 "J13" H 7730 2342 50  0000 L CNN
F 1 "Conn_01x02" H 7730 2251 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 7650 2350 50  0001 C CNN
F 3 "~" H 7650 2350 50  0001 C CNN
	1    7650 2350
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02 J14
U 1 1 5A736AB0
P 7650 2600
F 0 "J14" H 7730 2592 50  0000 L CNN
F 1 "Conn_01x02" H 7730 2501 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 7650 2600 50  0001 C CNN
F 3 "~" H 7650 2600 50  0001 C CNN
	1    7650 2600
	1    0    0    -1  
$EndComp
$Comp
L device:R R7
U 1 1 5A736B25
P 7150 1000
F 0 "R7" V 6943 1000 50  0000 C CNN
F 1 "R" V 7034 1000 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7080 1000 50  0001 C CNN
F 3 "" H 7150 1000 50  0001 C CNN
	1    7150 1000
	0    1    1    0   
$EndComp
$Comp
L device:R R8
U 1 1 5A74394C
P 7150 1250
F 0 "R8" V 6943 1250 50  0000 C CNN
F 1 "R" V 7034 1250 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7080 1250 50  0001 C CNN
F 3 "" H 7150 1250 50  0001 C CNN
	1    7150 1250
	0    1    1    0   
$EndComp
$Comp
L device:R R9
U 1 1 5A74398B
P 7200 1700
F 0 "R9" V 6993 1700 50  0000 C CNN
F 1 "R" V 7084 1700 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7130 1700 50  0001 C CNN
F 3 "" H 7200 1700 50  0001 C CNN
	1    7200 1700
	0    1    1    0   
$EndComp
$Comp
L device:R R10
U 1 1 5A7439D1
P 7200 1950
F 0 "R10" V 6993 1950 50  0000 C CNN
F 1 "R" V 7084 1950 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7130 1950 50  0001 C CNN
F 3 "" H 7200 1950 50  0001 C CNN
	1    7200 1950
	0    1    1    0   
$EndComp
$Comp
L device:R R11
U 1 1 5A743A18
P 7200 2350
F 0 "R11" V 6993 2350 50  0000 C CNN
F 1 "R" V 7084 2350 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7130 2350 50  0001 C CNN
F 3 "" H 7200 2350 50  0001 C CNN
	1    7200 2350
	0    1    1    0   
$EndComp
$Comp
L device:R R12
U 1 1 5A743A60
P 7200 2600
F 0 "R12" V 6993 2600 50  0000 C CNN
F 1 "R" V 7084 2600 50  0000 C CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 7130 2600 50  0001 C CNN
F 3 "" H 7200 2600 50  0001 C CNN
	1    7200 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	7450 1000 7300 1000
Wire Wire Line
	7000 1000 6200 1000
Wire Wire Line
	6200 1000 6200 1100
Connection ~ 6200 1100
Wire Wire Line
	7300 1250 7450 1250
Wire Wire Line
	6200 1500 7000 1500
Wire Wire Line
	7000 1500 7000 1250
Connection ~ 6200 1500
Wire Wire Line
	6200 2150 7050 2150
Wire Wire Line
	7050 2150 7050 1950
Connection ~ 6200 2150
Wire Wire Line
	6200 2350 7050 2350
Connection ~ 6200 2350
Wire Wire Line
	6200 2750 7050 2750
Wire Wire Line
	7050 2750 7050 2600
Connection ~ 6200 2750
Wire Wire Line
	7350 2600 7450 2600
Wire Wire Line
	7350 2350 7450 2350
Wire Wire Line
	7350 1950 7450 1950
Wire Wire Line
	7350 1700 7450 1700
Text Label 7300 1100 0    50   ~ 0
GND
Text Label 7300 1350 0    50   ~ 0
GND
Text Label 7300 1800 0    50   ~ 0
GND
Text Label 7300 2050 0    50   ~ 0
GND
Text Label 7300 2450 0    50   ~ 0
GND
Text Label 7300 2700 0    50   ~ 0
GND
Wire Wire Line
	7450 1800 7300 1800
Wire Wire Line
	7300 2050 7450 2050
Wire Wire Line
	7300 1350 7450 1350
Wire Wire Line
	7450 1100 7300 1100
Wire Wire Line
	7300 2450 7450 2450
Wire Wire Line
	7300 2700 7450 2700
Wire Wire Line
	4300 1400 4550 1400
Wire Wire Line
	4300 1200 4550 1200
$Comp
L device:R R2
U 1 1 5A7FBF56
P 4700 1400
F 0 "R2" H 4770 1446 50  0000 L CNN
F 1 "100" H 4770 1355 50  0000 L CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4630 1400 50  0001 C CNN
F 3 "" H 4700 1400 50  0001 C CNN
	1    4700 1400
	0    -1   -1   0   
$EndComp
$Comp
L device:R R3
U 1 1 5A7FBFA2
P 4700 1850
F 0 "R3" H 4770 1896 50  0000 L CNN
F 1 "100" H 4770 1805 50  0000 L CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4630 1850 50  0001 C CNN
F 3 "" H 4700 1850 50  0001 C CNN
	1    4700 1850
	0    -1   -1   0   
$EndComp
$Comp
L device:R R4
U 1 1 5A7FBFF1
P 4700 2050
F 0 "R4" H 4770 2096 50  0000 L CNN
F 1 "100" H 4770 2005 50  0000 L CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4630 2050 50  0001 C CNN
F 3 "" H 4700 2050 50  0001 C CNN
	1    4700 2050
	0    -1   -1   0   
$EndComp
$Comp
L device:R R5
U 1 1 5A7FC03D
P 4700 2450
F 0 "R5" H 4770 2496 50  0000 L CNN
F 1 "100" H 4770 2405 50  0000 L CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4630 2450 50  0001 C CNN
F 3 "" H 4700 2450 50  0001 C CNN
	1    4700 2450
	0    -1   -1   0   
$EndComp
$Comp
L device:R R6
U 1 1 5A7FC091
P 4700 2650
F 0 "R6" H 4770 2696 50  0000 L CNN
F 1 "100" H 4770 2605 50  0000 L CNN
F 2 "Resistors_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P5.08mm_Horizontal" V 4630 2650 50  0001 C CNN
F 3 "" H 4700 2650 50  0001 C CNN
	1    4700 2650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4850 2650 5300 2650
Connection ~ 5300 2650
Wire Wire Line
	5300 2450 4850 2450
Connection ~ 5300 2450
Wire Wire Line
	4850 2050 5300 2050
Connection ~ 5300 2050
Wire Wire Line
	5300 1850 4850 1850
Connection ~ 5300 1850
Wire Wire Line
	4850 1400 5300 1400
Connection ~ 5300 1400
Wire Wire Line
	5300 1200 4850 1200
Connection ~ 5300 1200
Text Label 4350 3050 0    50   ~ 0
5V
Text Label 4350 3150 0    50   ~ 0
GND
Wire Wire Line
	4350 3150 4600 3150
Wire Wire Line
	4600 3050 4350 3050
$Comp
L power:GND #PWR01
U 1 1 5A877E25
P 7450 3050
F 0 "#PWR01" H 7450 2800 50  0001 C CNN
F 1 "GND" H 7455 2877 50  0000 C CNN
F 2 "" H 7450 3050 50  0001 C CNN
F 3 "" H 7450 3050 50  0001 C CNN
	1    7450 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 3050 7450 2700
Connection ~ 7450 2700
Wire Wire Line
	3750 850  3450 850 
Connection ~ 3450 850 
Wire Wire Line
	3450 850  3450 950 
$Comp
L power:VCC #PWR02
U 1 1 5A88929D
P 3750 850
F 0 "#PWR02" H 3750 700 50  0001 C CNN
F 1 "VCC" H 3767 1023 50  0000 C CNN
F 2 "" H 3750 850 50  0001 C CNN
F 3 "" H 3750 850 50  0001 C CNN
	1    3750 850 
	1    0    0    -1  
$EndComp
$Comp
L modules:Arduino_Nano_v3.x A1
U 1 1 5A6B19EE
P 3250 1950
F 0 "A1" H 3250 864 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 3250 773 50  0000 C CNN
F 2 "Modules:Arduino_Nano" H 3400 1000 50  0001 L CNN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 3250 950 50  0001 C CNN
	1    3250 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5A969127
P 3250 3300
F 0 "#PWR03" H 3250 3050 50  0001 C CNN
F 1 "GND" H 3255 3127 50  0000 C CNN
F 2 "" H 3250 3300 50  0001 C CNN
F 3 "" H 3250 3300 50  0001 C CNN
	1    3250 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3250 3250 3250
Wire Wire Line
	3250 2950 3250 3250
Connection ~ 3250 3250
Wire Wire Line
	3250 3250 3250 3300
Wire Wire Line
	5600 850  3750 850 
Connection ~ 3750 850 
Wire Wire Line
	7050 1700 6200 1700
Wire Wire Line
	6200 1700 6200 1750
Wire Wire Line
	6200 1750 5300 1750
Connection ~ 6200 1750
Connection ~ 5300 1750
Text Label 3150 850  0    50   ~ 0
VIN
Wire Wire Line
	3150 950  3150 850 
$Comp
L Connector:Conn_01x01 J16
U 1 1 5A9E5A36
P 1850 1650
F 0 "J16" H 1930 1692 50  0000 L CNN
F 1 "Conn_01x01" H 1930 1601 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 1850 1650 50  0001 C CNN
F 3 "~" H 1850 1650 50  0001 C CNN
	1    1850 1650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01 J17
U 1 1 5A9E5A9C
P 1850 1850
F 0 "J17" H 1930 1892 50  0000 L CNN
F 1 "Conn_01x01" H 1930 1801 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 1850 1850 50  0001 C CNN
F 3 "~" H 1850 1850 50  0001 C CNN
	1    1850 1850
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01 J18
U 1 1 5A9E5AE8
P 1850 2050
F 0 "J18" H 1930 2092 50  0000 L CNN
F 1 "Conn_01x01" H 1930 2001 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 1850 2050 50  0001 C CNN
F 3 "~" H 1850 2050 50  0001 C CNN
	1    1850 2050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01 J19
U 1 1 5A9E5B3A
P 1850 2250
F 0 "J19" H 1930 2292 50  0000 L CNN
F 1 "Conn_01x01" H 1930 2201 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 1850 2250 50  0001 C CNN
F 3 "~" H 1850 2250 50  0001 C CNN
	1    1850 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5A9E5BAA
P 1650 2250
F 0 "#PWR04" H 1650 2000 50  0001 C CNN
F 1 "GND" H 1655 2077 50  0000 C CNN
F 2 "" H 1650 2250 50  0001 C CNN
F 3 "" H 1650 2250 50  0001 C CNN
	1    1650 2250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5A9E5BF5
P 1650 2050
F 0 "#PWR05" H 1650 1800 50  0001 C CNN
F 1 "GND" H 1655 1877 50  0000 C CNN
F 2 "" H 1650 2050 50  0001 C CNN
F 3 "" H 1650 2050 50  0001 C CNN
	1    1650 2050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5A9E5C40
P 1650 1850
F 0 "#PWR06" H 1650 1600 50  0001 C CNN
F 1 "GND" H 1655 1677 50  0000 C CNN
F 2 "" H 1650 1850 50  0001 C CNN
F 3 "" H 1650 1850 50  0001 C CNN
	1    1650 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5A9E5C8B
P 1650 1650
F 0 "#PWR07" H 1650 1400 50  0001 C CNN
F 1 "GND" H 1655 1477 50  0000 C CNN
F 2 "" H 1650 1650 50  0001 C CNN
F 3 "" H 1650 1650 50  0001 C CNN
	1    1650 1650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
