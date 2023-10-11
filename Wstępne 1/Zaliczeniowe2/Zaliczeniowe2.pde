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
  size(600, 300);
  background(0);
  noLoop();
  nameFont = createFont("./Shintia.otf", 50);
  surnameFont = createFont("./SouthernAire.ttf", 50);
}

void draw() {
  drawLogo(width / 2f, height / 2f, 100);
}
