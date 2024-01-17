import java.util.*;

PGraphics screen;
enum SCREEN_TYPES { MENU, GAME, END };
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
  size(800, 600);
  
  screen = createGraphics(width, height);
  
  // MENU
  saperText = new Text(width / 2f, 100f, "SAPER");
  saperText.setTextSize(50f);
  
  bombsSlider = new RangeSlider(new ArrayList<Float>(Arrays.asList(new Float[]{10f})), 1f, 100f, new ArrayList<Integer>(Arrays.asList(new Integer[]{color(255, 0, 0)})));
  bombsSlider.setSize(150f, 20f);
  bombsSlider.setPosition(width / 2f - 75f, height / 2f);
  
  // DOKOŃCZYĆ MENU
  bombsNumText = new Text(width / 2f + 25f, height / 2f, "Bombs: 10");
  bombsNumText.setAllign(LEFT);
  bombsNumText.setTextSize(15f);
  
  rowsSlider = new RangeSlider(new ArrayList<Float>(Arrays.asList(new Float[]{10f})), 1f, 100f, new ArrayList<Integer>(Arrays.asList(new Integer[]{color(0, 0, 255)})));
  rowsSlider.setSize(150f, 20f);
  rowsSlider.setPosition(width / 2f - 75f, height / 2f + 30f);
  
  columnsSlider = new RangeSlider(new ArrayList<Float>(Arrays.asList(new Float[]{10f})), 1f, 100f, new ArrayList<Integer>(Arrays.asList(new Integer[]{color(0, 255, 0)})));
  columnsSlider.setSize(150f, 20f);
  columnsSlider.setPosition(width / 2f - 75f, height / 2f + 60f);
  
  // GAME
  board = new SaperBoard(400, 400, 10, 10);
  gameTimeText = new Text(width / 2f, 100, "00:00");
  
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
    
    bombsSlider.draw(screen);
    bombsNumText.draw(screen);
    
    rowsSlider.draw(screen);
    
    columnsSlider.draw(screen);
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
  else if (currentScreen == SCREEN_TYPES.END) {
    
  }
  
  screen.endDraw();
  
  image(screen, 0, 0);
}

void mousePressed() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    bombsSlider.mousePressed();
    rowsSlider.mousePressed();
    columnsSlider.mousePressed();
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    saveButton.mousePressed();
    backButton.mousePressed();
    board.mousePressed();
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    
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
  else if (currentScreen == SCREEN_TYPES.END) {
    
  }
}
