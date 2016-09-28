import controlP5.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

//import java.awt.*;

VerletPhysics2D physics;

Particle ball;
Particle corner1,corner2,corner3,corner4;
Player p1, p2, p3, p4;
boolean p1Left,p2Left,p3Left,p4Left;
boolean p1Right,p2Right,p3Right,p4Right;
boolean p1Up,p2Up,p3Up,p4Up;
boolean p1Down,p2Down,p3Down,p4Down;
color p1Col, p2Col, p3Col, p4Col;
color teamLeft, teamRight;


float scoreToggle;
float scoreLeft, scoreRight;
float startScore;

int screenToggle;
int numPlayers;
int startTime;
int margin;
PFont fontTitle;
int pauseToggle;

ControlP5 cp5;
float circX;

//public class Game implements Runnable {
//  public void run(){
    
//  }
//}

void setup(){
  fullScreen();
  //size(600,600);
  background(255);
  screenToggle = 0;
  fontTitle = createFont("GoodDog.otf",32);
  //fontTitle = createFont("Amatic-Bold.ttf",32);
  textFont(fontTitle);
  scoreToggle=0;
  scoreLeft=0;
  scoreRight=0;
  physics = new VerletPhysics2D();
  margin = 50;
  physics.setWorldBounds(new Rect(margin,2*margin,width-(2*margin),height-(3*margin)));
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0)));
  physics.setDrag(0.15);

  ball = new Particle(new Vec2D(width/2,height/2+margin),50);
  physics.addBehavior(new AttractionBehavior(ball,20,-0.0001));
  //ball.setWeight(1);
  physics.addParticle(ball);
  
  stroke(0);
  strokeWeight(1);
  
  teamLeft = #66CCFF;
  teamRight = #FF9999;
  startTime = millis();
  drawPlayerSelectMenu();
  //createPlayers(1);
  numPlayers = 0;
  circX = width/2;
  pauseToggle = 0;
}

void draw(){
  background(255);
  if(screenToggle==0){
    startScreen();
    cp5.show();
    //drawPlayer();
    //movePlayer();
  }
  if(screenToggle==1){
    cp5.hide();
    instructionScreen();
  } 
  if(screenToggle>1){
    //fontTitle = createFont("Amatic-Bold.ttf",32);
    textFont(fontTitle);
    physics.update();
    if((millis()-startTime)<1000){
      scoreCalculator();
      drawCourt();
      fill(#FF0066);
      textSize(height/20);
      text("READY",width/2-textWidth("READY")/2,height/2+margin);
      drawPlayer();
      playerHUD();
    }
    if((millis()-startTime)>=1000&&(millis()-startTime)<2000){
      scoreCalculator();
      drawCourt();
      fill(#FF0066);
      textSize(height/20);
      text("SET",width/2-textWidth("SET")/2,height/2+margin);
      drawPlayer();
      playerHUD();
    }
    if((millis()-startTime)<2000){
      fill(#FF0066);
      stroke(0);
      strokeWeight(2);
      textSize(height/20);
      text("Keep the ball on your side of the court!",width/2-textWidth("Keep the ball on your side of the court!")/2,height/4-15);
    }
    if((millis()-startTime)>=2000){
      scoreCalculator();
      drawCourt();
      drawPlayer();
      movePlayer();
      playerHUD();
      drawBall();
    }
    if(ball.x<(width/2-30)&&scoreToggle!=1){
      scoreToggle=1;  
    } else if(ball.x>(width/2+30)&&scoreToggle!=2){
      scoreToggle=2;
    } else {
      scoreToggle=0;
    }
    if(scoreLeft>=(width-2*margin)||scoreRight>=(width-2*margin)){
      gameOver();
      scoreToggle=0;
    }
  }
}