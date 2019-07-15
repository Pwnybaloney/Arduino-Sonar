/*
 Created on Processing 3.5.3
*/

color backgroundColor = color(0,0,0,5); //select background color and fade constant
color radarGreen = color(48, 199, 83);
float wholeScreenHeight = 1080/2;
float wholeScreenWidth = 1.5*1960/2;
int numberOfRings = 8;
int numberOfReferenceLines = 8;
float angle = 0;
float angleIncrement = 0.5;
float radarHeight = 1*wholeScreenHeight;
float radarWidth = 2*radarHeight;
int guideLineHeight = int(radarHeight);
public void settings(){
  size(int(wholeScreenWidth),int(wholeScreenHeight)); //initialize screen
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
  rect(0,0,2000,2000);
  
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
  for ( int i = 1; i <= numberOfReferenceLines; i++){
    pushMatrix(); //temporarily translate the x,y coordinate plane
    translate(radarWidth/2,radarHeight);
    line(0,0,guideLineHeight*cos(radians(i*180/numberOfReferenceLines)),-guideLineHeight*sin(radians(i*180/numberOfReferenceLines))); //create lines evenly spread out across the radar
    popMatrix();
    
  }
}


/* Function for drawing the primary sweeping line*/
void drawMainGuideLine(){
  stroke(radarGreen); //set color for sonar lines
  noFill();
  pushMatrix();
  translate(radarWidth/2,radarHeight);
  line(0,0,guideLineHeight*cos(radians(angle)),-guideLineHeight*sin(radians(angle)));
  popMatrix();
  
  
}
