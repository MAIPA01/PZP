TextButton[] numberButtons = new TextButton[9];
SudokuBoard board = new SudokuBoard();

void setup() {
 size(400, 400);
 board.generateLevel(SUDOKU_LEVEL.HARD);
 
 float buttonSize = 400 / (9 + 5);
 
 for (int i = 0; i < 9; i++) {
   numberButtons[i] = new TextButton("" + (i + 1), buttonSize + i * (buttonSize + buttonSize / 2f), height - buttonSize - buttonSize / 2f, buttonSize, buttonSize);
   final int index = i + 1;
   numberButtons[i].addAction(() -> { board.setChoosed(index); });
 }
}

void draw() {
  background(128);
  board.display();
  for (int i = 0; i < 9; i++) {
   numberButtons[i].display(); 
  }
}

void mousePressed() {
  board.mousePressed();
  for (int i = 0; i < 9; i++) {
   numberButtons[i].mousePressed();
  }
}
