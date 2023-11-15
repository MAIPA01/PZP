public class TextButton extends Button {
 public TextButton(float x, float y, float Width, float Height, color Color, color selectedColor, String text, float textSize, color textColor, PFont font) {
  super(x, y, Width, Height, Color, selectedColor, text, textSize, textColor, font);
 }
 
 public void draw() {
   pushMatrix();
   pushStyle();
   if (super._selected) {
     strokeWeight(5);
     stroke(super._selectedColor);
   }
   else {
    strokeWeight(0); 
   }
   translate(super._x, super._y);
   rectMode(CENTER);
   fill(super._color);
   rect(0, 0, super._width, super._height);
   if (super._font != null) {
   fill(super._textColor);
   textFont(super._font);
   textSize(super._textSize);
   text(super._text, -super._textSize / 2f * super._text.length(), super._textSize / 2f);
   }
   popStyle();
   popMatrix();
 }
 
  public boolean isIn(float x, float y) {
  return x <= super._x + super._width / 2f && x >= super._x - super._width / 2f && y <= super._y + super._height / 2f && y >= super._y - super._height / 2f;
 }
}
