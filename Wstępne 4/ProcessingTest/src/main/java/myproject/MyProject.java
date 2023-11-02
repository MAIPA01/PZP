package myproject;
import processing.core.PApplet;

public class MyProject extends PApplet {

    MyButton button1, button2;

    public void settings() {
        size(400, 400);
    }

    public void setup() {
        button1 = new MyButton(100, 100, 200, 75, 255, 255, 0, this);
        button2 = new MyButton(100, 225, 200, 75, this);
    }

    public void draw() {
        if(button1.inside(mouseX, mouseY))
            background(button1.getR(), button1.getG(), button1.getB());
        else if(button2.inside(mouseX, mouseY))
            background(button2.getR(), button2.getG(), button2.getB());
        else background(0);
        button1.display();
        button2.display();
    }

    public static void main(String _args[]) {
        PApplet.main(new String[] { myproject.MyProject.class.getName() });
    }
}