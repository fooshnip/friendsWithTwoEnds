import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import toxi.physics2d.*; 
import toxi.physics2d.behaviors.*; 
import toxi.geom.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class springs extends PApplet {






VerletPhysics2D physics;

Particle ball,center;
Player p1;
Player p2;


float len = 10;
int numParticles = 20;
float strength = 1;
float scoreToggle;
float scoreLeft;
float scoreRight;
float startScore;


public void setup(){
  //fullScreen();
  size(800,800);
  background(255);
  
  scoreToggle = 0;
  scoreLeft=0;
  scoreRight=0;
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(30,30,width-60,height-60));
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0)));
  physics.setDrag(0.1f);

  ball = new Particle(new Vec2D(width/2,height/2),20);
  physics.addBehavior(new AttractionBehavior(ball,20,-0.0001f));
  ball.setWeight(1);
  physics.addParticle(ball);
  
  center = new Particle(new Vec2D(width/2,height/2));
  physics.addBehavior(new AttractionBehavior(center,30,0.0011f));
  physics.addParticle(center);
  
  p1 = new Player(200, 0xffAD855C, 1);
  p2 = new Player(600, 0xffFFD6AC, 2);

}


public void mouseMoved(){
Particle head = p2.particles.get(0);
Particle tail = p2.particles.get(numParticles-1);
head.x = mouseX;
head.y = mouseY;
}

public void draw(){
  background(255);
  if(scoreLeft>=height||scoreRight>=height){
    gameOver();
    scoreToggle=0;
  }
  //stroke(#4C3D4C);
  strokeWeight(5);
  stroke(0);
  line(width/2,0,width/2,height);
  noFill();
  ellipse(width/2,height/2,width,height);
  ellipse(width/2,height/2,width/6,height/6);
  physics.update();
  p1.display();
  p2.display();
  textSize(50);
  fill(255, 204, 255);
  text("P1",p1.particles.get(0).x-30,p1.particles.get(0).y-40);
  p1.keyPressed();
  fill(0xff00FF00,150);
  text("P2",p2.particles.get(0).x-30,p2.particles.get(0).y-40);
  p2.keyPressed();
  stroke(255, 204, 0);
  fill(255, 204, 0);
  ball.display();
  if(ball.x<(width/2-30)&&scoreToggle!=1){
    scoreToggle=1;  
  } else if(ball.x>(width/2+30)&&scoreToggle!=2){
    scoreToggle=2;
  } else {
    scoreToggle=0;
  }
  scoreCalculator();
}

public void scoreCalculator(){
  noStroke();
  if(scoreToggle==1&&scoreLeft<=height){
    scoreLeft+=1;
  } else if(scoreToggle==2&&scoreRight<=height) {
    scoreRight+=1;
  }
  fill(255, 204, 255, 75);
  rect(0,height,width/2,-scoreLeft);
  fill(255, 204, 255, 150);
  textSize(70);
  text(round(scoreLeft/height*100),180,height/5);
  fill(153, 255, 153, 75);
  rect(width/2,height,width,-scoreRight);
  fill(153, 255, 153, 150);
  textSize(70);
  text(round(scoreRight/height*100),width/2+180,height/5);
}

public void gameOver(){
  textSize(100);
  stroke(255);
  strokeWeight(10);
  fill(0);
  if(scoreLeft>=height){
    text("Player 2 Wins!",width/9,height/2);
    //p2.particles.get(0);
  } else if(scoreRight>=height){
    text("Player 1 Wins!",width/9,height/2);
  }
}

public void mousePressed(){
  setup();
}
class Particle extends VerletParticle2D{

  int size;
  float r;
  
  Particle(Vec2D loc){
    super(loc);
    size = 16;
    r = 5;
    physics.addBehavior(new AttractionBehavior(this, 50, -1));
  }
  
  Particle(Vec2D loc, int _size){
    super(loc);
    size = _size;
    r = 5;
    physics.addBehavior(new AttractionBehavior(this, 50, -1));
  }
  
  public void display(){
    ellipse(x,y,size,size);
  }
  
  
}
class Player {
 
  public ArrayList<Particle> particles;
  private float len;
  private int numParticles;
  private float strength;
  private int col;
  private int startX;
  private int scheme;
  private float endMouth;

  Player(int startX, int c, int scheme){
    this.startX = startX;
    this.col = c;
    this.scheme = scheme;
    particles = new ArrayList<Particle>();
    
    len = 5;
    numParticles = 400;
    strength = 0.5f;
    
    for(int i=0;i<numParticles;i++){
      Particle particle = new Particle(new Vec2D(startX,height/2+i*len-(numParticles*len)/2));
      physics.addParticle(particle);
      particles.add(particle);
      if(i!=0){
        Particle previous = particles.get(i-1);
        VerletSpring2D spring = new VerletSpring2D(particle,previous,len,strength);
        physics.addSpring(spring);
      }
    }
    
    endMouth = random(PI+QUARTER_PI);
  }
  
  public void display(){
    Particle head = particles.get(0);
    
    Particle tail = particles.get(numParticles-1);
    noFill();
    //stroke(#FFE0C2);
    stroke(col);
    strokeWeight(50);
    smooth();
    beginShape();
    for(Particle p: particles){
      curveVertex(p.x,p.y);
    }
    endShape();
    tail.display();
    head.display();
    strokeWeight(1);
    stroke(0);
    fill(255);
    int sz=30;
    ellipse(head.x+15,head.y,sz,sz);
    ellipse(head.x-15,head.y,sz,sz);
    ellipse(tail.x+15,tail.y,sz,sz);
    ellipse(tail.x-15,tail.y,sz,sz);
    stroke(0);
    fill(0);
    ellipse(head.x+10,head.y,1,2);
    ellipse(head.x-10,head.y,1,2);
    ellipse(tail.x+10,tail.y,1,2);
    ellipse(tail.x-10,tail.y,1,2);
    arc(head.x, head.y+20, 10, 10, 0, endMouth);
    arc(tail.x, tail.y+20, 10, 10, 0, endMouth);
    strokeWeight(20);
    stroke(col);
  }
  
  public void keyPressed(){
    Particle head = particles.get(0);
    Particle tail = particles.get(numParticles-1);
    float moveSpeed = 5;
    if(scheme==1){
      if(key==CODED){
        if(keyCode==DOWN){
          head.x = head.x;
          head.y = head.y+moveSpeed;
          tail.x = tail.x;
          tail.y = tail.y+moveSpeed;
        }
        if(keyCode==UP){
          head.x = head.x;
          head.y = head.y-moveSpeed;
          tail.x = tail.x;
          tail.y = tail.y-moveSpeed;
        }
        if(keyCode==LEFT){
          head.x = head.x-moveSpeed;
          head.y = head.y;
          tail.x = tail.x-moveSpeed;
          tail.y = tail.y;
        }
        if(keyCode==RIGHT){
          head.x = head.x+moveSpeed;
          head.y = head.y;
          tail.x = tail.x+moveSpeed;
          tail.y = tail.y;
        }
      }
    } else {
      if(key=='s'){
        head.x = head.x;
        head.y = head.y+moveSpeed;
        tail.x = tail.x;
        tail.y = tail.y+moveSpeed;
      }
      if(key=='w'){
        head.x = head.x;
        head.y = head.y-moveSpeed;
        tail.x = tail.x;
        tail.y = tail.y-moveSpeed;
      }
      if(key=='a'){
        head.x = head.x-moveSpeed;
        head.y = head.y;
        tail.x = tail.x-moveSpeed;
        tail.y = tail.y;
      }
      if(key=='d'){
        head.x = head.x+moveSpeed;
        head.y = head.y;
        tail.x = tail.x+moveSpeed;
        tail.y = tail.y;
      }
    }
  }
}
class Wall extends VerletParticle2D{

  float r;
  int x,y,w,h;
  Wall(Vec2D loc,int w, int h){
    super(loc);
    r = 5;
    physics.addBehavior(new AttractionBehavior(this, 500, 0));
    x = x;
    y = y;
    w = w;
    h = h;
  }
  
  public void display(){
    fill(0);
    rect(x,y,w,h);
  }
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "springs" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
