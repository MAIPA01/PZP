public class Button {
  private PFont _font;
  private String _text;
  private float _textSize;
  private color _textColor;
  private color _selectedColor;
  private color _color;
  private float _x;
  private float _y;
 private float _width;
 private float _height;
 
 private boolean _selected = false;
 
 public Button(float x, float y, float Width, float Height, color Color, color selectedColor, String text, float textSize, color textColor, PFont font) {
  _x = x;
  _y = y;
  _width = Width;
  _height = Height;
  _color = Color;
  _selectedColor = selectedColor;
  _text = text;
  _textSize = textSize;
  _textColor = textColor;
  _font = font;
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
 
 public void draw() {

 }
 
 public void select() {
   _selected = true;
 }
 
 public void deselect() {
  _selected = false; 
 }
 
 public boolean isIn(float x, float y) {
  return false;
 }
}
