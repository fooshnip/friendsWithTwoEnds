

void startScreen(){
  drawTitle();
  
  //textSize(height/20);
  //String selectQ = "How many buddies do you have today?";
  //text(selectQ,width/2-textWidth(selectQ)/2,height/2);
  
}

void drawTitle(){
  fill(0);
  textSize(height/10);
  String title = "Friends with Two Ends";
  fill(teamLeft);
  pushMatrix();
  scale(1,-1);
  text("ends",(width/2-textWidth(title)/2+textWidth("Fri")),-(height/3));
  popMatrix();
  fill(0);
  text(title,width/2-textWidth(title)/2,height/3);
}

//void drawPlayerSelectMenu(){
  
//}

//void mouseMoved(){
//  if(mouseX>width/3 & mouseX<(width/3+width/3)){
    
//  }
//}

void drawPlayerSelectMenu(){
 cp5 = new ControlP5(this);
 // create a new button with name 'buttonA'
 PImage img2p = loadImage("TwoP.png");
  img2p.resize(0,50);
  //image(img2p,width/2,height/2+65);
 cp5.addButton("twoPlayers")
    .setCaptionLabel("2 Players")
    .setColorBackground(cp5.WHITE)
    .setColorForeground(teamLeft)
    .setColorCaptionLabel(cp5.BLACK)
    //.setImage(img2p)
    //.setFont(createFont("GoodDog.otf",32))
    .setPosition(width/3,height/1.75)
    .setSize(width/3,height/12)
    ;
  
 // and add another 2 buttons
 cp5.addButton("threePlayers")
    .setCaptionLabel("3 Players")
    .setColorBackground(cp5.WHITE)
    .setColorForeground(teamLeft)
    .setColorCaptionLabel(cp5.BLACK)
    .setPosition(width/3,height/1.75+height/12)
    .setSize(width/3,height/12)
    ;
     
 cp5.addButton("fourPlayers")
    .setCaptionLabel("4 Players")
    .setColorBackground(cp5.WHITE)
    .setColorForeground(teamLeft)
    .setColorCaptionLabel(cp5.BLACK)
    .setPosition(width/3,height/1.75+2*(height/12))
    .setSize(width/3,height/12)
    ;
     
 cp5.getController("twoPlayers")
    .getCaptionLabel()
    .setFont(fontTitle)
    .toUpperCase(false)
    .setSize(height/20)
    ;
     
 cp5.getController("threePlayers")
    .getCaptionLabel()
    .setFont(fontTitle)
    .toUpperCase(false)
    .setSize(height/20)
    ;
     
 cp5.getController("fourPlayers")
    .getCaptionLabel()
    .setFont(fontTitle)
    .toUpperCase(false)
    .setSize(height/20)
    ;
}

public void controlEvent(ControlEvent theEvent) {
 println(theEvent.getController().getName());
 println(theEvent.getController().getValue());
}

public void twoPlayers() {
 numPlayers = 2;
}

public void threePlayers() {
 numPlayers = 3;
}

public void fourPlayers() {
 numPlayers = 4;
}