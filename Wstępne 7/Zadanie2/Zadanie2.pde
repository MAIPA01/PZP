import processing.pdf.*;

Table table, tableSorted;
int chartX1, chartY1, chartX2, chartY2, offset;

boolean recording = false;

ArrayList<Button> buttons = new ArrayList<Button>();
String currType = "EUR";

void setup() {
  size(750, 500);
  //noLoop();
  
  chartX1 = 75;
  chartY1 = height-100;
  chartX2 = width-100;
  chartY2 = 125;  
  offset = 20;
  
  table = loadTable("plik2.csv", "header");
  table.setColumnType("GBP", Table.FLOAT);
  table.setColumnType("USD", Table.FLOAT);
  table.setColumnType("EUR", Table.FLOAT);
  tableSorted = table.copy();
  
  buttons.add(new RectangleButton(60, height - 40, 100, 20, "EUR", color(200), color(128)));
  buttons.add(new RectangleButton(60 + 120, height - 40, 100, 20, "USD", color(200), color(128)));
  buttons.add(new RectangleButton(60 + 240, height - 40, 100, 20, "GBP", color(200), color(128)));
  
  buttons.get(0).select();
  buttons.get(0).addCallback(() -> { currType = "EUR"; buttons.get(1).deselect(); buttons.get(2).deselect(); });
  buttons.get(1).addCallback(() -> { currType = "USD"; buttons.get(0).deselect(); buttons.get(2).deselect(); });
  buttons.get(2).addCallback(() -> { currType = "GBP"; buttons.get(0).deselect(); buttons.get(1).deselect(); });
}

void draw() {
  background(255);
  
  fill(0);
  stroke(0);
  strokeWeight(2);
  
  textSize(50);
  textAlign(CENTER);
  text("TITLE", width/2, 60);  
  
  line(chartX1, chartY1, chartX2+offset, chartY1);
  triangle(chartX2+offset, chartY1-offset/2, chartX2+offset, 
           chartY1+offset/2, chartX2+offset*2, chartY1);
  textSize(20);
  text("X TITLE", width/2, chartY1+30);
           
  line(chartX1, chartY1, chartX1, chartY2-offset); 
  triangle(chartX1-offset/2, chartY2-offset, chartX1+offset/2, 
           chartY2 - offset, chartX1, chartY2-offset*2);
  pushMatrix();
  translate(chartX1 - 20, height/2);
  rotate(radians(-90));
  text("Y TITLE", 0, 0);
  popMatrix();
  
  tableSorted.sortReverse(currType);
  float maxPrice = tableSorted.getFloat(0, currType);
  
  // X lines
  for (int i = 10; i < table.getRowCount(); i += 10) {
   float x = map(i, 0, table.getRowCount(), chartX1, chartX2);
   line(x, chartY1 - 5, x, chartY1 + 5);
  }
  
  // Y lines
  for (float i = 0.5f; i <= maxPrice; i += 0.5f) {
   float y = map(i, 0, maxPrice, chartY1, chartY2);
   line(chartX1 - 5, y, chartX1 + 5, y);
  }
  
  for (int i = 0; i < table.getRowCount() - 1; i++) {
    float price1 = table.getRow(i).getFloat(currType);
    float x1 = map(i+1, 0, table.getRowCount(), chartX1, chartX2);
    float y1 = map(price1, 0, maxPrice, chartY1, chartY2);
    
    float price2 = table.getRow(i+1).getFloat(currType);
    float x2 = map(i+2, 0, table.getRowCount(), chartX1, chartX2);
    float y2 = map(price2, 0, maxPrice, chartY1, chartY2);
    
    //line(x1, y1, x2, y2);
    rectMode(CORNER);
    noStroke();
    rect(x1, y1, x2 - x1, chartY1 - y1);
  }
  stroke(0);
  
  float mX = mouseX >= chartX1 ? mouseX <= chartX2 ? mouseX : chartX2 : chartX1;
  float mY = mouseY <= chartY1 ? mouseY >= chartY2 ? mouseY : chartY2 : chartY1;
  fill(255, 0, 0);
  line(chartX1, mY, mX, mY);
  line(mX, chartY1, mX, mY);
  circle(mX, mY, 10);
  
  for (int i = 0; i < buttons.size(); i++) {
   buttons.get(i).draw(); 
  }
  
  
  if (recording) {
    endRecord();
    recording = false;
  }
}

void keyPressed() {
  if (key != CODED) {
   if (key == 's') {
     recording = true;
     beginRecord(PDF, "test.pdf");
     redraw();
   }
  }
}

void mousePressed() {
 for (int i = 0; i < buttons.size(); i++) {
  buttons.get(i).mousePressed(); 
 }
}
