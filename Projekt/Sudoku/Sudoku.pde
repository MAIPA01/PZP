Dropdown select;

PGraphics screen;

enum SCREEN_TYPES { 
  MENU, 
  GAME, 
  END
};
SCREEN_TYPES currentScreen = SCREEN_TYPES.MENU;

// MENU
Text titleText;
int highscoreSeconds[] = { 0, 0, 0 };
int highscoreMinutes[] = { 0, 0, 0 };
boolean hasHighscore[] = { false, false, false };
Text highscoreText;
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
Text timeText;

// END
Text endText;
Text newHighscoreText;
Text endTimeText;
TextButton returnToMenuButton;
boolean newRekord = false;

void setup() {
 orientation(PORTRAIT);
 fullScreen();
 
 screen = createGraphics(width, height);
 
 // LOAD HIGHSCORES
 File f = dataFile(".\\data\\highscores.json");
 if (f.exists() && f.isFile()) {
   loadHighscoresFromJson();
 }
 else {
   saveHighscoresToJson();
 }
 
 // MENU
 titleText = new Text(width / 2f, height / 2f - 350f * displayDensity, "SUDOKU");
 titleText.setTextSize(75f * displayDensity);
 
 levelDropdown = new Dropdown(width / 2f, height / 2f - 150f * displayDensity, int(200 * displayDensity), int(50 * displayDensity), int(200 * displayDensity));
 levelDropdown.addOption("EASY");
 levelDropdown.addOption("MEDIUM");
 levelDropdown.addOption("HARD");
 levelDropdown.setCurrentOption(0);
 levelDropdown.setTextSize(20f * displayDensity);
 levelDropdown.setScrollWidth(20f * displayDensity);
 
 highscoreText = new Text(width / 2f, height / 2f - 75f * displayDensity, "No Highscore");
 highscoreText.setTextSize(20f * displayDensity);
 
 startButton = new TextButton("START", width / 2f, height / 2f, 200 * displayDensity, 50 * displayDensity);
 startButton.setTextSize(20f * displayDensity);
 startButton.addAction(new ButtonAction() {
   @Override
   public void Invoke() {
     if (levelDropdown.getCurrentOption() == 0)
         board.generateLevel(SUDOKU_LEVEL.EASY);
       else if (levelDropdown.getCurrentOption() == 1)
         board.generateLevel(SUDOKU_LEVEL.MEDIUM);
       else if (levelDropdown.getCurrentOption() == 2)
         board.generateLevel(SUDOKU_LEVEL.HARD);
       
       board.setChoosed(0);
       for (int i = 0; i < 9; i++) {
        numberButtons[i].setColor(color(255));
        numberButtons[i].setHasStroke(false);  
        numberButtons[i].setTextColor(color(0));
       }
       
       currentMiliseconds = 0;
       currentSeconds = 0;
       currentMinutes = 0;
       
       currentScreen = SCREEN_TYPES.GAME;
     }
 });
 
 loadButton = new TextButton("LOAD", width / 2f, height / 2f + 75f * displayDensity, 200 * displayDensity, 50 * displayDensity);
 loadButton.setTextSize(20f * displayDensity);
 loadButton.addAction(new ButtonAction() {
   @Override
   public void Invoke() {
    File json = dataFile(".\\data\\sudoku.json");
    if (json.exists() && json.isFile()) {
      // load sudoku board
     loadSudokuBoardFromJson();
     println("Loaded");
     
     board.setChoosed(0);
     for (int i = 0; i < 9; i++) {
      numberButtons[i].setColor(color(255));
      numberButtons[i].setHasStroke(false);  
      numberButtons[i].setTextColor(color(0));
     }
     currentScreen = SCREEN_TYPES.GAME;
    }
   }
 });
 
 exitButton = new TextButton("EXIT", width / 2f, height / 2f + 150f * displayDensity, 200 * displayDensity, 50 * displayDensity);
 exitButton.setTextSize(20f * displayDensity);
 exitButton.addAction(new ButtonAction() {
   @Override
   public void Invoke() {
     exit(); 
   }
 });
 
 // GAME
 board = new SudokuBoard();
 
 timeText = new Text(width / 2f, 25f * displayDensity, "00:00");
 timeText.setTextSize(20f * displayDensity);
 
 float buttonSize = width / (9f + 10f * 0.5f);
 float spacingSize = buttonSize * 0.5f;
 for (int i = 0; i < 9; i++) {
   numberButtons[i] = new TextButton("" + (i + 1), (i + 1) * spacingSize + i * buttonSize + spacingSize, height - 4 * buttonSize, buttonSize, buttonSize);
   numberButtons[i].setStrokeWeight(2);
   numberButtons[i].setStrokeColor(color(0));
   numberButtons[i].setTextSize(20f * displayDensity);
   
   final int index = i + 1;
   numberButtons[i].addAction(new ButtonAction() {
     @Override
     public void Invoke() {
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
     }
   });
 }
 
 saveButton = new TextButton("SAVE", width - 55f * displayDensity, 25f * displayDensity, int(100 * displayDensity), int(25 * displayDensity));
 saveButton.setTextSize(20 * displayDensity);
 saveButton.addAction(new ButtonAction() {
   @Override
   public void Invoke() {
     // save sudoku board
     saveSudokuBoardToJson();
     println("Saved");
   }
 });
 
 backToMenuButton = new TextButton("BACK", 55f * displayDensity, 25f * displayDensity, int(100 * displayDensity), int(25 * displayDensity));
 backToMenuButton.setTextSize(20f * displayDensity);
 backToMenuButton.addAction(new ButtonAction() {
   @Override
   public void Invoke() {
     currentScreen = SCREEN_TYPES.MENU;
   }
 });
 
 // END
 endText = new Text(width / 2f, 60f * displayDensity, "The End");
 endText.setTextSize(40 * displayDensity);
 endText.setColor(color(255));
 
 newHighscoreText = new Text(width / 2f, 120f * displayDensity, "New Highscore");
 newHighscoreText.setTextSize(20f * displayDensity);
 newHighscoreText.setColor(color(255, 0, 0));
 
 endTimeText = new Text(width / 2f, 150f * displayDensity, "00:00");
 endTimeText.setTextSize(20f * displayDensity);
 
 returnToMenuButton = new TextButton("RETURN TO MENU", width / 2f, height / 2f + 55f * displayDensity, int(200 * displayDensity), int(50 * displayDensity));
 returnToMenuButton.setTextSize(20f * displayDensity);
 returnToMenuButton.addAction(new ButtonAction() {
   @Override
   public void Invoke() {
     newRekord = false;
     currentScreen = SCREEN_TYPES.MENU;
   }
 });
}

void draw() {
  screen.beginDraw();
  screen.background(128);
  
  if (currentScreen == SCREEN_TYPES.MENU) {
    screen.pushMatrix();
    screen.pushStyle();
    
    titleText.draw(screen);
    
    String time = "";
    if (hasHighscore[levelDropdown.getCurrentOption()]) {
      int minutes = highscoreMinutes[levelDropdown.getCurrentOption()];
      int seconds = highscoreSeconds[levelDropdown.getCurrentOption()];
      time = "Highscore: " + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
    }
    else {
      time = "No Highscore"; 
    }
    
    highscoreText.setText(time);
    highscoreText.draw(screen);
    
    File f = dataFile(".\\data\\sudoku.json");
    if (f.exists() && f.isFile()) {
      loadButton.setColor(color(255));
    }
    else {
      loadButton.setColor(color(200));
    }
    
    startButton.draw(screen);
    loadButton.draw(screen);
    exitButton.draw(screen);
    levelDropdown.draw(screen);
    
    screen.popStyle();
    screen.popMatrix();
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    screen.pushMatrix();
    screen.pushStyle();
    
    currentMiliseconds += 1000f / frameRate;
    if (currentMiliseconds > 1000) {
      currentSeconds += currentMiliseconds / 1000;
      currentMiliseconds = currentMiliseconds % 1000;
    }
    if (currentSeconds > 60) {
      currentMinutes += currentSeconds / 60;
      currentSeconds = currentSeconds % 60;
    }
    
    board.draw(screen);
    for (int i = 0; i < 9; i++) {
     numberButtons[i].draw(screen); 
    }
    saveButton.draw(screen);
    backToMenuButton.draw(screen);
    
    int minutes = currentMinutes;
    int seconds = currentSeconds;
    String time = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
    
    timeText.setText(time);
    timeText.draw(screen);
    
    screen.popStyle();
    screen.popMatrix();
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    screen.pushMatrix();
    screen.pushStyle();
    
    endText.draw(screen);
    
    if (newRekord) {
      newHighscoreText.draw(screen);
    }
    
    int minutes = highscoreMinutes[levelDropdown.getCurrentOption()];
    int seconds = highscoreSeconds[levelDropdown.getCurrentOption()];
    String time = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
    endTimeText.setText(time);
    endTimeText.draw(screen);
    
    returnToMenuButton.draw(screen);
    
    screen.popStyle();
    screen.popMatrix();
  }
  
  screen.endDraw();
  image(screen, 0, 0);
}

void touchStarted() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    levelDropdown.touchStarted();
    if (!levelDropdown.areOptionsVisible()) {
      startButton.touchStarted();
      loadButton.touchStarted();
      exitButton.touchStarted();
    }
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    board.touchStarted();
    for (int i = 0; i < 9; i++) {
     numberButtons[i].touchStarted();
    }
    saveButton.touchStarted();
    backToMenuButton.touchStarted();
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    returnToMenuButton.touchStarted();
  }
}

void touchMoved() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    levelDropdown.touchMoved();
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    
  }
}

void touchEnded() {
  if (currentScreen == SCREEN_TYPES.MENU) {
    levelDropdown.touchEnded();
    if (!levelDropdown.areOptionsVisible()) {
      startButton.touchEnded();
      loadButton.touchEnded();
      exitButton.touchEnded();
    }
  }
  else if (currentScreen == SCREEN_TYPES.GAME) {
    board.touchEnded();
    for (int i = 0; i < 9; i++) {
     numberButtons[i].touchEnded();
    }
    saveButton.touchEnded();
    backToMenuButton.touchEnded();
    
    if (board.checkBoard()) {
       if (highscoreMinutes[levelDropdown.getCurrentOption()] > currentMinutes) {
          highscoreMinutes[levelDropdown.getCurrentOption()] = currentMinutes;
          highscoreSeconds[levelDropdown.getCurrentOption()] = currentSeconds;
          
          // save highscores
          saveHighscoresToJson();
          newRekord = true;
       }
       else if (highscoreMinutes[levelDropdown.getCurrentOption()] == currentMinutes && highscoreSeconds[levelDropdown.getCurrentOption()] > currentSeconds) {
          highscoreSeconds[levelDropdown.getCurrentOption()] = currentSeconds;
          
          // save highscores
          saveHighscoresToJson();
          newRekord = true;
       }
       else if (!hasHighscore[levelDropdown.getCurrentOption()]) {
          hasHighscore[levelDropdown.getCurrentOption()] = true;
          highscoreMinutes[levelDropdown.getCurrentOption()] = currentMinutes;
          highscoreSeconds[levelDropdown.getCurrentOption()] = currentSeconds;
          
          // save highscores
          saveHighscoresToJson();
          newRekord = true;
       }
       
       currentScreen = SCREEN_TYPES.END;
    }
  }
  else if (currentScreen == SCREEN_TYPES.END) {
    returnToMenuButton.touchEnded();
  }
}

void saveHighscoresToJson() {
  JSONObject highscoreJson = new JSONObject();
  
  JSONArray levelsArray = new JSONArray();
  for (int i = 0; i < highscoreSeconds.length; i++) {
    JSONObject levelJsonObject = new JSONObject();
    levelJsonObject.setBoolean("HasHighscore", hasHighscore[i]);
    levelJsonObject.setInt("Minutes", highscoreMinutes[i]);
    levelJsonObject.setInt("Seconds", highscoreSeconds[i]);
    
    levelsArray.append(levelJsonObject);
  }
  
  highscoreJson.setJSONArray("Highscores", levelsArray);
  
  saveJSONObject(highscoreJson, ".\\data\\highscores.json");
}

void loadHighscoresFromJson() {
  JSONObject highscoreJson = loadJSONObject(".\\data\\highscores.json");
  
  JSONArray levelsArray = highscoreJson.getJSONArray("Highscores");
  for (int i = 0; i < levelsArray.size(); i++) {
    JSONObject levelJsonObject = levelsArray.getJSONObject(i);
    hasHighscore[i] = levelJsonObject.getBoolean("HasHighscore");
    highscoreMinutes[i] = levelJsonObject.getInt("Minutes"); 
    highscoreSeconds[i] = levelJsonObject.getInt("Seconds");
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
 
 saveJSONObject(sudokuJson, ".\\data\\sudoku.json");
}

void loadSudokuBoardFromJson() {
  JSONObject sudokuJson = loadJSONObject(".\\data\\sudoku.json");
  
  levelDropdown.setCurrentOption(sudokuJson.getInt("Difficulty"));
  
  JSONObject currentTime = sudokuJson.getJSONObject("Time");
  currentMiliseconds = currentTime.getInt("Miliseconds");
  currentSeconds = currentTime.getInt("Seconds");
  currentMinutes = currentTime.getInt("Minutes");
  
  board.loadJSONObject(sudokuJson.getJSONObject("Board"));
}
