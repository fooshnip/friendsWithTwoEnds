

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

void reset(){
  scoreToggle=0;
  scoreLeft=0;
  scoreRight=0;
  physics = new VerletPhysics2D();
  margin = 50;
  physics.setWorldBounds(new Rect(margin,2*margin,width-(2*margin),height-(3*margin)));
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0,0)));
  physics.setDrag(0.15);

  ball = new Particle(new Vec2D(width/2,height/2+margin),50);
  physics.addBehavior(new AttractionBehavior2D(ball,20,-0.0001));
  //ball.setWeight(1);
  physics.addParticle(ball);
  createPlayers(numPlayers);
}

void keyPressed(){
  if(key=='R' && screenToggle==2){
    startTime = millis();
    reset(); 
  }
  
  if(key=='P' && screenToggle==2){
    if(pauseToggle==0){
      noLoop();
      pauseToggle = 1;
    } else {
      loop();
      pauseToggle = 0;
    }
  }
  
  if(key=='Q'){
    p1=null;
    p2=null;
    p3=null;
    p4=null;
    screenToggle = 0;
    setup();
  }
  
  //p1
  if(key=='a'){
    p1Left=true;
  }
  if(key=='d'){
    p1Right=true;
  }
  if(key=='w'){
    p1Up=true;
  }
  if(key=='s'){
    p1Down=true;
  }
    
  
  //p2
  if(keyCode==LEFT){
    p2Left=true;
  }
  if(keyCode==RIGHT){
    p2Right=true;
  }
  if(keyCode==UP){
    p2Up=true;
  }
  if(keyCode==DOWN){
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
  if(key=='a'){
    p1Left=false;
  }
  if(key=='d'){
    p1Right=false;
  }
  if(key=='w'){
    p1Up=false;
  }
  if(key=='s'){
    p1Down=false;
  }
  
  //p2
  if(keyCode==LEFT){
    p2Left=false;
  }
  if(keyCode==RIGHT){
    p2Right=false;
  }
  if(keyCode==UP){
    p2Up=false;
  }
  if(keyCode==DOWN){
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
