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
    }
    endShape();
    strokeWeight(30);
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
    strokeWeight(40);
    stroke(col);
    noFill();
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