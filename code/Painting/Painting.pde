/*
 * NOTE: THIS IS A SIMULATION OF THE ACTUAL PAINTING PROGRAM FROM THE HARDWARE.
 *
 * mouseX -> x reading from accelerometer
 * mouseY -> y reading from accelerometer
 * ___ -> z reading from accelerometer
 * 'a' -> rotating the tube clockwise
 * 'd' -> rotating the tube counterclockwise
 */

final static boolean DEBUG = false;

final static int CANVAS_HEIGHT = 500, CANVAS_WIDTH = 500;
final static int HEIGHT = 10, WIDTH = 10;
final static int MAX_COLORS = 255 * 255 * 255;

static int colors = 0; 

void setup()
{
    size(CANVAS_WIDTH, CANVAS_HEIGHT);
    background(255, 255, 255);
}

void draw()
{
    ellipse(mouseX, mouseY, WIDTH, HEIGHT);
}

void change_color(int rotation)
{
    int r, g, b;

    if ((colors + rotation) < 0 && (colors + rotation) > MAX_COLORS) {
        return;
    }

    colors += rotation;

    r = colors & 0xFF;
    g = (colors >> 8) & 0xFF;
    b = (colors >> 16) & 0xFF;

    if (DEBUG) {
        print("r: " + r + " g: " +  g + " b: " + b);
        println();
    }

    fill(r, g, b);
}

void keyPressed()
{
    switch (key) {
        case ('a'):
            change_color(100);
        case ('d'):
            change_color(-100);
    } 
}
