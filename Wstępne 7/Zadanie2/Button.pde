public interface ButtonEvent {
    public void invoke();
}

public class Button {
  private color _selectedColor;
  private color _color;
  private float _x;
  private float _y;
 
 private boolean _selected = false;
 
 private ArrayList<ButtonEvent> events = new ArrayList<ButtonEvent>();
 
 public Button() {
   this(0, 0, color(255), color(0));
 }
 
 public Button(float x, float y, color Color, color selectedColor) {
  _x = x;
  _y = y;
  _color = Color;
  _selectedColor = selectedColor;
 }
 
 public void setX(float x) {
  _x = x; 
 }
 
 public void setY(float y) {
   _y = y;
 }
 
 public float getX() {
  return _x; 
 }
 
 public float getY() {
  return _y; 
 }
 
 public color getCurrentColor() {
  if (_selected) {
   return _selectedColor; 
  }
  return _color;
 }
 
 public void draw() {

 }
 
 public void addCallback(ButtonEvent event) {
     events.add(event);
 }
 
 public void select() {
   _selected = true;
 }
 
 public void deselect() {
  _selected = false; 
 }
 
 public boolean isIn(float x, float y) {
  return x == _x && y == _y;
 }
 
 public void mousePressed() {
   if (isIn(mouseX, mouseY)) {
       for (int i = 0; i < events.size(); i++) {
          events.get(i).invoke();
       }
       select();
   }
 }
}
