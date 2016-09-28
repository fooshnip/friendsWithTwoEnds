class Player {
 
  public ArrayList<Particle> particles;
  private float len;
  private int numParticles;
  private float strength;
  private color col;
  private int startX;
  private int scheme;
  private float endMouth;

  Player(int startX, color c, int scheme){
    this.startX = startX;
    this.col = c;
    this.scheme = scheme;
    particles = new ArrayList<Particle>();
    
    len = 5;
    numParticles = 400;
    strength = 0.5;
    
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
  
  void display(){
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
