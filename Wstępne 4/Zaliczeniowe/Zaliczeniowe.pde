ArrayList<Line> lines = new ArrayList<Line>();
float currentLineSize = 10;
color currentLineColor = color(0);

TextButton drawBtn;
TextButton eraserBtn;

// Color Buttons
CircleButton currentColorBtn;
CircleButton blackBtn;
CircleButton whiteBtn;
CircleButton redBtn;
CircleButton greenBtn;
CircleButton blueBtn;
CircleButton cyjanBtn;
CircleButton magentaBtn;
CircleButton yellowBtn;

// SLIDER
Slider sizeSlider;

color bg = color(255);
boolean isEreasing = false;

PFont font;

void setup() {
 size(800, 600);
 
 font = createFont("./Shintia.otf", 50);
 
 drawBtn = new TextButton(50, height * 13f / 16f, 100, 50, color(255, 0, 0), color(0), "DRAW", 15, color(0), font);
 drawBtn.select();
 eraserBtn = new TextButton(50, height * 15f / 16f, 100, 50, color(255, 0, 0), color(0), "ERASE", 15, color(0), font);
 
 float x = width / 2f - 200;
 float y = height * 13f / 16f;
 blackBtn = new CircleButton(x, y, 50, color(0), color(255));
 blackBtn.select();
 currentColorBtn = blackBtn;
 x += 60;
 whiteBtn = new CircleButton(x, y, 50, color(255), color(0));
 x += 60;
 redBtn = new CircleButton(x, y, 50, color(255, 0, 0), color(0));
 x += 60;
 greenBtn = new CircleButton(x, y, 50, color(0,255, 0), color(0));
 x += 60;
 blueBtn = new CircleButton(x, y, 50, color(0, 0, 255), color(0));
 x += 60;
 cyjanBtn = new CircleButton(x, y, 50, color(255, 255, 0), color(0));
 x += 60;
 magentaBtn = new CircleButton(x, y, 50, color(255, 0, 255), color(0));
 x += 60;
 yellowBtn = new CircleButton(x, y, 50, color(0, 255, 255), color(0));
 x += 60;
 
 sizeSlider = new Slider(width / 2f, height * 15f / 16f, 200, 20, 1, 50);
}

void draw() {
  background(bg);
  
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).draw();
  }
  
  strokeWeight(0);
  rectMode(CENTER);
  fill(128);
  rect(width/2f, height * 7f / 8f, width, height / 4f);
  
  drawBtn.draw();
  eraserBtn.draw();
  
  blackBtn.draw();
  whiteBtn.draw();
  redBtn.draw();
  greenBtn.draw();
  blueBtn.draw();
  cyjanBtn.draw();
  magentaBtn.draw();
  yellowBtn.draw();
  
  sizeSlider.draw();
  pushMatrix();
  pushStyle();
  float value = sizeSlider.getValue();
  translate(width / 2f + 150, height * 15f / 16f);
  fill(0);
  textSize(1);
  textFont(font);
  text("size: " + value, 0, 0);
  currentLineSize = value;
  popStyle();
  popMatrix();
  
  if (mouseY >= 0 && mouseY <= height * 3f / 4f) {
      pushMatrix();
      pushStyle();
      strokeWeight(0f);
      stroke(0f);
      fill(currentLineColor);
      circle(mouseX, mouseY, currentLineSize);
      popStyle();
      popMatrix();
    
     if (mousePressed) {
       if (isEreasing) {
          lines.add(new Line(mouseX, mouseY, pmouseX, pmouseY, currentLineSize, bg));
         }
         else {
          lines.add(new Line(mouseX, mouseY, pmouseX, pmouseY, currentLineSize, currentLineColor)); 
         }
    } 
  }
}

void mousePressed() {
  if (drawBtn.isIn(mouseX, mouseY)) {
   println("draw");
   eraserBtn.deselect();
   drawBtn.select();
   isEreasing = false;
  }
  if (eraserBtn.isIn(mouseX, mouseY)) {
   println("eraser");
   drawBtn.deselect();
   eraserBtn.select();
   isEreasing = true;
  }
  if (blackBtn.isIn(mouseX, mouseY)) {
   println("black");
   currentColorBtn.deselect();
   blackBtn.select();
   currentColorBtn = blackBtn;
   currentLineColor = color(0);
  }
  if (whiteBtn.isIn(mouseX, mouseY)) {
   println("white");
   currentColorBtn.deselect();
   whiteBtn.select();
   currentColorBtn = whiteBtn;
   currentLineColor = color(255);
  }
  if (redBtn.isIn(mouseX, mouseY)) {
   println("red");
   currentColorBtn.deselect();
   redBtn.select();
   currentColorBtn = redBtn;
   currentLineColor = color(255, 0, 0);
  }
  if (greenBtn.isIn(mouseX, mouseY)) {
   println("green");
   currentColorBtn.deselect();
   greenBtn.select();
   currentColorBtn = greenBtn;
   currentLineColor = color(0, 255, 0);
  }
  if (blueBtn.isIn(mouseX, mouseY)) {
   println("blue");
   currentColorBtn.deselect();
   blueBtn.select();
   currentColorBtn = blueBtn;
   currentLineColor = color(0, 0, 255);
  }
  if (cyjanBtn.isIn(mouseX, mouseY)) {
   println("cyjan");
   currentColorBtn.deselect();
   cyjanBtn.select();
   currentColorBtn = cyjanBtn;
   currentLineColor = color(255, 255, 0);
  }
  if (magentaBtn.isIn(mouseX, mouseY)) {
   println("magenta");
   currentColorBtn.deselect();
   magentaBtn.select();
   currentColorBtn = magentaBtn;
   currentLineColor = color(255, 0, 255);
  }
  if (yellowBtn.isIn(mouseX, mouseY)) {
   println("yellow");
   currentColorBtn.deselect();
   yellowBtn.select();
   currentColorBtn = yellowBtn;
   currentLineColor = color(0, 255, 255);
  }
  sizeSlider.mousePressed();
}

void mouseReleased() {
 sizeSlider.mouseReleased(); 
}
