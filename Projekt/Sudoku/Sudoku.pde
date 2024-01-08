Dropdown select;

PGraphics screen;

enum SCREEN_TYPES { 
  MENU, 
  GAME, 
  END
};
SCREEN_TYPES currentScreen = SCREEN_TYPES.MENU;

// MENU
int highscoreSeconds[] = { 0, 0, 0 };
int highscoreMinutes[] = { 0, 0, 0 };
Dropdown levelDropdown;
TextButton startButton;
TextButton loadButton;
TextButton exitButton;

// GAME
TextButton[] numberButtons = new TextButton[9];
TextButton saveButton;
TextButton backToMenuButton;
SudokuBoard board;
int currentMiliseconds = 0;
int currentSeconds = 0;
int currentMinutes = 0;

// END
TextButton returnToMenuButton;

void setup() {
 size(400, 400);
 
 screen = createGraphics(width, height);
 
 // LOAD HIGHSCORES
 File f = dataFile("highscores.json");
 if (f.exists() && f.isFile()) {
   loadHighscoresFromJson();
 }
 else {
   saveHighscoresToJson();
 }
 
 // MENU
 levelDropdown = new Dropdown(width / 2f, height / 2f - 70f, 200, 25, 100);
 levelDropdown.addOption("EASY");
 levelDropdown.addOption("MEDIUM");
 levelDropdown.addOption("HARD");
 levelDropdown.setCurrentOption(0);
 
 startButton = new TextButton("START", width / 2f, height / 2f - 40f, 200, 25);
 startButton.addAction(() -> {
   if (levelDropdown.getCurrentOption() == 0)
     board.generateLevel(SUDOKU_LEVEL.EASY);
   else if (levelDropdown.getCurrentOption() == 1)
     board.generateLevel(SUDOKU_LEVEL.MEDIUM);
   else if (levelDropdown.getCurrentOption() == 2)
     board.generateLevel(SUDOKU_LEVEL.HARD);
   
   board.setChoosed(0);
   
   currentMiliseconds = 0;
   currentSeconds = 0;
   currentMinutes = 0;
   
   currentScreen = SCREEN_TYPES.GAME;
 });
 
 loadButton = new TextButton("LOAD", width / 2f, height / 2f - 10f, 200, 25);
 loadButton.addAction(() -> {
   // load sudoku board
   loadSudokuBoardFromJson();
   println("Loaded");
   currentScreen = SCREEN_TYPES.GAME;
 });
 
 exitButton = new TextButton("EXIT", width / 2f, height / 2f + 20f, 200, 25);
 exitButton.addAction(() -> {
  exit(); 
 });
 
 // GAME
 board = new SudokuBoard();
 
 float buttonSize = 400 / (9 + 5);
 for (int i = 0; i < 9; i++) {
   numberButtons[i] = new TextButton("" + (i + 1), buttonSize + i * (buttonSize + buttonSize / 2f), height - buttonSize - buttonSize / 2f + 10f, buttonSize, buttonSize);
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
 
 saveButton = new TextButton("SAVE", width - 55, 25, 100, 25);
 saveButton.addAction(() -> {
   // save sudoku board
   saveSudokuBoardToJson();
   println("Saved");
 });
 
 backToMenuButton = new TextButton("BACK", 55, 25, 100, 25);
 backToMenuButton.addAction(() -> {
   currentScreen = SCREEN_TYPES.MENU;
 });
 
 // END
 returnToMenuButton = new TextButton("RETURN TO MENU", width / 2f, height / 2f + 55, 200, 25);
 returnToMenuButton.addAction(() -> {
   currentScreen = SCREEN_TYPES.MENU;
 });
}

void draw() {
  screen.beginDraw();
  screen.background(128);
  
  if (currentScreen == SCREEN_TYPES.MENU) {
    int minutes = highscoreMinutes[levelDropdown.getCurrentOption()];
    int seconds = highscoreSeconds[levelDropdown.getCurrentOption()];
    String time = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
    
    screen.textSize(20);
    float textHeight = (screen.textAscent() + screen.textDescent()) * 0.75f;
    screen.text("Highscore: " + time, screen.width / 2f - screen.textWidth("Highscore: " + time) / 2f, screen.height / 2f - 100f + textHeight / 2f);
    
    startButton.display(screen);
    loadButton.display(screen);
    exitButton.display(screen);
    levelDropdown.display(screen);
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
    
    board.display(screen);
    for (int i = 0; i < 9; i++) {
     numberButtons[i].display(screen); 
    }
    saveButton.display(screen);
    backToMenuButton.display(screen);
    
    screen.textSize(20);
    float textHeight = (screen.textAscent() + screen.textDescent()) * 0.75f;
    int minutes = currentMinutes;
    int seconds = currentSeconds;
    String time = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
    screen.text(time, screen.width / 2f - screen.textWidth(time) / 2f, 25 + textHeight / 2f);
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    returnToMenuButton.display(screen);
  }
  
  screen.endDraw();
  image(screen, 0, 0);
}

void mousePressed() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    levelDropdown.mousePressed();
    if (!levelDropdown.areOptionsVisible()) {
      startButton.mousePressed();
      loadButton.mousePressed();
      exitButton.mousePressed();
    }
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    board.mousePressed();
    for (int i = 0; i < 9; i++) {
     numberButtons[i].mousePressed();
    }
    saveButton.mousePressed();
    backToMenuButton.mousePressed();
    
    if (board.checkBoard()) {
       if (highscoreMinutes[levelDropdown.getCurrentOption()] < currentMinutes) {
          highscoreMinutes[levelDropdown.getCurrentOption()] = currentMinutes;
          highscoreSeconds[levelDropdown.getCurrentOption()] = currentSeconds;
          
          // save highscores
          saveHighscoresToJson();
       }
       else if (highscoreMinutes[levelDropdown.getCurrentOption()] == currentMinutes && highscoreSeconds[levelDropdown.getCurrentOption()] < currentSeconds) {
          highscoreSeconds[levelDropdown.getCurrentOption()] = currentSeconds;
          
          // save highscores
          saveHighscoresToJson();
       }
       
       currentScreen = SCREEN_TYPES.END;
    }
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    returnToMenuButton.mousePressed();
  }
}

void mouseReleased() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    levelDropdown.mouseReleased();
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    
  }
}

void mouseDragged() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    levelDropdown.mouseDragged();
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    
  }
}

void saveHighscoresToJson() {
  JSONObject highscoreJson = new JSONObject();
  
  JSONArray levelsArray = new JSONArray();
  for (int i = 0; i < highscoreSeconds.length; i++) {
    JSONObject levelJsonObject = new JSONObject();
    levelJsonObject.setInt("Minutes", highscoreMinutes[i]);
    levelJsonObject.setInt("Seconds", highscoreSeconds[i]);
    
    levelsArray.append(levelJsonObject);
  }
  
  highscoreJson.setJSONArray("Highscores", levelsArray);
  
  saveJSONObject(highscoreJson, "./data/highscores.json");
}

void loadHighscoresFromJson() {
  JSONObject highscoreJson = loadJSONObject("./data/highscores.json");
  
  JSONArray levelsArray = highscoreJson.getJSONArray("Highscores");
  for (int i = 0; i < levelsArray.size(); i++) {
    highscoreMinutes[i] = levelsArray.getJSONObject(i).getInt("Minutes"); 
    highscoreSeconds[i] = levelsArray.getJSONObject(i).getInt("Seconds");
  }
}

void saveSudokuBoardToJson() {
 JSONObject sudokuJson = new JSONObject();
 sudokuJson.setInt("Difficulty", levelDropdown.getCurrentOption());
 
 JSONObject currentTime = new JSONObject();
 currentTime.setInt("Miliseconds", currentMiliseconds);
 currentTime.setInt("Seconds", currentSeconds);
 currentTime.setInt("Minutes", currentMinutes);
 
 sudokuJson.setJSONObject("Time", currentTime);
 
 sudokuJson.setJSONObject("Board", board.getJSONObject());
 
 saveJSONObject(sudokuJson, "./data/sudoku.json");
}

void loadSudokuBoardFromJson() {
  JSONObject sudokuJson = loadJSONObject("./data/sudoku.json");
  
  levelDropdown.setCurrentOption(sudokuJson.getInt("Difficulty"));
  
  JSONObject currentTime = sudokuJson.getJSONObject("Time");
  currentMiliseconds = currentTime.getInt("Miliseconds");
  currentSeconds = currentTime.getInt("Seconds");
  currentMinutes = currentTime.getInt("Minutes");
  
  board.loadJSONObject(sudokuJson.getJSONObject("Board"));
}
