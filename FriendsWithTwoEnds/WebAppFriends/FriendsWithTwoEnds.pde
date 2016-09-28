
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

//import java.awt.*;

VerletPhysics2D physics;

Particle ball;
Particle corner1,corner2,corner3,corner4;
Player p1, p2, p3, p4;
color p1Col, p2Col, p3Col, p4Col;
color teamLeft, teamRight;
boolean p1Left,p2Left,p3Left,p4Left;
boolean p1Right,p2Right,p3Right,p4Right;
boolean p1Up,p2Up,p3Up,p4Up;
boolean p1Down,p2Down,p3Down,p4Down;


float scoreToggle;
float scoreLeft, scoreRight;
float startScore;

int screenToggle;
int numPlayers;
int startTime;
int margin;
PFont fontTitle;

void setup(){
  //fullScreen();
  size(1200,900);
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
  ball.setWeight(1);
  physics.addParticle(ball);
  
  //corner1 = new Particle(new Vec2D(0,0));
  //physics.addBehavior(new AttractionBehavior(corner1,80,-10));
  //physics.addParticle(corner1);
  
  //corner2 = new Particle(new Vec2D(width,0));
  //physics.addBehavior(new AttractionBehavior(corner2,80,-10));
  //physics.addParticle(corner2);
  
  //corner3 = new Particle(new Vec2D(0,height));
  //physics.addBehavior(new AttractionBehavior(corner3,80,-10));
  //physics.addParticle(corner3);
  
  //corner4 = new Particle(new Vec2D(width,height));
  //physics.addBehavior(new AttractionBehavior(corner4,80,-10));
  //physics.addParticle(corner4);
  
  stroke(0);
  strokeWeight(1);
  
  teamLeft = #66CCFF;
  teamRight = #FF9999;
  startTime = millis();
  
  //createPlayers(1);
}

void draw(){
  background(255);
  if(screenToggle==0){
    startScreen();
    //drawPlayer();
    //movePlayer();
  }
  if(screenToggle==1){
    instructionScreen();
  } 
  if(screenToggle>1){
    fontTitle = createFont("Amatic-Bold.ttf",32);
    textFont(fontTitle);
    physics.update();
    if((millis()-startTime)<3000){
      scoreCalculator();
      drawCourt();
      fill(#FF0066);
      textSize(30);
      text("READY",width/2-textWidth("READY")/2,height/2+margin);
      drawPlayer();
      playerHUD();
    }
    if((millis()-startTime)>=3000&&(millis()-startTime)<4000){
      scoreCalculator();
      drawCourt();
      fill(#FF0066);
      textSize(30);
      text("SET",width/2-textWidth("SET")/2,height/2+margin);
      drawPlayer();
      playerHUD();
    }
    if((millis()-startTime)<4000){
      fill(#FF0066);
      stroke(0);
      strokeWeight(2);
      textSize(30);
      text("Keep the ball on your side of the court!",width/2-textWidth("Keep the ball on your side of the court!")/2,height/4-15);
    }
    if((millis()-startTime)>=4000){
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

void drawBall(){
  stroke(#FF0066);
  fill(#FF0066);
  strokeWeight(50);
  ball.display();
}

void drawCourt(){
   //strokeWeight(50);
   strokeWeight(1);
   stroke(0);
   fill(0);
   textSize(30);
   fill(0);
   text("Friends with Two Ends",width/2-textWidth("Friends with Two Ends")/2,margin);
   fill(teamLeft);
   text("Team Left",width/6,margin);
   fill(teamRight);
   text("Team Right",width-width/6-textWidth("Team Right"),margin);
   fill(#FAFAFA,50);
   rect(margin/2,2*margin-margin/2,width-(2*margin)+margin,height-(3*margin)+margin);
   strokeWeight(1);
   stroke(0);
   line(width/2,(2*margin),width/2,(height-(margin)));
   fill(teamLeft,50);
   arc(width/2,(height+margin)/2,width-(2*margin),height-(3*margin),HALF_PI,PI+HALF_PI);
   fill(teamRight,50);
   arc(width/2,(height+margin)/2,width-(2*margin),height-(3*margin),-HALF_PI,HALF_PI);
   fill(255);
   ellipse(width/2,height/2+margin,width/6,(height)/6);
}

void scoreCalculator(){
  noStroke();
  if(scoreToggle==1&&scoreLeft<=(width-2*margin)){
    scoreLeft+=2;
    if(scoreRight>0){
      scoreRight-=1;
    }
  } else if(scoreToggle==2&&scoreRight<=(width-2*margin)) {
    scoreRight+=2;
    if(scoreLeft>0){
      scoreLeft-=1;
    }
  }
  fill(teamLeft, 150);
  arc(width/2,(height+margin)/2,scoreLeft,height-(3*margin),HALF_PI,PI+HALF_PI);
  fill(teamLeft);
  textSize(70);
  text(round(scoreLeft/(width-2*margin)*100),width/12-textWidth(str(round(scoreLeft/width*100)))/2,height/14);
  fill(teamRight, 150);
  arc(width/2,(height+margin)/2,scoreRight,height-(3*margin),-HALF_PI,HALF_PI);
  fill(teamRight);
  textSize(70);
  text(round(scoreRight/(width-2*margin)*100),width-width/12-textWidth(str(round(scoreRight/width*100)))/2,height/14);
}

void drawPlayer(){
  if(p1!=null){
    p1.display();
  }
  if(p2!=null){
    p2.display();
  }
  if(p3!=null){
    p3.display();
  }
  if(p4!=null){
    p4.display();
  }
}

void movePlayer(){
  if(p1!=null){
    p1Move();
  }
  if(p2!=null){
    p2Move();
  }
  if(p3!=null){
    p3Move();
  }
  if(p4!=null){
    p4Move();
  }
}

void playerHUD(){
  int ts = 20;
  textSize(ts);
  fill(teamLeft);
  text("P1",p1.particles.get(0).x-ts/2,p1.particles.get(0).y-40);
  fill(teamRight);
  text("P2",p2.particles.get(0).x-ts/2,p2.particles.get(0).y-40);
  if(p3!=null){
    fill(teamLeft);
    text("P3",p3.particles.get(0).x-ts/2,p3.particles.get(0).y-40);
  }
  if(p4!=null){
    fill(teamRight);
    text("P4",p4.particles.get(0).x-ts/2,p4.particles.get(0).y-40);
  }
}

void gameOver(){
  textSize(100);
  stroke(255);
  strokeWeight(10);
  fill(0);
  if(scoreLeft>=(width-2*margin)){
    if(numPlayers>2){
      Particle mid3 = p3.particles.get(floor(p3.particles.size()/2));
      stroke(random(255),random(255),random(255));
      strokeWeight(50);
      fill(p3Col);
      mid3.display();
    }
    Particle mid1 = p1.particles.get(floor(p1.particles.size()/2));
    stroke(random(255),random(255),random(255));
    strokeWeight(50);
    fill(p1Col);
    mid1.display();
    fill(255);
    text("Team Left Wins!",width/2-textWidth("Team Left Wins")/2+2,height/2+(margin)+margin/2+2);
    fill(0);
    text("Team Left Wins!",width/2-textWidth("Team Left Wins")/2,height/2+(margin)+margin/2);
  } else if(scoreRight>=(width-2*margin)){
    if(numPlayers>3){
      Particle mid4 = p4.particles.get(floor(p4.particles.size()/2));
      stroke(random(255),random(255),random(255));
      strokeWeight(50);
      fill(p4Col);
      mid4.display();
    }
    Particle mid2 = p2.particles.get(floor(p2.particles.size()/2));
    stroke(random(255),random(255),random(255));
    strokeWeight(50);
    fill(p2Col);
    mid2.display();
    fill(255);
    text("Team Right Wins!",width/2-textWidth("Team Right Wins")/2+2,height/2+(margin)+margin/2+2);
    fill(0);
    text("Team Right Wins!",width/2-textWidth("Team Right Wins")/2,height/2+(margin)+margin/2);
  }
  if(keyCode==ENTER){
    p1=null;
    p2=null;
    p3=null;
    p4=null;
    screenToggle = 0;
    setup();
  }
}

void createPlayers(int num){
    p1Col = pickColor(1);
    p2Col = pickColor(2);
    p3Col = pickColor(3);
    p4Col = pickColor(4);
  if(num==1){
    p1 = new Player(width/2, p1Col, 11,250);
  }
  if(num==2){
    p1 = new Player(width/4, p1Col, 1, 40);
    //versus
    p2 = new Player(width/2+width/4, p2Col, 2, 40);
  }
  if(num==3){
    p1 = new Player(width/5, p1Col, 1, 25);
    p3 = new Player(width/3, p3Col, 3, 25);
    //versus
    p2 = new Player(width-width/3, p2Col, 2, 35);
  }
  if(num==4){
    p1 = new Player(width/5, p1Col, 1, 25);
    p3 = new Player(width/3, p3Col, 3, 25);
    //versus
    p2 = new Player(width-width/3, p2Col, 2, 25);
    p4 = new Player(width-width/5, p4Col, 4, 25);
  }
}

int pickColor(int player){
  ArrayList<Integer> col = new ArrayList<Integer>();
  if(player==1)
  {
    col.add(unhex("FF336699"));
    //col.add(unhex("FF19A3FF"));
    //col.add(unhex("FF33ADFF"));
    //col.add(unhex("FF4DB8FF"));
  }
  if(player==2)
  {
    col.add(unhex("FFCC6600"));
    //col.add(unhex("FFFF7519"));
    //col.add(unhex("FFFF8533"));
    //col.add(unhex("FFFF944D"));
  }
  if(player==3)
  {
    col.add(unhex("FF669999"));
  }
  if(player==4)
  {
    col.add(unhex("FF660033"));
  }
  
  return(col.get(floor(random(col.size()))));
}

void keyPressed(){
  if(key=='Q'){
    p1=null;
    p2=null;
    p3=null;
    p4=null;
    screenToggle = 0;
    setup();
  }
  //p1
  if(keyCode==LEFT){
    p1Left=true;
  }
  if(keyCode==RIGHT){
    p1Right=true;
  }
  if(keyCode==UP){
    p1Up=true;
  }
  if(keyCode==DOWN){
    p1Down=true;
  }
  
  //p2
  if(key=='a'){
    p2Left=true;
  }
  if(key=='d'){
    p2Right=true;
  }
  if(key=='w'){
    p2Up=true;
  }
  if(key=='s'){
    p2Down=true;
  }
  
  //p3
  if(key=='b'){
    p3Left=true;
  }
  if(key=='m'){
    p3Right=true;
  }
  if(key=='h'){
    p3Up=true;
  }
  if(key=='n'){
    p3Down=true;
  }
  
  //p4
  if(key=='p'){
    p4Left=true;
  }
  if(key==']'){
    p4Right=true;
  }
  if(key=='-'){
    p4Up=true;
  }
  if(key=='['){
    p4Down=true;
  }
}

void keyReleased(){
  //p1
  if(keyCode==LEFT){
    p1Left=false;
  }
  if(keyCode==RIGHT){
    p1Right=false;
  }
  if(keyCode==UP){
    p1Up=false;
  }
  if(keyCode==DOWN){
    p1Down=false;
  }
  
  //p2
  if(key=='a'){
    p2Left=false;
  }
  if(key=='d'){
    p2Right=false;
  }
  if(key=='w'){
    p2Up=false;
  }
  if(key=='s'){
    p2Down=false;
  }
  
  //p3
  if(key=='b'){
    p3Left=false;
  }
  if(key=='m'){
    p3Right=false;
  }
  if(key=='h'){
    p3Up=false;
  }
  if(key=='n'){
    p3Down=false;
  }
  
  //p4
  if(key=='p'){
    p4Left=false;
  }
  if(key==']'){
    p4Right=false;
  }
  if(key=='-'){
    p4Up=false;
  }
  if(key=='['){
    p4Down=false;
  }
}

void p1Move(){
  if(p1Left==true){
    p1.moveLeft();
  }
  if(p1Right==true){
    p1.moveRight();
  }
  if(p1Up==true){
    p1.moveUp();
  }
  if(p1Down==true){
    p1.moveDown();
  }
}

void p2Move(){
  if(p2Left==true){
    p2.moveLeft();
  }
  if(p2Right==true){
    p2.moveRight();
  }
  if(p2Up==true){
    p2.moveUp();
  }
  if(p2Down==true){
    p2.moveDown();
  }
}

void p3Move(){
  if(p3Left==true){
    p3.moveLeft();
  }
  if(p3Right==true){
    p3.moveRight();
  }
  if(p3Up==true){
    p3.moveUp();
  }
  if(p3Down==true){
    p3.moveDown();
  }
}

void p4Move(){
  if(p4Left==true){
    p4.moveLeft();
  }
  if(p4Right==true){
    p4.moveRight();
  }
  if(p4Up==true){
    p4.moveUp();
  }
  if(p4Down==true){
    p4.moveDown();
  }
}

void startScreen(){
  fill(0);
  textSize(60);
  String title = "Friends with Two Ends";
  fill(teamLeft);
  pushMatrix();
  scale(1,-1);
  text("ends",(width/2-textWidth(title)/2+textWidth("Fri")),-(height/3));
  popMatrix();
  fill(0);
  text(title,width/2-textWidth(title)/2,height/3);
  
  textSize(30);
  String selectQ = "How many buddies do you have today?";
  text(selectQ,width/2-textWidth(selectQ)/2,height/2);
  
  textSize(40);
  noFill();
  rect(width/5,height/2+50,width/1.5,height/9);
  text("2",width/3-textWidth("2")/2,height/2+100);
  PImage img2p = loadImage("TwoP.png");
   img2p.resize(0,50);
   image(img2p,width/2,height/2+65);
   
  rect(width/5,height/2+150,width/1.5,height/9);
  text("3",width/3-textWidth("3")/2,height/2+200);
  PImage img3p = loadImage("ThreeP.png");
   img3p.resize(0,50);
   image(img3p,width/2-20,height/2+165);
  
  rect(width/5,height/2+250,width/1.5,height/9);
  text("4",width/3-textWidth("4")/2,height/2+300);
  PImage img4p = loadImage("FourP.png");
   img4p.resize(0,65);
   image(img4p,width/2,height/2+265);
}

void instructionScreen(){
  int ts = 30;
  float offset;
  float o1=1;
  float o2=1;
  float o3=1;
  float o4=1;
  textSize(ts*1.5);
  text("Keep the ball on your side",width/2-textWidth("Keep the ball on your side")/2,height/4);
  text("of the court to win!",width/2-textWidth("of the court to win!")/2,height/4+ts);
  textSize(ts);
  float controlsHeight = height/2+200;
  if(numPlayers==2){
    o1=2.5;
    o2=1.5;
    fill(teamLeft);
    text("Team Left",width/o1-textWidth("Team Left")/2,controlsHeight-margin);
    fill(teamRight);
    text("Team Right",width/o2-textWidth("Team Right")/2,controlsHeight-margin);
  }
  if(numPlayers==3){
    text("Team Left: P1 P3",100,100);
    text("Team Right: P2",100,100);
    o1=2.5;
    o2=1.8;
    o3=1.4;
  }
  if(numPlayers==4){
    text("Team Left: P1 P3",100,100);
    text("Team Right: P2",100,100);
    o1=3;
    o2=2;
    o3=1.5;
    o4=1.2;
  }
  fill(0);
  text("Controls",width/2-textWidth("Controls")/2,controlsHeight-2*margin);
  text("UP:",width/7,controlsHeight+ts*1);
  text("LEFT:",width/7,controlsHeight+ts*2);
  text("DOWN:",width/7,controlsHeight+ts*3);
  text("RIGHT:",width/7,controlsHeight+ts*4);
    
    offset = o1;
    fill(p1Col);
    textSize(ts*1.5);
    text("P1",width/offset,controlsHeight);
    textSize(ts);
    text("up",width/offset,controlsHeight+ts*1);
    text("left",width/offset,controlsHeight+ts*2);
    text("down",width/offset,controlsHeight+ts*3);
    text("right",width/offset,controlsHeight+ts*4);
    
    offset = o2;
    fill(p2Col);
    textSize(ts*1.5);
    text("P2",width/offset,controlsHeight);
    textSize(ts);
    text("w",width/offset,controlsHeight+ts*1);
    text("a",width/offset,controlsHeight+ts*2);
    text("s",width/offset,controlsHeight+ts*3);
    text("d",width/offset,controlsHeight+ts*4);
    
  if(p3!=null){  
    offset = o3;
    fill(p3Col);
    textSize(ts*1.5);
    text("P3",width/offset,controlsHeight);
    textSize(ts);
    text("h",width/offset,controlsHeight+ts*1);
    text("b",width/offset,controlsHeight+ts*2);
    text("n",width/offset,controlsHeight+ts*3);
    text("m",width/offset,controlsHeight+ts*4);
  }
  if(p4!=null){
    offset = o4;
    fill(p4Col);
    textSize(ts*1.5);
    text("P4",width/offset,controlsHeight);
    textSize(ts);
    text("dash -",width/offset,controlsHeight+ts*1);
    text("p",width/offset,controlsHeight+ts*2);
    text("open square [",width/offset,controlsHeight+ts*3);
    text("close square ]",width/offset,controlsHeight+ts*4);
  }
  fill(0);
}

void mousePressed(){
  if(screenToggle==0){
    if(mouseY>height/2+50 && mouseY<height/2+150){
      numPlayers = 2;
      createPlayers(numPlayers);
    }
    if(mouseY>height/2+150 && mouseY<height/2+250){
      numPlayers = 3;
      createPlayers(numPlayers);
    }
    if(mouseY>height/2+250 && mouseY<height/2+350){
      numPlayers = 4;
      createPlayers(numPlayers);
    }
  }
}

void mouseReleased(){
  if(screenToggle<2&&numPlayers>1){
    screenToggle++;
  }
}

void faceOff(){
  
}