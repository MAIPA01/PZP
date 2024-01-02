TextButton[] numberButtons = new TextButton[9];
SudokuBoard board;

Dropdown select;

PGraphics screen;

void setup() {
 size(400, 400);
 
 screen = createGraphics(width, height);
 
 board = new SudokuBoard();
 board.generateLevel(SUDOKU_LEVEL.HARD);
 
 float buttonSize = 400 / (9 + 5);
 
 for (int i = 0; i < 9; i++) {
   numberButtons[i] = new TextButton("" + (i + 1), buttonSize + i * (buttonSize + buttonSize / 2f), height - buttonSize - buttonSize / 2f, buttonSize, buttonSize);
   numberButtons[i].setStrokeWeight(2);
   numberButtons[i].setStrokeColor(color(0));
   
   final int index = i + 1;
   numberButtons[i].addAction(() -> {
     board.setChoosed(index);
     
     // Highlight Disable
     for (int i2 = 0; i2 < 9; i2++) {
      numberButtons[i2].setColor(color(255));
      numberButtons[i2].setHasStroke(false);
      numberButtons[i2].setTextColor(color(0));
     }
     
     // Highlight Enable
     numberButtons[index - 1].setColor(color(200));
     numberButtons[index - 1].setHasStroke(true);
     numberButtons[index - 1].setTextColor(color(255, 0, 0));
   });
 }
 
 select = new Dropdown(width / 2f, height / 2f, 200, 25, 100);
 select.addOption("a");
 select.addOption("b");
 select.addOption("c");
 select.addOption("d");
 
 /*testObject1 = new Button(width / 2f, height / 2f, 100, 100);
 testObject1.addAction(() -> { println("test"); });
 testObject2 = new Button(width / 2f, height / 2f + 200, 100, 100);
 
 view = new ScrollView(200, 200, 0, 400);
 view.setBgColor(color(164));
 view.setScrollColor(color(255));
 view.setScrollBgColor(color(200));
 view.setScrollWidth(20);
 view.enableScroll(true);
 view.setPosition(width / 2f, height / 2f);
 
 view.addObject(testObject1);
 view.addObject(testObject2);*/
}

void draw() {
  screen.beginDraw();
  screen.background(128);
  /*board.display(screen);
  for (int i = 0; i < 9; i++) {
   numberButtons[i].display(screen); 
  }*/
  //view.display(screen);
  select.display(screen);
  screen.endDraw();
  
  image(screen, 0, 0);
}

void mousePressed() {
  /*board.mousePressed();
  for (int i = 0; i < 9; i++) {
   numberButtons[i].mousePressed();
  }*/
  //view.mousePressed();
  select.mousePressed();
}

void mouseReleased() {
  //view.mouseReleased();
  select.mouseReleased();
}

void mouseDragged() {
  //view.mouseDragged();
  select.mouseDragged();
}
