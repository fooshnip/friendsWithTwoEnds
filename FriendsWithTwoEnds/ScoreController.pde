void scoreCalculator(){
  noStroke();
  if(scoreToggle==1&&scoreLeft<=(width-2*margin)){
    scoreLeft+=2;
    if(scoreRight>0){
      scoreRight-=1;
    }
  } else if(scoreToggle==2&&scoreRight<=(width-2*margin)) {
    scoreRight+=2;
    if(scoreLeft>0){
      scoreLeft-=1;
    }
  }
  fill(teamLeft, 150);
  arc(width/2,(height+margin)/2,scoreLeft,height-(3*margin),HALF_PI,PI+HALF_PI);
  fill(teamLeft);
  textSize(height/15);
  text(round(scoreLeft/(width-2*margin)*100),width/12-textWidth(str(round(scoreLeft/width*100)))/2,margin+10);
  fill(teamRight, 150);
  arc(width/2,(height+margin)/2,scoreRight,height-(3*margin),-HALF_PI,HALF_PI);
  fill(teamRight);
  textSize(height/15);
  text(round(scoreRight/(width-2*margin)*100),width-width/12-textWidth(str(round(scoreRight/width*100)))/2,margin+10);
}


void gameOver(){
  textSize(height/10);
  stroke(255);
  strokeWeight(10);
  fill(0);
  if(scoreLeft>=(width-2*margin)){
    if(numPlayers>2){
      Particle mid3 = p3.particles.get(floor(p3.particles.size()/2));
      stroke(random(255),random(255),random(255));
      strokeWeight(50);
      fill(p3Col);
      mid3.display();
    }
    Particle mid1 = p1.particles.get(floor(p1.particles.size()/2));
    stroke(random(255),random(255),random(255));
    strokeWeight(50);
    fill(p1Col);
    mid1.display();
    fill(255);
    text("Team Left Wins!",width/2-textWidth("Team Left Wins")/2+2,height/2+(margin)+margin/2+2);
    fill(0);
    text("Team Left Wins!",width/2-textWidth("Team Left Wins")/2,height/2+(margin)+margin/2);
  } else if(scoreRight>=(width-2*margin)){
    if(numPlayers>3){
      Particle mid4 = p4.particles.get(floor(p4.particles.size()/2));
      stroke(random(255),random(255),random(255));
      strokeWeight(50);
      fill(p4Col);
      mid4.display();
    }
    Particle mid2 = p2.particles.get(floor(p2.particles.size()/2));
    stroke(random(255),random(255),random(255));
    strokeWeight(50);
    fill(p2Col);
    mid2.display();
    fill(255);
    text("Team Right Wins!",width/2-textWidth("Team Right Wins")/2+2,height/2+(margin)+margin/2+2);
    fill(0);
    text("Team Right Wins!",width/2-textWidth("Team Right Wins")/2,height/2+(margin)+margin/2);
  }
  if(keyCode==ENTER){
    p1=null;
    p2=null;
    p3=null;
    p4=null;
    screenToggle = 0;
    setup();
  }
}