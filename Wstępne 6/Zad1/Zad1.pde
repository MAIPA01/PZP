import processing.svg.*;

String [][] freq = {
  {"lodzkie", "56"},
  {"podkarpackie", "22"},
  {"mazowieckie", "67"},
  {"warminsko-mazurskie", "51"},
  {"dolnoslaskie", "50"},
  {"slaskie", "24"},
  {"kujawsko-pomorskie", "15"},
  {"lubelskie", "42"},
  {"lubuskie", "62"},
  {"opolskie", "78"},
  {"podlaskie", "38"},
  {"pomorskie", "58"},
  {"swietokrzyskie", "83"},
  {"wielkopolskie", "43"},
  {"zachodniopomorskie", "12"},
  {"malopolskie", "87"}
};
PShape polska;
PGraphics graphic;

boolean saveSVG = false;

void setup() {
  size(600, 600);
  colorMode(RGB, 100);
  smooth();
  noStroke();
  polska = loadShape("plik1.svg");
  graphic = createGraphics(width, height);
  
  graphic.beginDraw();
  graphic.colorMode(RGB, 100);
  graphic.smooth();
  graphic.noStroke();
  graphic.background(100);
  for (int i = 0; i < freq.length; i++) {  
    graphic.background(100);
    PShape wojewodztwo = polska.getChild(freq[i][0]);
    wojewodztwo.disableStyle();
     graphic.fill(color(int(freq[i][1])));
    graphic.shape(wojewodztwo, (width - polska.width) / 2.f, (height - polska.height) / 2.f);
  }
  graphic.endDraw();
  graphic.updatePixels();
}

void draw() {
  if (saveSVG) {
     beginRecord(SVG, "test.svg"); 
  }
  
  color pixel = graphic.pixels[mouseY * width + mouseX];
  graphic.beginDraw();
  graphic.background(100);
  for (int i = 0; i < freq.length; i++) {  
    PShape wojewodztwo = polska.getChild(freq[i][0]);
    wojewodztwo.disableStyle();
    if (graphic.pixels[mouseY * width + mouseX] != color(int(freq[i][1]))) {
       graphic.fill(color(int(freq[i][1])));
    }
    else {
       graphic.fill(color(100, 0, 0)); 
    }
    graphic.shape(wojewodztwo, (width - polska.width) / 2.f, (height - polska.height) / 2.f);
  }
  graphic.endDraw();
  
  background(100);
  image(graphic, 0, 0);
  if (saveSVG) {
   endRecord();
   saveSVG = false;
  }
}

void keyPressed() {
   if (key == 's') {
     println("SAVED");
     saveSVG = true;
   }
}
