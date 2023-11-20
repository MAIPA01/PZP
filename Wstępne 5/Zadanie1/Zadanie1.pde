PImage img = null;
int[] valueHistogram;
int[] redHistogram;
int[] greenHistogram;
int[] blueHistogram;
boolean showHistogram = false;
color histogramColor = color(255);
int[] currentHistogramValues;

PVector imgPos = new PVector(0, 0);
float imgWidth = 0f;
float imgHeight = 0f;

void inputFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    imgWidth = img.width;
    imgHeight = img.height;
    float ratio = imgWidth / imgHeight;
    if (imgWidth > imgHeight) {
     imgWidth = width;
     imgHeight = imgWidth / ratio;
     imgPos.y = height / 2f - imgHeight / 2f;
    }
    else {
     imgHeight = height;
     imgWidth = imgHeight * ratio;
     imgPos.x = width / 2f - imgWidth / 2f;
    }
    
    valueHistogram = new int[256];
    redHistogram = new int[256];
    greenHistogram = new int[256];
    blueHistogram = new int[256];
    for (int i = 0; i < img.width; i++) {
      for (int j = 0; j < img.height; j++) {
        color pixel = img.get(i, j);
        valueHistogram[int(brightness(pixel))]++;
        redHistogram[int(red(pixel))]++;
        greenHistogram[int(green(pixel))]++;
        blueHistogram[int(blue(pixel))]++;
      }
    }
    currentHistogramValues = valueHistogram;
  }
}

void setup() {
  size(600, 450);
  selectInput("Select a image file", "inputFileSelected");
  //noLoop();
}
 
void draw() {
  background(0);
  if (img != null) {
    pushMatrix();
    translate(imgPos.x, imgPos.y);
    image(img, 0, 0, imgWidth, imgHeight);
    popMatrix();
    if (showHistogram) {
        stroke(histogramColor);
        for(int i = 0; i < 256; i += 1) {
          int x = int(map(i, 0, 255, 0, width));
          int y = int(map(currentHistogramValues[i], 0, max(currentHistogramValues), height, 0));
          line(x, height, x, y);
        }
    }
  }
}

void mousePressed() {
 if (mouseButton == LEFT) {
    showHistogram = !showHistogram; 
 }
}

void keyPressed() {
  if (key != CODED) {
    if (keyCode == 'V') {
      currentHistogramValues = valueHistogram;
      histogramColor = color(255);
    }
    if (keyCode == 'R') {
      currentHistogramValues = redHistogram;
      histogramColor = color(255, 0, 0);
    }
    if (keyCode == 'G') {
      currentHistogramValues = greenHistogram;
      histogramColor = color(0, 255, 0);
    }
    if (keyCode == 'B') {
      currentHistogramValues = blueHistogram;
      histogramColor = color(0, 0, 255);
    }
    if (keyCode == 'S') {
     selectOutput("Select a file to save image", "outputFileSelected"); 
    }
  }
}

void outputFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    if (img != null) {
     img.save(selection.getAbsolutePath());
    }
  }
}
