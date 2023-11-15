public class CircleButton extends Button {
  public CircleButton(float x, float y, float Radius, color Color, color selectedColor) {
    super(x, y, Radius, Radius, Color, selectedColor, "", 1, color(0), null);
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
   circle(0, 0, super._width);
   popStyle();
   popMatrix();
 }
  
 public boolean isIn(float x, float y) {
   float xDiff = super._x - x;
   float yDiff = super._y - y;
   return xDiff*xDiff + yDiff*yDiff <= (super._width / 2f) * (super._width / 2f);
 }
}
