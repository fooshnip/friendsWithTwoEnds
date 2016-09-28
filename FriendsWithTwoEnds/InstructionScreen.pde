void instructionScreen(){
  int ts = height/30;
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
    o1=2.5;
    fill(teamLeft);
    text("Team Left: P1 & P3",width/o1-textWidth("Team Left: P1 & P3")/2,controlsHeight-margin);
    o2=1.5;
    fill(teamRight);
    text("Team Right: P2",width/o2-textWidth("Team Right: P2")/2,controlsHeight-margin);
    o1=2.8;
    o2=1.5;
    o3=2.3;
  }
  if(numPlayers==4){
    o1=2.5;
    fill(teamLeft);
    text("Team Left: P1 & P3",width/o1-textWidth("Team Left: P1 & P3")/2,controlsHeight-margin);
    o2=1.5;
    fill(teamRight);
    text("Team Right: P2 & P4",width/o2-textWidth("Team Right: P2 & P4")/2,controlsHeight-margin);
    o1=2.8;
    o2=1.6;
    o3=2.3;
    o4=1.4;
  }
  drawObjective();
  fill(0);
  //text("Controls",width/2-textWidth("Controls")/2,controlsHeight-2*margin);
  text("UP:",width/7,controlsHeight+ts*1);
  text("LEFT:",width/7,controlsHeight+ts*2);
  text("DOWN:",width/7,controlsHeight+ts*3);
  text("RIGHT:",width/7,controlsHeight+ts*4);
    
    offset = o1;
    fill(p1Col);
    textSize(ts*1.5);
    text("P1",width/offset,controlsHeight);
    textSize(ts);
    text("w",width/offset,controlsHeight+ts*1);
    text("a",width/offset,controlsHeight+ts*2);
    text("s",width/offset,controlsHeight+ts*3);
    text("d",width/offset,controlsHeight+ts*4);
    
    offset = o2;
    fill(p2Col);
    textSize(ts*1.5);
    text("P2",width/offset,controlsHeight);
    textSize(ts);
    text("up",width/offset,controlsHeight+ts*1);
    text("left",width/offset,controlsHeight+ts*2);
    text("down",width/offset,controlsHeight+ts*3);
    text("right",width/offset,controlsHeight+ts*4);
    
  if(numPlayers>2){  
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
  if(numPlayers==4){
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

int circleToggle = 1;
void drawObjective(){
  stroke(#FF0066);
  fill(#FF0066);
  strokeWeight(50);
  circleSwitch();
  if(circleToggle==1){
    circX+=3;
  }
  if(circleToggle==0){
    circX-=3;
  }
  ellipse(circX,height/2,30,30);
}

void circleSwitch(){
  if(circleToggle==1 & circX >= (width-width/3)){
    circleToggle = 0;
  }
  if(circleToggle==0 & circX <= width/3){
    circleToggle = 1;
  }
}