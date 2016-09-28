class Player {
 
  public ArrayList<Particle> particles;
  private float len;
  public int numParticles;
  private float strength;
  private color col;
  private float startX;
  private int scheme;
  private float endMouth;
  private float moveSpeed;
  private Particle head;
  private Particle tail;

  Player(float startX, int c, int scheme, int numPart){
    this.startX = startX;
    this.col = color(c);
    this.scheme = scheme;
    particles = new ArrayList<Particle>();
    
    len = 1;
    //numParticles = floor(random(30,100));
    numParticles=numPart;
    strength = 0.2;
    
    for(int i=0;i<numParticles;i++){
      Particle particle = new Particle(new Vec2D(startX, (height+margin)/2+i*len-(numParticles*len)/2));
      physics.addParticle(particle);
      particles.add(particle);
      if(i!=0){
        Particle previous = particles.get(i-1);
        VerletSpring2D spring = new VerletSpring2D(particle,previous,len,strength);
        physics.addSpring(spring);
      }
    }
    
    endMouth = random(PI+QUARTER_PI);
    setSpeed();
  }
  
  void display(){
    getEnds();
    
    drawBody();
    drawEyes(30);
    drawPupils();
    drawMouths();

    strokeWeight(20);
    stroke(col);
  }
  
  void drawBody(){
    noFill();
    //stroke(#FFE0C2);
    stroke(col);
    strokeWeight(50);
    smooth();
    beginShape();
    for(Particle p: particles){
      curveVertex(p.x,p.y);
      //ellipse(p.x,p.y,50,50);
    }
    endShape();
    strokeWeight(50);
    if(numPlayers>1){
      if(scheme==1||scheme==3){
        stroke(teamLeft);
      } else {
        stroke(teamRight);
      }
      Particle mid = particles.get(floor(particles.size()/2));
      strokeWeight(50);
      mid.display();
    }
    strokeWeight(50);
    stroke(col);
    //noFill();
    tail.display();
    head.display();
  }
  
  void drawEyes(int sz){
    strokeWeight(1);
    stroke(0);
    fill(255);
    ellipse(head.x+15,head.y,sz,sz);
    ellipse(head.x-15,head.y,sz,sz);
    ellipse(tail.x+15,tail.y,sz,sz);
    ellipse(tail.x-15,tail.y,sz,sz);
  }
  
  void drawPupils(){
    strokeWeight(1);
    stroke(0);
    if(scheme==1||scheme==3){
      fill(teamLeft);
    } else {
      fill(teamRight);
    }
    ellipse(head.x+10,head.y,1,3);
    ellipse(head.x-10,head.y,1,3);
    ellipse(tail.x+10,tail.y,1,3);
    ellipse(tail.x-10,tail.y,1,3);
  }
  
  void drawMouths(){
    stroke(0);
    fill(0);
    arc(head.x, head.y+20, 10, 10, 0, endMouth);
    arc(tail.x, tail.y+20, 10, 10, 0, endMouth);
  }
  
  void setSpeed(){
    moveSpeed = 40;
  }
  
  void setSpeed(int x){
    moveSpeed = x;
  }
  
  void getEnds(){
    head = particles.get(0);
    tail = particles.get(numParticles-1);
  }
  
  void moveLeft(){
    getEnds();
    head.x = head.x-moveSpeed;
    head.y = head.y;
    tail.x = tail.x-moveSpeed;
    tail.y = tail.y;
  }
  
  void moveRight(){
    getEnds();
    head.x = head.x+moveSpeed;
    head.y = head.y;
    tail.x = tail.x+moveSpeed;
    tail.y = tail.y;
  }
  
  void moveUp(){
    getEnds();
    head.x = head.x;
    head.y = head.y-moveSpeed;
    tail.x = tail.x;
    tail.y = tail.y-moveSpeed;
  }
  
  void moveDown(){
    getEnds();
    head.x = head.x;
    head.y = head.y+moveSpeed;
    tail.x = tail.x;
    tail.y = tail.y+moveSpeed;
  }
  
}

void playerHUD(){
  int ts = height/30;
  textSize(ts);
  fill(0);
  text("P1",p1.particles.get(0).x-ts/2,p1.particles.get(0).y-40);
  fill(0);
  text("P2",p2.particles.get(0).x-ts/2,p2.particles.get(0).y-40);
  if(p3!=null){
    fill(0);
    text("P3",p3.particles.get(0).x-ts/2,p3.particles.get(0).y-40);
  }
  if(p4!=null){
    fill(0);
    text("P4",p4.particles.get(0).x-ts/2,p4.particles.get(0).y-40);
  }
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

void createPlayers(int num){
    p1Col = pickColor(1);
    p2Col = pickColor(2);
    p3Col = pickColor(3);
    p4Col = pickColor(4);
  if(num==1){
    p1 = new Player(width/2, p1Col, 11,250);
  }
  if(num==2){
    p1 = new Player(width/4, p1Col, 1, height/25);
    //versus
    p2 = new Player(width/2+width/4, p2Col, 2, height/25);
  }
  if(num==3){
    p1 = new Player(width/5, p1Col, 1, height/35);
    p3 = new Player(width/3, p3Col, 3, height/35);
    //versus
    p2 = new Player(width-width/3, p2Col, 2, height/30);
  }
  if(num==4){
    p1 = new Player(width/5, p1Col, 1, height/35);
    p3 = new Player(width/3, p3Col, 3, height/35);
    //versus
    p2 = new Player(width-width/3, p2Col, 2, height/35);
    p4 = new Player(width-width/5, p4Col, 4, height/35);
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