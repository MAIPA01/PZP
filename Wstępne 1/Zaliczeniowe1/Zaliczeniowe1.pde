void drawFigure(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
  endShape(CLOSE);
}

int colorIndex = 0;

color[] bgColor = {
  color(255),
  color(197, 197, 197),
  color(254, 255, 38)
};

color[] triangleColor = {
  color(77, 80, 87),
  color(254, 93, 38),
  color(39, 39, 39)
};

color[] rectangleColor = {
  color(197, 197, 197),
  color(242, 192, 120),
  color(0, 159, 183)
};

color[] ellipseColor = {
  color(35, 150, 127),
  color(250, 237, 202),
  color(105, 103, 115)
};

color[] circleColor = {
  color(215, 38, 61),
  color(193, 219, 179),
  color(221, 110, 66)
};

color[] hexagonColor = {
  color(244, 228, 9),
  color(126, 188, 137),
  color(216, 164, 143)
};

void drawTriangles(float bL, float bR, float bU, float bD, int num) {
  fill(triangleColor[colorIndex]);
  rectMode(CORNER);
  for (int i = 0; i < num; i++) {
    triangle(random(bL, bR), random(bU, bD), random(bL, bR), random(bU, bD), random(bL, bR), random(bU, bD));
  }
}

void drawRectangles(float bL, float bR, float bU, float bD, int num) {
  fill(rectangleColor[colorIndex]);
  rectMode(CORNER);
  for (int i = 0; i < num; i++) {
    rect(random(bL, bR), random(bU, bD), random(bL, bR), random(bU, bD));
  }
}

void drawEllipses(float bL, float bR, float bU, float bD, int num) {
  fill(ellipseColor[colorIndex]);
  rectMode(CENTER);
  for (int i = 0; i < num; i++) {
    float x = random(bL, bR);
    float y = random(bU, bD);
    float sizeX = min(abs(x - random(bL, bR)), abs(x - bL), abs(x - bR));
    float sizeY = min(abs(y - random(bU, bD)), abs(y - bU), abs(y - bD));
    ellipse(x, y, sizeX, sizeY);
  }
}

void drawCircles(float bL, float bR, float bU, float bD, int num) {
  fill(circleColor[colorIndex]);
  rectMode(CENTER);
  for (int i = 0; i < num; i++) {
    float x = random(bL, bR);
    float y = random(bU, bD);
    float r = min(min(abs(x - random(bL, bR)), abs(x - bL), abs(x - bR)), min(abs(y - random(bU, bD)), abs(y - bU), abs(y - bD)));
    circle(x, y, r);
  }
}

void drawHexagons(float bL, float bR, float bU, float bD, int num) {
  fill(hexagonColor[colorIndex]);
  for (int i = 0; i < num; i++) {
    float x = random(bL, bR);
    float y = random(bU, bD);
    float r = min(min(abs(x - random(bL, bR)), abs(x - bL), abs(x - bR)), min(abs(y - random(bU, bD)), abs(y - bU), abs(y - bD)));
    drawFigure(x, y, r, 6);
  }
}

// LOGO
PFont nameFont;
PFont surnameFont;

void drawLogo(float x, float y, float size) {
  textAlign(CENTER, CENTER);
  textFont(surnameFont);
  textSize(size);
  fill(255, 0, 0);
  text("Antosik", x - (20f * size) / 100f, y + (60f * size) / 100f);
  textFont(nameFont);
  textSize(size);
  fill(255);
  text("Patryk", x, y - (20f * size) / 100f);
}

void setup() {
  size(800, 600);
  colorIndex = (int)(random(bgColor.length));
  
  nameFont = createFont("./Shintia.otf", 50);
  surnameFont = createFont("./SouthernAire.ttf", 50);
  
  noLoop();
}

void draw() {
  background(bgColor[colorIndex]);
  
  // triangles
  drawTriangles(0f, width / 3f, 0f, height / 2f, (int)random(1, 10));
  
  // rectangles
  drawRectangles((2f * width) / 3f, width, height / 2f, height, (int)random(1, 10));
  
  // ellipses
  drawEllipses(0f, width / 3f, height / 2f, height, (int)random(1, 10));
  
  //circles
  drawCircles((2f * width) / 3f, width, 0f, height / 2f, (int)random(1, 10));
  
  //hexagons
  drawHexagons(width / 3f, (2f * width) / 3f, 0f, height, (int)random(1, 10));
  
  drawLogo(width / 2f, height / 2f, 100);
}
