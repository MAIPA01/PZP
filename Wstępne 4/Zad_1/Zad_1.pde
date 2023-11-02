float sWidth = 10f;

class Line {
 public float x1;
 public float y1;
 public float x2;
 public float y2;
 
 public float sWidth;
 
 public Line(float x1, float y1, float x2, float y2, float sWidth) {
    this.x1 = x1; 
    this.y1 = y1; 
    this.x2 = x2; 
    this.y2 = y2; 
    this.sWidth = sWidth; 
 }
 
 public void draw() {
   strokeWeight(sWidth);
    line(x1, y1, x2, y2);
 }
}

class Ellipse {
 public float radiusX;
 public float radiusY;
 
 public float x;
 public float y;
 
 public float sWidth;
 
 public Ellipse(float x, float y, float rX, float rY, float sWidth) {
  this.radiusX = rX;
  this.radiusY = rY;
  this.x = x;
  this.y = y;
  this.sWidth = sWidth;
 }
 
 public void draw() {
   strokeWeight(sWidth);
   ellipse(x, y, radiusX, radiusY);
 }
}

ArrayList<Line> lines = new ArrayList<Line>();
ArrayList<Ellipse> ellipses = new ArrayList<Ellipse>();

void setup() {
  //fullScreen();
  size(800, 600);
}

void draw() {
  background(0);
  fill(255);
  stroke(255);
  
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).draw();
  }
  
  for (int i = 0; i < ellipses.size(); i++) {
    ellipses.get(i).draw();
  }
  
  /*strokeWeight(0f);
  stroke(0f);
  fill(255, 0, 0);
  circle(mouseX, mouseY, sWidth);*/
  
  //strokeWeight(sWidth);
  if(mousePressed) {
    //lines.add(new Line(mouseX, mouseY, pmouseX, pmouseY, sWidth));
    ellipses.add(new Ellipse(mouseX, mouseY, abs(pmouseX - mouseX), abs(pmouseY - mouseY), sWidth));
    //line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void keyPressed() {
  if (keyCode != CODED) {
    // UP
    if (keyCode == 38) {
      sWidth += 1f;
    }
    // DOWN
    if (keyCode == 40) {
      sWidth -= 1f;
      if (sWidth < 0f) sWidth = 0f;
    }
  }
}
