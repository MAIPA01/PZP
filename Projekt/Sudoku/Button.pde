public interface ButtonAction {
 void Invoke(); 
}

public class Button {
 private float _x, _y, _w, _h;
 private color _color;
 private boolean _hasStroke;
 private float _strokeWeight;
 private color _strokeColor;
 private ArrayList<ButtonAction> _actions = new ArrayList<ButtonAction>();
 
 Button(float x, float y, float w, float h) {
  this(x, y, w, h, color(255)); 
 }
 
 Button(float x, float y, float w, float h, color col) {
   this(x, y, w, h, col, false, 0, color(0));
 }
 
 Button(float x, float y, float w, float h, color col, boolean hasStroke, float strokeWeight, color strokeColor) {
  _x = x;
  _y = y;
  _w = w;
  _h = h;
  _color = col;
  _hasStroke = hasStroke;
  _strokeWeight = strokeWeight;
  _strokeColor = strokeColor;
 }
 
 public void addAction(ButtonAction a) {
  _actions.add(a); 
 }
 
 public void display() {
    pushMatrix();
    pushStyle();
    
    rectMode(CENTER);
    if (_hasStroke) {
     strokeWeight(_strokeWeight);
     stroke(_strokeColor);
    }
    else {
     noStroke(); 
    }
    fill(_color);
    translate(_x, _y);
    rect(0, 0, _w, _h);

    popStyle();
    popMatrix();
 }
 
 public boolean isInside(float x, float y) {
  return x >= _x - _w / 2f && x <= _x + _w / 2f && y >= _y - _h / 2f && y <= _y + _h / 2f;
 }
 
 public void mousePressed() {
   if (mouseButton == LEFT && isInside(mouseX, mouseY)) {
     for (ButtonAction a : _actions) {
       a.Invoke();
     }
   }
 }
}
