
int talk_len = 40;

int num_slides = 50;


long talkElapsedTime = 0;

long talkStartTime = 0;
boolean talkRunning = false;

PFont text_font;
PFont number_font;


import java.util.concurrent.TimeUnit;


void setup() {

  //size(1000,800,JAVA2D);
  fullScreen();
  number_font = createFont("nk57-monospace-sc-rg.ttf", height/4);
  text_font   = createFont("NixieOne.ttf", height/4);
  
}

void toggleTalkRun() {
   talkRunning = ! talkRunning;
   
   if(talkRunning) {
     talkStartTime = millis();
   }
  
}

void modTalkTime(int amt)
{
  if(talkRunning) return;
  
  talk_len = max(0, talk_len+ amt);
  
}

void modSlideCount(int amt)
{
  if(talkRunning) return;
  
  num_slides = max(0,num_slides+ amt);
}


void keyPressed()
{
    if(keyCode == UP) modTalkTime(1);
    if(keyCode == DOWN) modTalkTime(-1);
    if(keyCode == LEFT) modSlideCount(-1);
    if(keyCode == RIGHT) modSlideCount(1);
    if(keyCode == ENTER) toggleTalkRun();
    if(keyCode == RETURN) toggleTalkRun();
    
}




String clockTime="x";
String talkTime ="x";

void draw() {
  background(10);

  textAlign(CENTER,CENTER);

  if(!talkRunning) { 
      fill(#AA1111);
      textFont(number_font,height/6);
      text(nf(num_slides), width*0.33,height*0.5);
      text(nf(talk_len), width*0.66,height*0.5);
      textFont(text_font,height/8);
      text("slides", width*0.33, height*0.33);
      text("mins", width*0.66, height*0.33);

    }
    else {
      background(#6BA76D);
      fill(#020502);
      clockTime = (String.format("%02d:%02d",hour(),minute()));
      textSize(height/5);
      text(clockTime, width/2, height/3);
      textFont(number_font);
      int millisElapsed = (int)(millis() - talkStartTime);
      
      String ElapsedTimeStr = String.format("%02d:%02d", 
        TimeUnit.MILLISECONDS.toMinutes(millisElapsed),
        TimeUnit.MILLISECONDS.toSeconds(millisElapsed) - 
        TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millisElapsed))
      );
      textSize(height/6);
      text(ElapsedTimeStr, width/2, 2*(height/3));
      
      // draw the bar telling how long you have for that slide. 
      
      // we can determine millis/slide
      float millisPerSlide = (talk_len*60000)/num_slides;
      // we can now determine what slide we should be on
      float currentSlide = millisElapsed/millisPerSlide;
      
      float currentSlidePercent=currentSlide%1;
      float tBarWidth = width/3;
      
      rect(
        (width/2) - (tBarWidth/2),
        0.5*height,
        (currentSlidePercent*tBarWidth),
        20
      );
      
      textSize(60);
      if(millis() % 1000 == 0) { print(millisPerSlide); }
      textAlign(CENTER,BOTTOM);
      text(nf((int)currentSlide+1,0,0), width/2,height-30);
      //text(nf(millisPerSlide/1000.0f),width/2,height);
      //text(nf(currentSlide%1,0,3),40,height-50);
      
    }
  
  
}
