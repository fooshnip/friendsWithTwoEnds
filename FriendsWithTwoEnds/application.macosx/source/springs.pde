
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

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


void setup(){
  //fullScreen();
  size(800,800);
  background(255);
  
  scoreToggle = 0;
  scoreLeft=0;
  scoreRight=0;
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(30,30,width-60,height-60));
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0)));
  physics.setDrag(0.1);

  ball = new Particle(new Vec2D(width/2,height/2),20);
  physics.addBehavior(new AttractionBehavior(ball,20,-0.0001));
  ball.setWeight(1);
  physics.addParticle(ball);
  
  center = new Particle(new Vec2D(width/2,height/2));
  physics.addBehavior(new AttractionBehavior(center,30,0.0011));
  physics.addParticle(center);
  
  p1 = new Player(200, #AD855C, 1);
  p2 = new Player(600, #FFD6AC, 2);

}


void mouseMoved(){
Particle head = p2.particles.get(0);
Particle tail = p2.particles.get(numParticles-1);
head.x = mouseX;
head.y = mouseY;
}

void draw(){
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
  fill(#00FF00,150);
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

void scoreCalculator(){
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

void gameOver(){
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

void mousePressed(){
  setup();
}
