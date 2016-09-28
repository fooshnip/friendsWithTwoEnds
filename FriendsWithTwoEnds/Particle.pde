class Particle extends VerletParticle2D{

  int size;
  float r;
  
  Particle(Vec2D loc){
    super(loc);
    size = 16;
    r = 5;
    physics.addBehavior(new AttractionBehavior(this, 60, -20));
  }
  
  Particle(Vec2D loc, int _size){
    super(loc);
    size = _size;
    r = 5;
    physics.addBehavior(new AttractionBehavior(this, 60, -20));
  }
  
  void display(){
    ellipse(x,y,size,size);
  }
  
  
}