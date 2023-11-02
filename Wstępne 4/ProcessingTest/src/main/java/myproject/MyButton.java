package myproject;
import processing.core.PApplet;

public class MyButton {
    private PApplet a;
    private int x, y, w, h;
    private int r, g, b;

    MyButton(int tempX, int tempY, int tempW, int tempH, int tempR, int tempG, int tempB, PApplet tempA) {
        x = tempX; y = tempY;
        w = tempW; h = tempH;
        r = tempR; g = tempG;
        b = tempB; a = tempA;
    }

    MyButton(int tempX, int tempY, int tempW, int tempH, PApplet tempA) {
        x = tempX; y = tempY;
        w = tempW; h = tempH;
        r = 255; g = 0; b = 255;
        a = tempA;
    }

    void display() {
        a.strokeWeight(2);
        a.fill(r, g, b);
        a.rect(x, y, w, h);
    }

    boolean inside(int tempX, int tempY) {
        if(tempX >= x && tempX <= x+w && tempY >= y && tempY <= y+h)
            return true;
        else
            return false;
    }

    int getR() { return r; }
    int getG() { return g; }
    int getB() { return b; }
}
