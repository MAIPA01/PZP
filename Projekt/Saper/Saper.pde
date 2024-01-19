import java.util.*;

PGraphics screen;
enum SCREEN_TYPES { MENU, GAME, GAME_OVER, GAME_WIN };
SCREEN_TYPES currentScreen = SCREEN_TYPES.MENU;

// MENU
Text saperText = null;
Text bombsNumText = null;
Text rowsNumText = null;
Text columnsNumText = null;

RangeSlider bombsSlider = null;
RangeSlider rowsSlider = null;
RangeSlider columnsSlider = null;

TextButton startButton = null;
TextButton loadButton = null;
TextButton exitButton = null;

// GAME
int currentMiliseconds = 0;
int currentSeconds = 0;
int currentMinutes = 0;

SaperBoard board = null;

Text gameTimeText = null;

TextButton saveButton = null;
TextButton backButton = null;

// END

void setup() {
  size(800, 800);
  
  screen = createGraphics(width, height);
  
  // MENU
  saperText = new Text(width / 2f, 100f, "SAPER");
  saperText.setTextSize(50f);
  
  bombsSlider = new RangeSlider(new ArrayList<Float>(Arrays.asList(new Float[]{10f})), 1f, 100f, new ArrayList<Integer>(Arrays.asList(new Integer[]{color(255, 0, 0)})));
  bombsSlider.setSize(150f, 20f);
  bombsSlider.setPosition(width / 2f - 75f, height / 2f - 120f);
  
  bombsNumText = new Text(width / 2f + 90f, height / 2f - 120f, "Bombs: " + (int)(float)bombsSlider.getValues().get(0));
  bombsNumText.setAlign(LEFT);
  bombsNumText.setTextSize(15f);
  
  rowsSlider = new RangeSlider(new ArrayList<Float>(Arrays.asList(new Float[]{10f})), 2f, 14f, new ArrayList<Integer>(Arrays.asList(new Integer[]{color(0, 0, 255)})));
  rowsSlider.setSize(150f, 20f);
  rowsSlider.setPosition(width / 2f - 75f, height / 2f - 90f);
  
  rowsNumText = new Text(width / 2f + 90f, height / 2f - 90f, "Rows: " + (int)(float)rowsSlider.getValues().get(0));
  rowsNumText.setAlign(LEFT);
  rowsNumText.setTextSize(15f);
  
  columnsSlider = new RangeSlider(new ArrayList<Float>(Arrays.asList(new Float[]{10f})), 2f, 14f, new ArrayList<Integer>(Arrays.asList(new Integer[]{color(0, 255, 0)})));
  columnsSlider.setSize(150f, 20f);
  columnsSlider.setPosition(width / 2f - 75f, height / 2f - 60f);
  
  columnsNumText = new Text(width / 2f + 90f, height / 2f - 60f, "Columns: " + (int)(float)columnsSlider.getValues().get(0));
  columnsNumText.setAlign(LEFT);
  columnsNumText.setTextSize(15f);
  
  startButton = new TextButton("START", width / 2f, height / 2f, 150f, 30f);
  startButton.addAction(() -> {
    if (mouseButton == LEFT) {
      board.setRowsNumber((int)(float)rowsSlider.getValues().get(0));
      board.setColumnsNumber((int)(float)columnsSlider.getValues().get(0));
      board.generate((int)(float)bombsSlider.getValues().get(0));
      currentMiliseconds = 0;
      currentSeconds = 0;
      currentMinutes = 0;
      
      currentScreen = SCREEN_TYPES.GAME;
    }
  });
  
  loadButton = new TextButton("LOAD", width / 2f, height / 2f + 40f, 150f, 30f);
  loadButton.addAction(() -> {
    if (mouseButton == LEFT) {
      println("LOADING... Żartuje to też nie działa"); 
    }
  });
  
  exitButton = new TextButton("EXIT", width / 2f, height / 2f + 80f, 150f, 30f);
  exitButton.addAction(() -> {
    if (mouseButton == LEFT) {
      exit(); 
    }
  });
  
  // GAME
  board = new SaperBoard(40, 40, 10, 10);
  gameTimeText = new Text(width / 2f, 75, "00:00");
  
  saveButton = new TextButton("SAVE", width - 60f, 30f, 100f, 50f);
  saveButton.addAction(() -> {
    if (mouseButton == LEFT) {
      println("SAVING... Żart nie działa jeszcze");
    }
  });
  
  backButton = new TextButton("BACK", 60f, 30f, 100f, 50f);
  backButton.addAction(() -> {
    if (mouseButton == LEFT) {
      currentScreen = SCREEN_TYPES.MENU;
    }
  });
}

void draw() {
  screen.beginDraw();
  
  screen.background(200);
  
  if (currentScreen == SCREEN_TYPES.MENU) {
    saperText.draw(screen);
    
    bombsSlider.setMax((int)(float)rowsSlider.getValues().get(0) * (int)(float)columnsSlider.getValues().get(0) - 1);
    bombsSlider.draw(screen);
    bombsNumText.setText("Bombs: " + (int)(float)bombsSlider.getValues().get(0));
    bombsNumText.draw(screen);
    
    rowsSlider.draw(screen);
    rowsNumText.setText("Rows: " + (int)(float)rowsSlider.getValues().get(0));
    rowsNumText.draw(screen);
    
    columnsSlider.draw(screen);
    columnsNumText.setText("Columns: " + (int)(float)columnsSlider.getValues().get(0));
    columnsNumText.draw(screen);
    
    startButton.draw(screen);
    loadButton.draw(screen);
    exitButton.draw(screen);
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    currentMiliseconds += 1000f / frameRate;
    if (currentMiliseconds > 1000) {
      currentSeconds += currentMiliseconds / 1000;
      currentMiliseconds = currentMiliseconds % 1000;
    }
    if (currentSeconds > 60) {
      currentMinutes += currentSeconds / 60;
      currentSeconds = currentSeconds % 60;
    }
    String time = (currentMinutes > 10 ? currentMinutes : "0" + currentMinutes) + ":" + (currentSeconds > 10 ? currentSeconds : "0" + currentSeconds);
    gameTimeText.setText(time);
    
    board.draw(screen);
    gameTimeText.draw(screen);
    saveButton.draw(screen);
    backButton.draw(screen);
  }
  else if (currentScreen == SCREEN_TYPES.GAME_OVER) {
    
  }
  else if (currentScreen == SCREEN_TYPES.GAME_WIN) {
    
  }
  
  screen.endDraw();
  
  image(screen, 0, 0);
}

void mousePressed() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    bombsSlider.mousePressed();
    rowsSlider.mousePressed();
    columnsSlider.mousePressed();
    
    startButton.mousePressed();
    loadButton.mousePressed();
    exitButton.mousePressed();
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    saveButton.mousePressed();
    backButton.mousePressed();
    board.mousePressed();
    
    if (board.isGameEnded()) {
      if (board.checkBoard()) {
        currentScreen = SCREEN_TYPES.GAME_WIN;
        println("WIN");
      }
      else {
        currentScreen = SCREEN_TYPES.GAME_OVER;
        println("OVER");
      }
    }
  }
  else if (currentScreen == SCREEN_TYPES.GAME_OVER) {
    
  }
  else if (currentScreen == SCREEN_TYPES.GAME_WIN) {
    
  }
}

void mouseReleased() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    bombsSlider.mouseReleased();
    rowsSlider.mouseReleased();
    columnsSlider.mouseReleased();
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    
  }
  else if (currentScreen == SCREEN_TYPES.GAME_OVER) {
    
  }
  else if (currentScreen == SCREEN_TYPES.GAME_WIN) {
    
  }
}
