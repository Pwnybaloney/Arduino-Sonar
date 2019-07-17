  /*
 Created on Processing 3.5.3
*/

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
float radarHeight = wholeScreenHeight/2;
float radarWidth = 2*radarHeight;
int guideLineHeight = int(radarHeight);
float maximumDistance = 5; //5 meters maximum
float[] simulatedDistances; //declare list of distances
ArrayList<Float> angleList =new ArrayList<Float>();
ArrayList<Float> distanceList = new ArrayList<Float>();
int index = 0;




public void settings(){
  size(int(wholeScreenWidth),int(wholeScreenHeight)); //set up screen perimeters
  
}


void setup(){ //initialize
  background(backgroundColor); //set background color
  simulateData();
}


/*Main Loop*/
void draw(){
  drawRadarOutline(numberOfRings); //draw radar outline
  
  angle = angleIncrement + angle;  //increment the angle
  if (angle >= 180. || angle <= 0.){
    angleIncrement = - angleIncrement; //change the direction of the sweeper when it reaches the end
  }
  
  angleList.add(angle);
  simulateData();
  
  drawMainGuideLine(); //draw the sweeping green line
  
  /*
  if (simulatedDistances[int(angle)] < maximumDistance){
    drawDetectedLine();
  }*/
  
  /*fade background*/
  
  stroke(radarGreen);
  fill(backgroundColor); //fade the background
  color(radarGreen);
  rect(0,0,radarWidth,radarHeight);
  textControl(); //displays info to the right of the radar
  delay(2);
  
  
  
  
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
  float lastDistance = (distanceList.get(distanceList.size()-1));
  //float lineStartX = 0;
  //float lineStartY = 0;
  float fullLineEndX = guideLineHeight*cos(radians(angle));
  float fullLineEndY = -guideLineHeight*sin(radians(angle));
  float scale = lastDistance/maximumDistance;
  float edgeLineEndX = scale*fullLineEndX;
  float edgeLineEndY = scale*fullLineEndY;
  stroke(radarGreen); //set color for sonar lines
  noFill(); //translate the pivot to the center of the circle
  pushMatrix();
  translate(radarWidth/2,radarHeight);
    if (lastDistance < maximumDistance){
      line(0,0,edgeLineEndX,edgeLineEndY);
      stroke(radarRed);
      line(edgeLineEndX,edgeLineEndY,edgeLineEndX+1,edgeLineEndY+1);
      stroke(radarGreen);
    } else {
      line(0,0,fullLineEndX,fullLineEndY); //draw the reference line along an angle GREEN
    }
    
    stroke(radarGreen);
    
  
  popMatrix(); //reset coordinate to its original position
  //println(scale);
  
}

void textControl(){
  textSize(50);
  fill(textColor);
  text("degrees: " + str(angle),radarWidth+20,100); //show the degrees the servo turned
  fill(infoboxBackgroundColor);
  rect(radarWidth,0,wholeScreenWidth-radarWidth,radarHeight);
}
/* used for the red detection
void drawDetectedLine(){ //draw red lines for detected objects
  float scale = (simulatedDistances[int(angle)]/maximumDistance);

  float lineStartX = guideLineHeight*cos(radians(angle))*scale;
  float lineStartY = -guideLineHeight*sin(radians(angle))*scale;
  float lineEndX = lineStartX*1.15;
  float lineEndY = lineStartY*1.15;
  stroke(radarRed); //set color for sonar lines
  noFill(); //translate the pivot to the center of the circle
  pushMatrix();
  translate(radarWidth/2,radarHeight);
  line(lineStartX,lineStartY,lineEndX,lineEndY); //draw the reference line along an angle
  popMatrix(); //reset coordinate to its original position
  color(radarGreen);
}
*/
/*
void simulateData() {
  for (int dataindex = 0; dataindex <= 180; dataindex = dataindex + abs(int(angleIncrement))){
    if (dataindex > 60 && dataindex < 90){
      simulatedDistances[dataindex] = 3;
    } else if(dataindex > 90 && dataindex < 120){
      simulatedDistances[dataindex] = 3.5;
    } else {
      simulatedDistances[dataindex] = 7;
    }
  }
}
*/
void simulateData(){
  if( angle > 60 && angle < 90){
    distanceList.add(3.0);
  } else if (angle > 90 && angle < 120){
        distanceList.add(4.0);
  } else {
    distanceList.add(5.0);
  }
}
