PFont font;  

  void setup() {
    size(600, 300);
    background(0);
    noLoop();
    font = createFont("Courier New", 50);
    textFont(font);
    textAlign(CENTER, CENTER);
  }  

  void draw() {
    char letter = 'a';   
    int rows = 4;
    int columns = 7;
    int gapX = width / (columns+1);
    int gapY = height / (rows+1);
    for(int x=1; x<=columns; x++) {
      for(int y=1; y<=rows; y++) {
        if (y == 1) {
           translate(0, gapY);
           continue;
        }
        if (letter >= 'a' && letter <= 'z') {
          if (letter == 'a' || letter == 'e' || letter == 'i' || letter == 'o' || letter == 'u') {
            fill(255, 0, 0);
            text((char)(letter + ('A' - 'a')), gapX, gapY);
          }
          else {
            fill(255);
            text(letter, gapX, gapY); 
          }
          translate(0, gapY);
          letter++;
        }
      }
      translate(gapX, -rows * gapY);
    }
  }
