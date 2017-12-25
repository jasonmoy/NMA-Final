//Jason Moy && Melissa Moy 
//NMA 3012
//Professor Qi
//Interactive Final Project
//"Cooking Mama for the Kinect"
//Credits to Daniel Shiffman for Kinect library
//ENJOY!!!!


import processing.video.*;
import processing.sound.*;
import org.openkinect.freenect.*;//Kinect libraries
import org.openkinect.processing.*;
Kinect kinect; //declaring kinect object
KinectTracker tracker;
SoundFile theme;
Movie step1,step2,step3,step4,step5;
PImage img, startScreen, endScreen;
int level = 0;
int savedTime = 0;
float minThresh = 400;
float maxThresh = 830;

void setup(){
  fullScreen();
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  step1 = new Movie(this, "crack_egg.mp4");
  step2 = new Movie(this, "mix.mp4");
  step3 = new Movie(this, "butta.mp4");
  step4 = new Movie(this, "cook_egg.mp4");
  step5 = new Movie(this, "finishedegg.mp4");
  theme = new SoundFile(this, "themeSong.mp3");
  theme.play();
  startScreen = loadImage("cookingMamaScreen.png");
  endScreen = loadImage("veryGood.jpg");
  savedTime = millis();
}

void draw(){
  background(0);
  tracker.track();
  PVector v1 = tracker.getPos();
  PVector v2 = tracker.getLerpedPos();
  switch(level){
    case 0: 
    image(startScreen,550,250);
    if(v1.x<116 && v1.y>391){ //bottom left
      level = 1;
    }
    break;
    case 1://crack egg
    image(step1,0,0);
    step1.play();
    if(v1.x>302 && v1.x<390 && v1.y>235){ // center of image
      savedTime = millis(); 
      level = 2; 
    }
    break;
    case 2://mix egg
    image(step2,0,0);
    step2.play();
    if(v1.x>547 && v1.y<379){ //bottom left corner
      level = 3;
      savedTime = millis();
    }
    break;
    case 3://spread butter
    image(step3,0,0);
    step3.play();
     if(v1.x<98){ //left hand side
      level = 4;
      savedTime = millis();
    }
    break;
    case 4://cook egg
    image(step4,0,0);
    step4.play();
    if(v1.x>116 && v1.x<200 && v1.y>100){ //top middle
      level = 5;
      savedTime =millis();
      println(savedTime);
    }
    break;
    case 5://final egg
    image(step5,0,0);
    step5.play();
    if(v1.x>547 && v1.y<379){ //bottom left corner
      level = 6;
      savedTime = millis();
    }
    break;
    case 6://end screen
    image(endScreen,550,250);
    break;
  }   
  tracker.display();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);
  //println(mouseX, mouseY);
}

void movieEvent(Movie m){
  m.read();
}