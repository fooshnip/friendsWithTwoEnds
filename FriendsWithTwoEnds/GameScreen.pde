void drawCourt(){
   drawScoreBoard();
   fill(#FAFAFA,50);
   rect(margin/2,2*margin-margin/2,width-(2*margin)+margin,height-(3*margin)+margin);
   strokeWeight(1);
   stroke(0);
   line(width/2,(2*margin),width/2,(height-(margin)));
   fill(teamLeft,50);
   arc(width/2,(height+margin)/2,width-(2*margin),height-(3*margin),HALF_PI,PI+HALF_PI);
   fill(teamRight,50);
   arc(width/2,(height+margin)/2,width-(2*margin),height-(3*margin),-HALF_PI,HALF_PI);
   fill(255);
   ellipse(width/2,height/2+margin,width/6,(height)/6);
}

void drawScoreBoard(){
   strokeWeight(1);
   stroke(0);
   fill(0);
   textSize(height/30);
   fill(0);
   text("Friends with Two Ends",width/2-textWidth("Friends with Two Ends")/2,margin);
   fill(teamLeft);
   text("Team Left",width/6,margin);
   fill(teamRight);
   text("Team Right",width-width/6-textWidth("Team Right"),margin);
}

void drawBall(){
  stroke(#FF0066);
  fill(#FF0066);
  strokeWeight(height/20);
  ball.display();
}