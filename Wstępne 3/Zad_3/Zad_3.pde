char c;
float posX;
float posY;
boolean canType;
 
void setup() {
  size(400, 400, P2D);
  c = ' ';
  posX = width / 2.f;
  posY = height / 2.f;
  canType = true;
  background(0);
  noLoop();
  colorMode(HSB, 100, 100, 100);
}
 
void draw() {
  //background(0);
  //fill(255);
  textSize(100);
  if (canType && c != ' ') {
    //text(c, posX - textWidth(c) / 2.f, posY + (textAscent() - textDescent()) / 2.f);
    if (c >= '0' && c <= '9') {
      fill(((c - '0') * 100.f) / ('9' - '0'), 100, 100);
      // rysuje koło
      circle(posX, posY, 10);
    }
    if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
      if (c >= 'A' && c <= 'Z') c -= 'A' - 'a';
      fill(((c - 'a') * 100.f) / ('z' - 'a'), 100, 100);
      // rysuje kwadrat
      rect(posX, posY, 10, 10);
    }
    canType = false;
  }
}

void mousePressed() {
  posX = mouseX;
  posY = mouseY;
  canType = true;
}
 
void keyPressed() {
  if (key != CODED) {
    c = key;
    redraw();
  }
}  
