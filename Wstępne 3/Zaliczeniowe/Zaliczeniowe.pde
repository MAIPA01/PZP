class CHAR {
  public int font;
  public char znak;
  public float size;
}

PFont[] fonts = new PFont[2];

PShape btn;

ArrayList<CHAR> text = new ArrayList<CHAR>();

float yStep = 40;

float currY = 0;
float currX = 0;

float startY = 0;

//Current
int currFont = 0;
float currSize = 6;
boolean newChar = false;
boolean delChar = false;

boolean scroll = false;
float scrollDir = 0;

void setup() {
   size(800, 800);
   
   rectMode(CENTER);
   
   btn = createShape();
   btn.setStroke(color(0));
   btn.setStrokeWeight(4);
   btn.setFill(color(255));
   btn.beginShape();
   btn.vertex(-50, -20);
   btn.vertex(-50, 20);
   btn.vertex(50, 20);
   btn.vertex(50, -20);
   btn.endShape(CLOSE);
   
   fonts[0] = createFont("./Shintia.otf", 50);
   fonts[1] = createFont("./SouthernAire.ttf", 50);
   
   currFont = 0;
}

void draw() {
  background(255);
  
  // CHECK SCROLL
  if (mouseY <= height * 3.f / 4.f && mouseY >= 0.f && scroll) {
    startY += scrollDir * 20;
  }
  scroll = false;
  
  currY = 0.f;
  currX = 0.f;
  
  // Góra
  pushMatrix();
  
  translate(10, 10 - startY);
  for (int i = 0; i < text.size(); i++) {
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(fonts[text.get(i).font]);
    textSize(text.get(i).size);
    text(text.get(i).znak, 0, 0);
    
    if (currX >= width - 20 - textWidth(text.get(i).znak) - text.get(i).size) {
      translate(-currX, yStep);
       currX = 0;
       currY += yStep;
    }
    else {
      translate(textWidth(text.get(i).znak) + text.get(i).size + 2, 0);
      currX += textWidth(text.get(i).znak) + text.get(i).size + 2;
    }
    
    if (currY >= height * 3.f / 4.f - yStep + startY && newChar) {
       startY += 20;
       redraw();
    }
    
    if (currY <= 0.f + yStep + startY && delChar) {
       startY -= 20;
       redraw();
    }
  }
  newChar = false;
  delChar = false;
  popMatrix();
  
  // DÓŁ
  pushMatrix();
  fill(127);
  translate(width / 2.f, height * 3.5f / 4.f);
  strokeWeight(0);
  rect(0, 0, width, height / 4.f);
  
  pushMatrix();
  // Font1 Btn
  translate(-width / 3.f, -30.f);
  if (currFont == 0) btn.setFill(200);
  else btn.setFill(255);
  shape(btn);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(fonts[0]);
  textSize(20);
  text("Shintia", 0, 0);
  
  // Font2 Btn
  translate(0, 50.f);
    if (currFont == 1) btn.setFill(200);
  else btn.setFill(255);
  shape(btn);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(fonts[1]);
  textSize(20);
  text("Southern Aire", 0, 0);
  popMatrix();
  
  // Size 6
  translate(width / 3.f, -50.f);
  if (currSize == 6) btn.setFill(200);
  else btn.setFill(255);
  shape(btn);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(fonts[currFont]);
  textSize(6);
  text("6", 0, 0);
  
  // Size 12
  translate(0.f, 50.f);
  if (currSize == 12) btn.setFill(200);
  else btn.setFill(255);
  shape(btn);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(fonts[currFont]);
  textSize(12);
  text("12", 0, 0);
  
  // Size 24
  translate(0.f, 50.f);
  if (currSize == 24) btn.setFill(200);
  else btn.setFill(255);
  shape(btn);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(fonts[currFont]);
  textSize(24);
  text("24", 0, 0);
  
  popMatrix();
}

void keyPressed() {
  if (key != CODED && key != BACKSPACE) {
    CHAR c = new CHAR();
    c.font = currFont;
    c.znak = key;
    c.size = currSize;
     text.add(c);
     newChar = true;
  }
  else if (key == BACKSPACE) {
    if(!text.isEmpty()){
        text.remove(text.size() - 1);
      }
     delChar = true;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    // FONT1
    if (mouseX >= 83 && mouseX <= 183 && mouseY <= 690 && mouseY >= 650) {
      currFont = 0;
    }
    // FONT2
    if (mouseX >= 83 && mouseX <= 183 && mouseY <= 740 && mouseY >= 700) {
      currFont = 1;
    }
    // 6
    if (mouseX >= 615 && mouseX <= 715 && mouseY <= 670 && mouseY >= 630) {
     currSize = 6; 
    }
    // 12
    if (mouseX >= 615 && mouseX <= 715 && mouseY <= 720 && mouseY >= 680) {
     currSize = 12; 
    }
    // 24
    if (mouseX >= 615 && mouseX <= 715 && mouseY <= 770 && mouseY >= 730) {
     currSize = 24; 
    }
    //println(mouseX, mouseY);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scroll = true;
  scrollDir = e;
  //println(e);
}
