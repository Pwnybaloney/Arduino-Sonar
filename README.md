# Arduino-Sonar
Creating a Sonar using Arduino Uno
Made on processing 3.5.3
author: cuitony.baloney@gmail.com

Hardware Components:
HC-SR04 Ultrasound Sensor
SG90 Servo (there are other alternatives)
Arduino Uno
3D Printed Mounts(optional)

Wiring:
Connect Trig Pin to 10,
Connect Echo Pin to 11,
Connect Servo Pin to 9,
Connect the Servo and Sensor in parallel to 5V Pin,
Connect the Servo and Sensor in parallel to ground.

Arduino Side:
First, Connect your arduino to your computer with USB cable. Then, Run the arduino code. Within the arduino code, the variables "minAngle" and "maxAngle" can be configured to edit the bounds of rotation up to 180 degrees. The variable "simulatedAngleIncrement" can be changed to increase or decrease angle resolution. Run the arduino code and close the serial monitor.

Processing Side:
Run RadarwithSerial.pde on Processing 3.5.3. There should be a visualization.
