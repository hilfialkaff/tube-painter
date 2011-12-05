PGraphics canvas;
final static int MAX_COLORS = 255 * 255 * 255;
static int colors = 0; 

void splash(float x, float y)
{
    int rad = 17;
    canvas.beginDraw();

    for (float i=3; i<29; i+=.35) {
        float angle = random(0, TWO_PI);
        float splatX = x + cos(angle)*2*i;
        float splatY = y + sin(angle)*3*i;

        canvas.ellipse(splatX, splatY, rad-i, rad-i+1.8);
    }

    canvas.endDraw();
}

void paint_brush()
{
    if (mousePressed || (fsr > 10)) {
        zPosition += (50.0f - zPosition) / 10.0f;
    }
    else {
        zPosition += (-50.0f - zPosition) / 10.0f;
    }

    set_color();
    
    if (USE_TUBE == 1) {
      brush.moveTo(calibrate_x(), calibrate_y(), zPosition);
    } else {
      brush.moveTo(mouseX, mouseY, zPosition);
    }
    brush.animate();
    brush.paint();
}

void shake_color()
{
    int r, g, b;

    colors = int(random(0, MAX_COLORS));

    r = colors & 0xFF;
    g = (colors >> 8) & 0xFF;
    b = (colors >> 16) & 0xFF;

    canvas.fill(r, g, b);
}

double predeg;
final static float THRESHOLE = 0.5;

void set_color()
{
    int r, g, b;
    Pigment pigment;   
    int colors = (int)(deg * pow(256, 3) / 360);

    if (abs((float)(deg - predeg)) < THRESHOLE) {
      return;
    }
    
    r = colors & 0xFF;
    g = (colors >> 8) & 0xFF;
    b = (colors >> 16) & 0xFF;

    pigment = new Pigment(r, g, b, 0);
    
    if (DEBUG) {
        print("colors: " + colors + "deg: " + deg + "r: " + r + " g: " +  g + " b: " + b);
        println();
    }

    for(int i = 0;i < 20;i++) {
      brush.setPiecePigment(i, pigment);
    }
    
    predeg = deg;
}
