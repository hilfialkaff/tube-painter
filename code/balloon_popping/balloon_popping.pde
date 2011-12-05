import processing.serial.*;

final static int CANVAS_WIDTH = 1200;
final static int CANVAS_HEIGHT = 600;
int numBalls = 50;
float gravity = 0.01;
float friction = -0.0;
Ball[] balls = new Ball[numBalls];
int xpos = 0, ypos = 0;
char keypress;
int count = 0;
int score = 0;
int angle = 0;
PFont fontA;
Boolean bool[] = new Boolean[150];
int stage = 1;
Boolean stageone = true;
Boolean stagetwo = false;
Boolean stagethree = false;

void setup() 
{  
  __setup(this);

  //for score  
  fontA = loadFont("CourierNew36.vlw");
  textFont(fontA, 32);  
  
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
  noStroke();
  smooth();   
 
 
}

void draw() 
{
  // needed for all stages
  background(255);
  draw_pointer();
  displayScore();
  
  if (stageone == true) {    
     // ball for stage 1     
    for (int b = 0; b < numBalls; b++){
      bool[b] = true;
      balls[b] = new Ball(random(width), 20, random(30, 50), 1, balls);    
    }
    stageone = false;
  }
  
  if (score >= 5 && stagetwo == false) {
    stagetwo = true;
    count = 0;
    for (int b = 0; b < numBalls; b++){
      bool[b] = true;
      balls[b] = new Ball(random(width), 20, random(50, 80), 1, balls);    
    }
    
  }
  
  
    
  while(port.available() > 0) {
    serialEvent(port.read());
  }
    
  //stage 1
  
      firstStage();
      
  
  
}

class Ball {
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  int colors;
  char ballcol;
  Ball[] others;  
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {    
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
    
    if (stagetwo == false) colors = int(random(0,3));
    else if (stagetwo == true) colors = int(random(0,4));
   
  } 
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    switch (this.colors) {
      case 0:
        fill(255, 0, 0);
        ballcol = 'r';
        break;
      case 1:
        fill(0, 255, 0);
        ballcol = 'g';
        break;
      case 2:
        fill(0, 0, 255);
        ballcol = 'b';
        break;     
      case 3:
        fill(0, 0, 0);
        ballcol = 'l';
        break;        
    }    
    ellipse(x, y, diameter, diameter);
  }
}

void firstStage()
{
  if (fsr > 10) {
    popBalloon();
  }
    
  for (int b = 0; b<numBalls; b++)
  {
    if(count>=b*100 && bool[b] == true)
    {
      balls[b].move();
      balls[b].display();
    }    
  }
  
  count++;    
  for (int z = 0; z < numBalls; z++) if (balls[z].y >=(CANVAS_HEIGHT - 100)) bool[z] = false;   
  
}


void secondStage()
{
  for (int i = 0; i < numBalls; i++) balls[i].x = 20;  
  
}





void popBalloon()
{
    float xpos = calibrate_x();
    float ypos = calibrate_y();
    
    createExplosion();
    
    for(int z = 0; z<50; z++){
      float rx = balls[z].x + 70;
      float lx = balls[z].x - 70;
      float uy = balls[z].y + 70;
      float ly = balls[z].y - 70;
    
      if((xpos>=lx&&xpos<=rx)&&(ypos<=uy&&ypos>=ly) && setCol()==balls[z].ballcol && bool[z] != false) {
        bool[z] = false;     
        score++;        
      }  
      
      if((xpos>=lx&&xpos<=rx)&&(ypos<=uy&&ypos>=ly)&& balls[z].ballcol == 'l' && bool[z] != false){
        bool[z] = false;
        score--;
      }
    }
}

void draw_pointer()
{
    float w = 20, h = 20;
    float xpos = 0, ypos = 0;
    
    xpos = calibrate_x();
    ypos = calibrate_y();    
    
    if (setCol() == 'r') fill(255, 0, 0);
    else if(setCol() == 'g') fill(0, 255, 0);
    else if(setCol() == 'b') fill(0, 0, 255);
    ellipse((float)xpos, (float)ypos, w, h);
}

char setCol()
{
  char col = 'r';
  
  if (deg >= 0 && deg < 120) col = 'r';
  else if (deg >= 120 && deg < 240) col = 'g';
  else if (deg >= 240 && deg < 360) col = 'b';
  
  return col;
    
}

void displayScore()
{
  fill(0);
  text("Score: " + score, 1020, 30);  
}

void createExplosion()
{
  float xpos = calibrate_x();
  float ypos = calibrate_y();
  if (fsr >= 10) {
    angle += 10;
    float val = cos(radians(angle)) * 20.0;
    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      if (setCol() == 'r') fill(255, 0, 0);
      else if(setCol() == 'g') fill(0, 255, 0);
      else if(setCol() == 'b') fill(0, 0, 255);
      ellipse(xpos + xoff, ypos + yoff, val, val);
    }
    fill(255);
    ellipse(xpos, ypos, 2, 2);
  }
  
}

/* for computer input
 * 
 */
void mousePressed()
{
  
    xpos = mouseX;
    ypos = mouseY;
    
    for(int z = 0; z<50; z++){
      float rx = balls[z].x + 50;
      float lx = balls[z].x - 50;
      float uy = balls[z].y + 50;
      float ly = balls[z].y - 50;
    
      if((xpos>=lx&&xpos<=rx)&&(ypos<=uy&&ypos>=ly)&&keypress==balls[z].ballcol&& bool[z] != false) {
        bool[z] = false;
        score++;
        createExplosion();
      }
      println(score);
      
      if((xpos>=lx&&xpos<=rx)&&(ypos<=uy&&ypos>=ly)&& balls[z].ballcol == 'l' && bool[z] != false){
        bool[z] = false;
        score--;
      }
      
  }
  
}
void keyPressed()
{
    switch (key) {
        case ('r'):
            keypress = 'r';
            break;
        case ('g'):
            keypress = 'g';
            break;
        case ('b'):
            keypress = 'b';
    } 
}

