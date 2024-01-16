PGraphics screen;

SaperBoard board;

void setup() {
  size(800, 600);
  
  screen = createGraphics(width, height);
  
  board = new SaperBoard(400, 400, 10, 10);
  board.generate();
}

void draw() {
  screen.beginDraw();
  
  screen.background(200);
  board.draw(screen);
  
  screen.endDraw();
  
  image(screen, 0, 0);
}

void mousePressed() {
  board.mousePressed();
}
