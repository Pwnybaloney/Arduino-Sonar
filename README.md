# Arduino-Radar
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

Setup (optional):

3D Printing*: If you are using Formlabs, print the 3D parts in its STL Format. Otherwise, you could open it up as an ipt or stp to convert it to a preffered format.

Mounting: First, attach the black piece that comes with the sg90 motor to the hub of the motor. Thread through the small hole on the base of the Ultrasonic sensor mount and Servo with a screw 2mm in diameter. Then, place the ultrasonic sensor into the ultrasound mount and lock it with a complementary piece. Insert the SG90 servo into the mount and screw in one end with a screw 2mm in diameter.

Arduino Side:
First, Connect your arduino to your computer with USB cable. Then, Run the arduino code. Within the arduino code, the variables "minAngle" and "maxAngle" can be configured to edit the bounds of rotation up to 180 degrees. The variable "simulatedAngleIncrement" can be changed to increase or decrease angle resolution. Run the arduino code and close the serial monitor.

Processing Side:
Run RadarwithSerial.pde on Processing 3.5.3. The variables "numberOfRings" and "numberOfSectors" can be adjusted to change the radar outline you desire. In addition, the background color and radar color variables can also be adjusted. Most importantly, the maximumDistance variable can be adjusted to choose a desired maximum distance.


Once running, the TX and RX LED pins should flash on the arduino. The Sensor should sweep from the minimum and maximum angle set according to the given increments while the distance is displayed on processing.

