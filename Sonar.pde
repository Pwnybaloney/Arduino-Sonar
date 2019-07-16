/*
 Created on Processing 3.5.3
*/

color backgroundColor = color(0,0,0,5); //select background color and fade constant
color infoboxBackgroundColor = color(0,0,0,100);
color textColor = color(255,255,255,100);
color radarGreen = color(48, 199, 83);


float wholeScreenHeight = 1080;
float wholeScreenWidth = 1960;
int numberOfRings = 7;
int numberOfSectors = 6;
float angle = 0;
float angleIncrement = 0.5;
float radarHeight = wholeScreenHeight/2;
float radarWidth = 2*radarHeight;
int guideLineHeight = int(radarHeight);


public void settings(){
  size(int(wholeScreenWidth),int(wholeScreenHeight)); //set up screen perimeters
  
}


void setup(){ //initialize
  background(backgroundColor); //set background color
  
}


/*Main Loop*/
void draw(){
  drawRadarOutline(numberOfRings); //draw radar outline
  
  angle = angleIncrement + angle;  //increment the angle
  if (angle >180 || angle < 0){
    angleIncrement = - angleIncrement; //change the direction of the sweeper when it reaches the end
  }
  
  drawMainGuideLine(); //draw the sweeping green line
  
  fill(backgroundColor); //fade the background
  rect(0,0,radarWidth,radarHeight);
  textControl(); //displays info to the right of the radar

}  


/*Draw the outline of the radar*/
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


/* Function for drawing the primary sweeping line*/
void drawMainGuideLine(){
  stroke(radarGreen); //set color for sonar lines
  noFill(); //translate the pivot to the center of the circle
  pushMatrix();
  translate(radarWidth/2,radarHeight);
  line(0,0,guideLineHeight*cos(radians(angle)),-guideLineHeight*sin(radians(angle))); //draw the reference line along an angle
  popMatrix(); //reset coordinate to its original position
  
  
}

void textControl(){
  textSize(50);
  fill(textColor);
  text("degrees: " + str(angle),radarWidth+20,100); //show the degrees the servo turned
  fill(infoboxBackgroundColor);
  rect(radarWidth,0,wholeScreenWidth-radarWidth,radarHeight);
}
