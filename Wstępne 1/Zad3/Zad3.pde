void drawStar(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;
  beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
  endShape(CLOSE);
}

void drawNAngle(float x, float y, float size, int n) {
  float angle = TWO_PI / n;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
     float sx = x + cos(a) * size;
     float sy = y + sin(a) * size;
     vertex(sx, sy);
  }
  endShape(CLOSE);
}

void setup() {
    size(800, 600);
}

void draw() {
  drawStar(width / 2f, height / 2f, 30, 50, 10);
  drawNAngle(100, 100, 40, 6);
}
