import processing.serial.*;


// port needed
//String portname = "COM7"; // or "COM5"
//Serial port;




final static int CANVAS_WIDTH = 1200;
final static int CANVAS_HEIGHT = 600;
int numBalls = 50;
float gravity = 0.01;
float friction = -0.0;
Ball[] balls = new Ball[numBalls];
int xpos = 0, ypos = 0;
char keypress;
int score = 0;

Boolean bool[] = new Boolean[50];


void setup() 
{
  //port = new Serial(this, portname, 9600);
  __setup(this);
  
  
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
  noStroke();
  smooth();  
  for (int b = 0; b < 50; b++){
    bool[b] = true;
    balls[b] = new Ball(random(width), 20, random(30, 50), 1, balls);
  }  
}

void draw_pointer()
{
    float w = 10, h = 10;
    float xpos = 0, ypos = 0;
    
    xpos = calibrate_x();
    ypos = calibrate_y();
    
  fill(0);
  ellipse((float)xpos, (float)ypos, w, h);
}

void popBalloon()
{
    float xpos = calibrate_x();
    float ypos = calibrate_y();
    
    for(int z = 0; z<50; z++){
      float rx = balls[z].x + 50;
      float lx = balls[z].x - 50;
      float uy = balls[z].y + 50;
      float ly = balls[z].y - 50;
    
      if((xpos>=lx&&xpos<=rx)&&(ypos<=uy&&ypos>=ly)) {
        bool[z] = false;
      }  
    }
}

int count = 0;
void draw() 
{
  background(255);
    
    while(port.available() > 0) {
      serialEvent(port.read());
    }
    
    if (fsr > 10) {
      popBalloon();
    }
    
  for (int b = 0; b<50; b++)
  {
    if(count>=b*100 && bool[b] == true)
    {
      balls[b].move();
      balls[b].display();
    }    
  }
  
  draw_pointer();
  
  count++;    
  for (int z = 0; z < 50; z++) if (balls[z].y >=(CANVAS_HEIGHT - 100)) bool[z] = false;
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
    colors = int(random(0,3));
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
    }    
    ellipse(x, y, diameter, diameter);
  }
}

void mousePressed()
{
    xpos = mouseX;
    ypos = mouseY;
    
    for(int z = 0; z<50; z++){
    float rx = balls[z].x + 50;
    float lx = balls[z].x - 50;
    float uy = balls[z].y + 50;
    float ly = balls[z].y - 50;
    
    if((xpos>=lx&&xpos<=rx)&&(ypos<=uy&&ypos>=ly)&&keypress==balls[z].ballcol) {
    bool[z] = false;
    score++;}
    println(score);
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

