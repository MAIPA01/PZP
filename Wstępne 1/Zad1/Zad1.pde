interface XD {
  float calc(float a);
};

void setup() {
  size(400, 200);
  noLoop();
}

void draw() {
  rectMode(CENTER);
  
  // Niebo
  background(0, 150, 255);
  
  // Trawa
  fill(0, 255, 0);
  noStroke();
  rect(200, 175, 400, 50);
  
  // Inne rzeczy
  stroke(0, 0, 255);
  strokeWeight(5);
  
  // Słońce
  fill(255, 255, 0);
  float alpha = 0;
  XD radians = (a) -> { return a * PI / 180; };
  line(400 - 40 * cos(radians(alpha)), 40 * sin(radians(alpha)), 400 - 70 * cos(radians(alpha)), 70 * sin(radians(alpha)));
  alpha += 20;
  line(400 - 40 * cos(radians(alpha)), 40 * sin(radians(alpha)), 400 - 70 * cos(radians(alpha)), 70 * sin(radians(alpha)));
  alpha += 20;
  line(400 - 40 * cos(radians(alpha)), 40 * sin(radians(alpha)), 400 - 70 * cos(radians(alpha)), 70 * sin(radians(alpha)));
  alpha += 20;
  line(400 - 40 * cos(radians(alpha)), 40 * sin(radians(alpha)), 400 - 70 * cos(radians(alpha)), 70 * sin(radians(alpha)));
  alpha += 20;
  line(400 - 40 * cos(radians(alpha)), 40 * sin(radians(alpha)), 400 - 70 * cos(radians(alpha)), 70 * sin(radians(alpha)));
  alpha += 20;
  line(400 - 40 * cos(radians(alpha)), 40 * sin(radians(alpha)), 400 - 70 * cos(radians(alpha)), 70 * sin(radians(alpha)));
  circle(400, 0, 60);
  
  // Chmury
  fill(255);
  circle(30, 20, 30);
  circle(50, 20, 30);
  circle(20, 30, 30);
  circle(40, 30, 30);
  circle(60, 30, 30);
  
  float offset = 150;
  circle(30 + offset, 20, 30);
  circle(50 + offset, 20, 30);
  circle(20 + offset, 30, 30);
  circle(40 + offset, 30, 30);
  circle(60 + offset, 30, 30);
  
  // Osoba 1
  fill(255, 0, 0);
  rect(100, 100, 20, 100);
  fill(0);
  ellipse(100, 70, 60, 60);
  fill(0, 255, 0);
  ellipse(81, 70, 16, 32);
  fill(255);
  ellipse(119, 70, 16, 32);
  fill(0, 0, 255);
  line(90, 150, 80, 160);
  line(110, 150, 120, 160);
  
  // Osoba 2
  fill(255, 0, 0);
  rect(300, 100, 20, 100);
  fill(0);
  ellipse(300, 70, 60, 60);
  fill(0, 255, 0);
  ellipse(319, 70, 16, 32);
  fill(255);
  ellipse(281, 70, 16, 32);
  fill(0, 0, 255);
  line(290, 150, 280, 160);
  line(310, 150, 320, 160);
}
