float x, y, angle, radius;  

void setup() {
  size(700, 700);
  noStroke();
  rectMode(CENTER);
  radius = 70;
}  

void draw() {
  background(0);
  angle += 2;
  x = width / 2 + (radius * cos(radians(angle)));
  fill(0, 102, 153);
  rect(width / 2, height / 2, radius * 3, radius * 3);
  fill(255, 204, 0);
  circle(x, height / 2 - radius * 1.75, radius);
  
  y = height / 2 + (radius * cos(radians(angle)));
  circle(width / 2 + radius * 1.75, y, radius);
  
  x = width / 2 + (radius * sin(radians(angle)));
  circle(x, height / 2 + radius * 1.75, radius);
  
  y = height / 2 + (radius * sin(radians(angle)));
  circle(width / 2 - radius * 1.75, y, radius);
}  
