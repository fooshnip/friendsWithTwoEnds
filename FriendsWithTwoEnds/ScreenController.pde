void mousePressed(){
 if(screenToggle==0){
   //if(mouseY>height/1.75 && mouseY<height/1.75+height/12){
   //  numPlayers = 2;
   //  createPlayers(numPlayers);
   //}
   //if(mouseY>height/1.75+height/12 && mouseY<height/1.75+height/6){
   //  numPlayers = 3;
   //  createPlayers(numPlayers);
   //}
   //if(mouseY>height/6 && mouseY<height){
   //  numPlayers = 4;
   //  createPlayers(numPlayers);
   //}
 }
}

void mouseReleased(){
 if(screenToggle<2&&numPlayers>1){
   screenToggle++;
 }
 if(screenToggle>1&&numPlayers>1){
   startTime = millis();
   createPlayers(numPlayers);
 }
}