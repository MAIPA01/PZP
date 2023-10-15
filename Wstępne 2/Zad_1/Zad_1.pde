float difference, brightness, sunAngle = 0, moonAngle = 0;
int i = 0;

void drawPlanet(float orbitSpeed, float selfSpeed, float orbit, float rectWidth, float rectHeight, color Color, int iteration) {
  float orbitAngle = (iteration * orbitSpeed) % 360;
  float selfAngle = (iteration * selfSpeed) % 360;
  
  fill(Color);
  rotate(orbitAngle);
  translate(orbit, 0);
  pushMatrix();
  rotate(selfAngle);
  rectMode(CENTER);
  rect(0, 0, rectWidth, rectHeight);
  rectMode(CORNER);
  popMatrix();
}

void drawMoon(float orbitSpeed, float selfSpeed, float orbit, float TriangleSize, color Color, int iteration) {
  float orbitAngle = (iteration * orbitSpeed) % 360;
  float selfAngle = (iteration * selfSpeed) % 360;
  
  fill(Color);
  pushMatrix();
  rotate(orbitAngle);
  translate(orbit, 0);
  rotate(selfAngle);
  triangle(-10 * TriangleSize, -10 * TriangleSize, 0, 7.32 * TriangleSize, 10 * TriangleSize, -10 * TriangleSize);
  popMatrix();
}

void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  difference = 0.5;
  brightness = 0;
}

void draw() {
  background(0);
  
  // Słońce
  fill(60, 100, brightness);
  translate(500, 500);
  pushMatrix();
  rotate(sunAngle);
  ellipse(0, 0, 200, 150);
  popMatrix();
  
  // Square Planet
  pushMatrix();
  drawPlanet(0.01, 0.1, 400.0, 100.0, 100.0, color(10, 100, 100), i);
  
  // Triangle Moon
  drawMoon(0.01, 0.1, 100.0, 2, color(255, 100, 100), i);
  popMatrix();
  
  // Kolejna planeta
  drawPlanet(0.02, 0.01, 600, 200, 200, color(40, 100, 100), i);
  drawMoon(0.005, 0.01, 50, 1, color(200, 100, 100), i);
  drawMoon(0.2, 0.2, 70, 2, color(140, 100, 100), i);
  
  brightness += difference;
  if(brightness > 100 || brightness < 0) difference *= -1;
  i += 1;
  sunAngle += 0.01;
  sunAngle %= 360;
  moonAngle += 0.1;
  moonAngle %= 360;
}
