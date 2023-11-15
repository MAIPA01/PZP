public class Line {
 private float x1;
 private float y1;
 private float x2;
 private float y2;
 
 private float size;
 private color colour;
 
 public Line(float x1, float y1, float x2, float y2, float size, color colour) {
    this.x1 = x1; 
    this.y1 = y1; 
    this.x2 = x2; 
    this.y2 = y2; 
    this.size = size;
    this.colour = colour;
 }
 
 public void draw() {
   pushMatrix();
   pushStyle();
   strokeWeight(size);
   stroke(colour);
   fill(colour);
    line(x1, y1, x2, y2);
    popStyle();
    popMatrix();
 }
}
