float angle, currAngle, maxAngle, minAngle;
PFont font;

float lastSecond = 0;

boolean closed = false;

void setup() {
  size(700, 700);
  noStroke();
  rectMode(CENTER);
  colorMode(HSB, 360, 100, 100);
  maxAngle = -50;
  minAngle = -20;
  
  font = createFont("./SouthernAire.ttf", 50);
  
  lastSecond = second();
}

void draw() {
  background(0);
  fill(0, 0, 50);
  
  // Głowa
  rect(width / 2, height / 2 - 200, 100, 100);
  
  // Tłów
  rect(width / 2, height / 2, 150, 200);
  
  // Ręka Lewa
  rect(width / 2 - 100, height / 2 - 50, 20, 70);
  rect(width / 2 - 100, height / 2 - 50 + 80, 20, 70);
  rect(width / 2 - 100, height / 2 - 50 + 70 + 65, 20, 20);
  
  // Zegar
  textFont(font);
  textSize(70);
  fill(0, 0, 100);
  var hour =  hour() < 10 ? "0" + hour() : hour();
  var minute =  minute() < 10 ? "0" + minute() : minute();
  var second =  second() < 10 ? "0" + second() : second();
  text(hour + ":" + minute + ":" + second, width / 2.f - 50, height / 2.f);
  
  // Ręka Prawa Machająca
  pushMatrix();
  
  angle += 100 / frameRate;
  currAngle = (maxAngle - minAngle) * sin(radians(angle)) + (maxAngle + minAngle);
  
  fill(0, 0, sin(radians(angle)) * 40 + 60);
  
  translate(width / 2 + 100, height / 2 - 50);
  rotate(radians(currAngle));
  float x = sin(radians(currAngle)) * 35;
  float y = x / tan(radians((180 - currAngle) / 2.f));
  translate(-x, y);
  rect(0, 0, 20, 70);
  
  translate(0, 80);
  rotate(radians(currAngle));
  x = sin(radians(currAngle)) * 35;
  y = x / tan(radians((180 - currAngle) / 2.f));
  translate(-x, y);
  rect(0, 0, 20, 70);
  
  translate(0, 55);
  rotate(radians(currAngle));
  x = sin(radians(currAngle)) * 10;
  y = x / tan(radians((180 - currAngle) / 2.f));
  translate(-x, y);
  rect(0, 0, 20, 20);
  
  popMatrix();
  
  // Oczy
  if (second() != lastSecond) {
    closed = !closed;
    lastSecond = second();
  }
  if (closed) {
      fill(125, 100, 100);
  }
  else {
    fill(0, 0, 0);
  }
  circle(width / 2.f + 30, height / 2.f - 200, 20);
  if (!closed) {
      fill(125, 100, 100);
  }
  else {
    fill(0, 0, 0);
  }
  circle(width / 2.f - 30, height / 2.f - 200, 20);
}  
