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

void shake_color()
{
    int r, g, b;

    colors = int(random(0, MAX_COLORS));

    r = colors & 0xFF;
    g = (colors >> 8) & 0xFF;
    b = (colors >> 16) & 0xFF;

    canvas.fill(r, g, b);
}

//void set_color(int rotation)
//{
//    int r, g, b;
//
//    if ((colors + rotation) < 0 && (colors + rotation) > MAX_COLORS) {
//        return;
//    }
//
//    colors += rotation;
//
//    r = colors & 0xFF;
//    g = (colors >> 8) & 0xFF;
//    b = (colors >> 16) & 0xFF;
//
//    if (DEBUG) {
//        print("r: " + r + " g: " +  g + " b: " + b);
//        println();
//    }
//
//    fill(r, g, b);
//}

