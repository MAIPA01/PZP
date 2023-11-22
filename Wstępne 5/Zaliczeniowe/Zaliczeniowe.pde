PImage img = null;
PVector imgPos = new PVector(0, 0);
float imgWidth = 0f;
float imgHeight = 0f;

float showWindowHeight = 0f;

TextButton getImgBtn;
TextButton saveImgBtn;

TextButton currentFilterBtn;
TextButton filter1Btn;
TextButton filter2Btn;
TextButton filter3Btn;
TextButton filter4Btn;

// SELECTION
PVector boxStart = new PVector();
PVector boxEnd = new PVector();
boolean drawBox = false;

// IMAGES
PGraphics graphic;

void setup() {
  size(800, 600);
  imageMode(CENTER);
  rectMode(CENTER);
  
  showWindowHeight = (height * 9f) / 10f;
  
  LoadImage("obraz.jpg");
    
    PFont font = createFont("Shintia.otf", 48);
    getImgBtn = new TextButton(width / 2f + width * 3f / 8f, (height * 19f) / 20f + -height / 40f, 100, 20, color(255), color(0), "Load Image", 12, color(0), font);
    saveImgBtn = new TextButton(width / 2f + width * 3f / 8f, (height * 19f) / 20f + height / 40f, 100, 20, color(255), color(0), "Save Image", 12, color(0), font);
    
    filter1Btn = new TextButton(width / 2f + -width * 8f / 16f + 60f, (height * 19f) / 20f, 100, 50, color(255), color(0), "Original", 15, color(0), font);
    filter2Btn = new TextButton(width / 2f + -width * 8f / 16f + 170f, (height * 19f) / 20f, 100, 50, color(255), color(0), "Negative", 15, color(0), font);
    filter3Btn = new TextButton(width / 2f + -width * 8f / 16f + 280f, (height * 19f) / 20f, 100, 50, color(255), color(0), "Darken", 15, color(0), font);
    filter4Btn = new TextButton(width / 2f + -width * 8f / 16f + 390f, (height * 19f) / 20f, 100, 50, color(255), color(0), "Sharpen", 15, color(0), font);
    currentFilterBtn = filter1Btn;
    currentFilterBtn.select();
}

void draw() {
  background(0);
  if (graphic != null) {
    pushMatrix();
    translate(imgPos.x, imgPos.y);
    image(graphic, 0, 0, imgWidth, imgHeight);
    popMatrix();
    
    if (drawBox) {
      pushStyle();
      strokeWeight(2);
      stroke(255);
      noFill();
      float x = (boxEnd.x + boxStart.x) / 2f;
      float y = (boxEnd.y + boxStart.y) / 2f;
      rect(x, y, abs(boxEnd.x - boxStart.x), abs(boxEnd.y - boxStart.y));
      popStyle();
    }
  }
  
  pushMatrix();
  fill(128);
  translate(width / 2f, (height * 19f) / 20f);
  rect(0, 0, width, height / 10f);
  popMatrix();
  
  getImgBtn.draw();
  saveImgBtn.draw();
  
  filter1Btn.draw();
  filter2Btn.draw();
  filter2Btn.draw();
  filter3Btn.draw();
  filter4Btn.draw();
}

void mousePressed() {
  if (getImgBtn.isIn(mouseX, mouseY)) {
   println("loadImage");
   selectInput("Select a image file", "inputFileSelected");
  }
  if (saveImgBtn.isIn(mouseX, mouseY)) {
   println("saveImage");
   selectOutput("Select a file to save image", "outputFileSelected");
  }
  if (filter1Btn.isIn(mouseX, mouseY)) {
   println("filter1");
   currentFilterBtn.deselect();
   filter1Btn.select();
   currentFilterBtn = filter1Btn;
   applyFiltr1();
  }
  if (filter2Btn.isIn(mouseX, mouseY)) {
   println("filter2");
   currentFilterBtn.deselect();
   filter2Btn.select();
   currentFilterBtn = filter2Btn;
   applyFiltr2();
  }
  if (filter3Btn.isIn(mouseX, mouseY)) {
   println("filter3");
   currentFilterBtn.deselect();
   filter3Btn.select();
   currentFilterBtn = filter3Btn;
   applyFiltr3();
  }
  if (filter4Btn.isIn(mouseX, mouseY)) {
   println("filter1");
   currentFilterBtn.deselect();
   filter4Btn.select();
   currentFilterBtn = filter4Btn;
   applyFiltr3();
  }
  
  if (mouseButton == LEFT && mouseY <= 9f * height / 10f) {
    boxStart.x = mouseX;
    boxStart.y = mouseY;
    boxEnd.x = mouseX;
    boxEnd.y = mouseY;
    drawBox = true;
  }
}

void mouseDragged() {
   if (mouseButton == LEFT) {
       boxEnd.x = mouseX;
      boxEnd.y = mouseY <= 9f * height / 10f ? mouseY : 9f * height / 10f;
   }
}

void mouseReleased() {
   if (mouseButton == LEFT && mouseY <= 9f * height / 10f) {
      boxEnd.x = mouseX;
      boxEnd.y = mouseY;
   }
}

void LoadImage(String path) {
  img = loadImage(path);
  imgWidth = img.width;
  imgHeight = img.height;
  float ratio = imgWidth / imgHeight;
  
  if (imgHeight > showWindowHeight) {
     imgHeight = showWindowHeight;
     imgWidth = imgHeight * ratio;
  }
  
  if (imgWidth > imgHeight) {
   imgWidth = width;
   imgHeight = imgWidth / ratio;
  }
  else {
   imgHeight = height;
   imgWidth = imgHeight * ratio;
  }
   imgPos.x = width / 2f;
   imgPos.y = showWindowHeight / 2f;
   
   applyFiltr1();
}

void inputFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    LoadImage(selection.getAbsolutePath());
  }
}

void outputFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    if (graphic != null) {
     graphic.save(selection.getAbsolutePath());
    }
  }
}

void applyFiltr1() {
  graphic = createGraphics(img.width, img.height);
  graphic.beginDraw();
  graphic.image(img, 0, 0, img.width, img.height);
  graphic.endDraw();
}

void applyFiltr2() {
  float ratioX = graphic.width / imgWidth;
  float ratioY = graphic.height / imgHeight;
  PImage temp = createImage((int)(abs(boxEnd.x - boxStart.x) * ratioX), (int)(abs(boxEnd.y - boxStart.y) * ratioY), RGB);
  
  float imgMarginY = (9f * height / 10f - imgHeight) / 2f;
  float imgMarginX = (width - imgWidth) / 2f;
  
  int startY;
  int endY;
  if (boxStart.y < boxEnd.y) {
    startY = (int)((boxStart.y - imgMarginY) * ratioY);
    endY = (int)((boxEnd.y - imgMarginY) * ratioY);
  }
  else {
   startY = (int)((boxEnd.y - imgMarginY) * ratioY);
   endY = (int)((boxStart.y - imgMarginY) * ratioY);
  }
  int startX;
  int endX;
  if (boxStart.x < boxEnd.x) {
    startX = (int)((boxStart.x - imgMarginX) * ratioX);
    endX = (int)((boxEnd.x - imgMarginX)* ratioX);
  }
  else {
   startX = (int)((boxEnd.x - imgMarginX) * ratioX);
   endX = (int)((boxStart.x - imgMarginX) * ratioX);
  }
  
  graphic.loadPixels();
  for (int y = startY; y < endY; y++) {
   for (int x = startX; x < endX; x++) {
     temp.pixels[(y - startY) * temp.width + (x - startX)] = graphic.pixels[y * graphic.width + x];
   }
  }
  temp.updatePixels();
  
  temp.filter(INVERT);
  
  graphic.beginDraw();
  graphic.image(temp, startX, startY, temp.width, temp.height);
  graphic.endDraw();
}

void applyFiltr3() {
  float[][] kernel = { { 0.0, 0.0, 0.0 },
                     { 0.0, 0.5, 0.0 },
                     { 0.0, 0.0, 0.0 } };
                     
  float ratioX = graphic.width / imgWidth;
  float ratioY = graphic.height / imgHeight;
  PImage temp = createImage((int)(abs(boxEnd.x - boxStart.x) * ratioX), (int)(abs(boxEnd.y - boxStart.y) * ratioY), RGB);
  
  float imgMarginY = (9f * height / 10f - imgHeight) / 2f;
  float imgMarginX = (width - imgWidth) / 2f;
  
  int startY;
  int endY;
  if (boxStart.y < boxEnd.y) {
    startY = (int)((boxStart.y - imgMarginY) * ratioY);
    endY = (int)((boxEnd.y - imgMarginY) * ratioY);
  }
  else {
   startY = (int)((boxEnd.y - imgMarginY) * ratioY);
   endY = (int)((boxStart.y - imgMarginY) * ratioY);
  }
  int startX;
  int endX;
  if (boxStart.x < boxEnd.x) {
    startX = (int)((boxStart.x - imgMarginX) * ratioX);
    endX = (int)((boxEnd.x - imgMarginX)* ratioX);
  }
  else {
   startX = (int)((boxEnd.x - imgMarginX) * ratioX);
   endX = (int)((boxStart.x - imgMarginX) * ratioX);
  }
  
  graphic.loadPixels();
  for (int y = startY - 1; y < endY - 2; y++) {
   for (int x = startX - 1; x < endX - 2; x++) {
     float sumRed = 0;   
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky) * graphic.width + (x + kx);
          sumRed += kernel[ky+1][kx+1] * red(graphic.pixels[pos]);
          sumGreen += kernel[ky+1][kx+1] * green(graphic.pixels[pos]);
          sumBlue += kernel[ky+1][kx+1] * blue(graphic.pixels[pos]);
        }
      }
     temp.pixels[(y - startY + 1) * temp.width + (x - startX + 1)] = color(sumRed, sumGreen, sumBlue);
   }
  }
  temp.updatePixels();
  
  graphic.beginDraw();
  graphic.image(temp, startX, startY, temp.width, temp.height);
  graphic.endDraw();
}

void applyFiltr4() {
  float[][] kernel = { { -2.0, -1.0, 0.0 },
                     { -1.0, 1.0, 1.0 },
                     { 0.0, 1.0, 2.0 } };
   
  float ratioX = graphic.width / imgWidth;
  float ratioY = graphic.height / imgHeight;
  PImage temp = createImage((int)(abs(boxEnd.x - boxStart.x) * ratioX), (int)(abs(boxEnd.y - boxStart.y) * ratioY), RGB);
  
  float imgMarginY = (9f * height / 10f - imgHeight) / 2f;
  float imgMarginX = (width - imgWidth) / 2f;
  
  int startY;
  int endY;
  if (boxStart.y < boxEnd.y) {
    startY = (int)((boxStart.y - imgMarginY) * ratioY);
    endY = (int)((boxEnd.y - imgMarginY) * ratioY);
  }
  else {
   startY = (int)((boxEnd.y - imgMarginY) * ratioY);
   endY = (int)((boxStart.y - imgMarginY) * ratioY);
  }
  int startX;
  int endX;
  if (boxStart.x < boxEnd.x) {
    startX = (int)((boxStart.x - imgMarginX) * ratioX);
    endX = (int)((boxEnd.x - imgMarginX)* ratioX);
  }
  else {
   startX = (int)((boxEnd.x - imgMarginX) * ratioX);
   endX = (int)((boxStart.x - imgMarginX) * ratioX);
  }
  
  graphic.loadPixels();
    for (int y = startY - 1; y < endY - 2; y++) {
   for (int x = startX - 1; x < endX - 2; x++) {
     float sumRed = 0;   
      float sumGreen = 0;
      float sumBlue = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*graphic.width + (x + kx);
          sumRed += kernel[ky+1][kx+1] * red(graphic.pixels[pos]);
          sumGreen += kernel[ky+1][kx+1] * green(graphic.pixels[pos]);
          sumBlue += kernel[ky+1][kx+1] * blue(graphic.pixels[pos]);
        }
      }
     temp.pixels[(y - startY) * temp.width + (x - startX)] = color(sumRed, sumGreen, sumBlue);
   }
  }
  temp.updatePixels();
  
  graphic.beginDraw();
  graphic.image(temp, startX, startY, temp.width, temp.height);
  graphic.endDraw();
}
