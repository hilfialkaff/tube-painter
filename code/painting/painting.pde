/*
 * NOTE: THIS IS A SIMULATION OF THE ACTUAL PAINTING PROGRAM FROM THE HARDWARE.
 *
 * mouseX -> x reading from accelerometer
 * mouseY -> y reading from accelerometer
 * 'mousePressed' -> splash the colors
 * ___ -> z reading from accelerometer (unknown)
 * 'a' -> rotating the tube clockwise (disabled)
 * 'd' -> rotating the tube counterclockwise (disabled)
 * 's' -> shaking the tube
 */

final static boolean DEBUG = false;

final static int CANVAS_HEIGHT = 500, CANVAS_WIDTH = 500;
final static int HEIGHT = 10, WIDTH = 10;

void setup()
{
    size(CANVAS_WIDTH, CANVAS_HEIGHT);
    background(255, 255, 255);

    canvas = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT, JAVA2D);
    canvas.beginDraw();
    canvas.smooth();
    canvas.colorMode(HSB, 360, 100, 100);
    canvas.fill(0, 0, 0);
    canvas.noStroke();
    canvas.endDraw();
}

void draw()
{
    image(canvas, 0, 0);
}

void mousePressed()
{
    splash(mouseX, mouseY);
}

void keyPressed()
{
    switch (key) {
        //case ('a'):
        //    set_color(100);
        //case ('d'):
        //    set_color(-100);
        case ('s'):
            shake_color();
    } 
}
