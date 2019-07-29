//Serial Communication Variables
import processing.serial.*;
Serial Port; // serial port object
String dataRecieved; //create value for storing data recieved
boolean firstContact = false; //check if we heard from the arduino

//Visualization Variables

color backgroundColor = color(0,0,0,5); //select background color and fade constant
color infoboxBackgroundColor = color(0,0,0,100);
color textColor = color(255,255,255,100);
color radarGreen = color(20, 255, 20);
color radarRed = color(255, 0, 0,1000000);


float wholeScreenHeight = 1080;
float wholeScreenWidth = 1960;
int numberOfRings = 7;
int numberOfSectors = 6;
float angle = 0;
float angleIncrement = 0.1;
float distance = 0;
float radarHeight = wholeScreenHeight/2;
float radarWidth = 2*radarHeight;
int guideLineHeight = int(radarHeight);
float maximumDistance = 50; //5 meters maximum
//float[] simulatedDistances; //declare list of distances
//ArrayList<Float> angleList =new ArrayList<Float>(); //record of recorded angles
//ArrayList<Float> distanceList = new ArrayList<Float>(); //record of recorded distances
//ArrayList<Float> simulatedAngleList =new ArrayList<Float>(); //record of recorded angles
//ArrayList<Float> simulatedDistanceList = new ArrayList<Float>(); //record of recorded distances
//ArrayList<String> inputStreamList = new ArrayList<String>();
//ArrayList<String> outputStreamList = new ArrayList<String>();
int simulatedIndex = 0;

public void settings(){
    size(int(wholeScreenWidth),int(wholeScreenHeight)); //set up screen perimeters
}

void setup(){
  
  
  Port = new Serial(this, Serial.list()[0], 9600);
  Port.bufferUntil('\n');
}

//nothing here


//Communication
void serialEvent(Serial Port){
  //store the incoming data and use \n to organize data into packets
  dataRecieved = Port.readStringUntil('\n');
  
  if (dataRecieved != null){
    dataRecieved = trim(dataRecieved); //properly space the data
    //println(dataRecieved);
    
    if (firstContact == false){ //check if contact was already established
      if (dataRecieved.equals("Arduino Ready")){ //search for the key phrase
        Port.clear();
        firstContact = true;
        println("contact");
        Port.write("Contact established");
      }
    } else { //if contact was already established
    
      println(dataRecieved);
      
      //dataparse here
      
      parseInputStream(dataRecieved);
      Port.clear();
      
      
      Port.write("Processing Asking for more"); //ask for more data
      
    }
  }
}

void draw(){
  if (firstContact == true){
    Radar();
  }
}


//Draw functions

void Radar(){
  //parseInputStream(dataRecieved);
  drawArduinoGuidedLine();
  drawRadarOutline(numberOfRings);
  stroke(radarGreen);
  fill(backgroundColor);
  color(radarGreen);
  rect(0,0,radarWidth,radarHeight);
  textControl();
  
}
void drawRadarOutline(int numberofRings){
 stroke(radarGreen); //set color for sonar outline
 noFill();
 
 /*Draw Sonar Reference Rings*/
  for ( int i = 1 ; i <= numberofRings; i++){
   arc(radarWidth/2,radarHeight,(radarWidth*i)/numberofRings,2*radarHeight*i/numberofRings,PI,2*PI); //draw rings scaled according to the desired number of rings
   
  }
 /*Draw Sonar Reference Lines*/
  
  for ( int i = 1; i <= numberOfSectors; i++){
    pushMatrix(); //temporarily translate the x,y coordinate plane
    translate(radarWidth/2,radarHeight); //move the origin of the plane to the center of the circle
    line(0,0,guideLineHeight*cos(radians(i*180/numberOfSectors)),-guideLineHeight*sin(radians(i*180/numberOfSectors))); //create lines evenly spread out across the radar
    popMatrix();
  
  }
  
}
void drawArduinoGuidedLine(){
  float fullLineEndX = guideLineHeight*cos(radians(angle));
  float fullLineEndY = -guideLineHeight*sin(radians(angle));
  float scale = distance/maximumDistance;
  float edgeLineEndX = scale*fullLineEndX;
  float edgeLineEndY = scale*fullLineEndY;
  stroke(radarGreen); //set color for sonar lines
  noFill(); //translate the pivot to the center of the circle
  pushMatrix();
  translate(radarWidth/2,radarHeight);
    if (distance < maximumDistance){
      line(0,0,edgeLineEndX,edgeLineEndY);
      stroke(radarRed);
      line(edgeLineEndX,edgeLineEndY,edgeLineEndX+1,edgeLineEndY+1);
      stroke(radarGreen);
    } else {
      line(0,0,fullLineEndX,fullLineEndY); //draw the reference line along an angle GREEN
    }
    
    stroke(radarGreen);
    
  
  popMatrix(); //reset coordinate to its original position
  
}
void textControl(){
  textSize(50);
  fill(textColor);
  text("degrees: " + str(angle),radarWidth+20,100); //show the degrees the servo turned
  text("distance: " + str(distance),radarWidth+500,100); //show the degrees the servo turned
  fill(infoboxBackgroundColor);
  rect(radarWidth,0,wholeScreenWidth-radarWidth,radarHeight);
}

void parseInputStream(String dataPair){
  //if (dataPair != null){
    String[] parsedDataPair = dataPair.split(",");
      if(parsedDataPair.length==2){
         angle = float(parsedDataPair[0]);
         distance = float(parsedDataPair[1]);
         
     // }
  } 
}
