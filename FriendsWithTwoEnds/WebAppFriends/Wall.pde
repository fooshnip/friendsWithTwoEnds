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
  
  void display(){
    fill(0);
    rect(x,y,w,h);
  }
  
}
