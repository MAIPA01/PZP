public interface ButtonAction {
 void Invoke(); 
}

public class Button extends GameObject {
 private float _w, _h;
 private color _color;
 private boolean _hasStroke;
 private float _strokeWeight;
 private color _strokeColor;
 private ArrayList<ButtonAction> _actions = new ArrayList<ButtonAction>();
 
 Button(PVector pos, float w, float h) {
   this(pos.x, pos.y, w, h);
 }
 
 Button(float x, float y, float w, float h) {
  this(x, y, w, h, color(255)); 
 }
 
 Button(float x, float y, float w, float h, color col) {
   this(x, y, w, h, col, false, 0, color(0));
 }
 
 Button(float x, float y, float w, float h, color col, boolean hasStroke, float strokeWeight, color strokeColor) {
  super(x, y);
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
    PVector pos = getPosition();
    translate(pos.x, pos.y);
    rect(0, 0, _w, _h);

    popStyle();
    popMatrix();
 }
 
 public boolean isInside(float x, float y) {
   PVector pos = getPosition();
  return x >= pos.x - _w / 2f && x <= pos.x + _w / 2f && y >= pos.y - _h / 2f && y <= pos.y + _h / 2f;
 }
 
 public void mousePressed() {
   if (mouseButton == LEFT && isInside(mouseX, mouseY)) {
     for (ButtonAction a : _actions) {
       a.Invoke();
     }
   }
 }
 
 public void setStrokeWeight(float strokeWeight) {
   _strokeWeight = strokeWeight;
 }
 
 public void setStrokeColor(color strokeColor) {
   _strokeColor = strokeColor;
 }
 
 public void setHasStroke(boolean hasStroke) {
   _hasStroke = hasStroke;
 }
 
 public void setColor(color Color) {
   _color = Color;
 }
}
