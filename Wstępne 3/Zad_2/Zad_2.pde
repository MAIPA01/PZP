float y;
int dir = 0;
 
void setup() {
  size(500, 500);
  stroke(255);
  strokeWeight(5);
  y = height * 0.5;
}
 
void draw() {
  y += 5 * dir;
  if (y < 0) y = height;
  if (y > height) y = 0;
  
  background(0);
  line(0, y, width, y);
}

void mousePressed() {
  if (mouseY > height / 2.f) dir = 1;
  else if (mouseY < height / 2.f) dir = -1;
}

void keyPressed() {
  if (key == CODED) {
    // keyDown
    if (keyCode == 38) {
       dir = -1; 
    }
    // keyUp
    if (keyCode == 40) {
      dir = 1;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    // keyDown
    if (keyCode == 38) {
      dir = 0;
    }
    // keyUp
    if (keyCode == 40) {
      dir = 0;
    }
  }
}
