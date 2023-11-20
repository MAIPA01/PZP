PImage img, imgSize;
float w, h;

PVector imgPos = new PVector();
PVector boxStart = new PVector();
PVector boxEnd = new PVector();

boolean drawBox = false;

void setup() {
  size(500, 800);
  img = loadImage("obraz.jpg");
  imgSize = img.copy();
  imgSize.resize(width, 0);
  if(imgSize.height > height) imgSize.resize(0, height);
  w = imgSize.width;
  h = imgSize.height;
  imgPos.x = width / 2f;
  imgPos.y = height / 2f;
  imageMode(CENTER);
  rectMode(CENTER);
  noLoop();
}

void draw() {
  background(0);
  image(img, imgPos.x, imgPos.y, w, h);
  if (drawBox) {
    strokeWeight(2);
    stroke(255);
    noFill();
    float x = (mouseX + boxStart.x) / 2f;
    float y = (mouseY + boxStart.y) / 2f;
    rect(x, y, abs(mouseX - boxStart.x), abs(mouseY - boxStart.y));
  }
}

void mouseDragged() {
   if (mousePressed && mouseButton == LEFT) {
       redraw();
   }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    boxStart.x = mouseX;
    boxStart.y = mouseY;
    drawBox = true;
    redraw();
  }
}

void mouseReleased() {
   if (mouseButton == LEFT) {
      boxEnd.x = mouseX;
      boxEnd.y = mouseY;
      
      float boxWidth = abs(boxEnd.x - boxStart.x);
      float x = (boxEnd.x + boxStart.x) / 2f;
      float y = (boxEnd.y + boxStart.y) / 2f;
      
      float localScale = width / boxWidth;
      w *= localScale;
      h *= localScale;
      
      imgPos.x = width / 2f + (imgPos.x - x) * localScale;
      imgPos.y = height / 2f + (imgPos.y - y) * localScale;
      drawBox = false;
      redraw();
   }
}

void mouseClicked() {
  if (mouseButton == RIGHT) {
    w = imgSize.width;
    h = imgSize.height;
    imgPos.x = width / 2f;
    imgPos.y = height / 2f;
    redraw();
  }
}
