let screenImg;

let started;
let ended;

let currentMiliseconds;
let currentSeconds;
let currentMinutes;

let hasHighscore;
let highscoreSeconds;
let highscoreMinutes;

// CENTER
let board;
let timeText;
let solvedText;
let newHighscoreText;

// LEFT
let titleText;
let highscoreText;

let generatePuzzleButton;

let loadHighscoreFromFileButton;
let saveHighscoreToFileButton;

let loadGameButton;
let loadGameFromFileButton;
let saveGameButton;
let saveGameToFileButton;

let clearDataButton;

function setup() {
  createCanvas(windowWidth, windowHeight);
  
  screenImg = createGraphics(width, height);
  
  started = false;
  ended = false;
  
  currentMiliseconds = 0;
  currentSeconds = 0;
  currentMinutes = 0;
  
  // load highscore
  if (!loadHighscore()) {
    hasHighscore = false;
    highscoreSeconds = 0;
    highscoreMinutes = 0;
    console.log("CAN'T LOAD HIGHSCORE");
    if (!saveHighscore()) {
      console.log("CAN'T SAVE HIGHSCORE"); 
    }
    else {
      console.log("HIGHSCORE SAVED");
    }
  }
  else {
    console.log("HIGHSCORE LOADED");
  }

  
  // CENTER
  board = new PietnastkaBoard(width / 2, height / 2);
  timeText = new Text(width / 2, height / 2 - 200, str(currentMinutes >= 10 ? currentMinutes : "0" + currentMinutes) + ":" + str(currentSeconds >= 10 ? currentSeconds : "0" + currentSeconds));
  
  solvedText = new Text(width / 2, height / 2 - 300, "SOLVED");
  solvedText.setSize(40);
  
  newHighscoreText = new Text(width / 2, height / 2 - 260, "New Highscore");
  newHighscoreText.setColor(color(255, 0, 0));
  
  // load last game
  if (loadGame()) {
     started = true;
     
     newHighscoreText.enable(false);
     solvedText.enable(false);
     console.log("GAME LOADED");
  }
  else {
    console.log("CAN'T LOAD LAST GAME"); 
  }
  
  // LEFT
  let startY = height / 2 - 300;
  let buttonsX = 175;
  let buttonsWidth = 250;
  
  titleText = new Text(50, startY, "15 PUZZLE");
  titleText.setSize(40);
  titleText.setAlign(LEFT);
  
  let highscore;
  if (hasHighscore) {
    highscore = "Highscore: " + str(highscoreMinutes >= 10 ? highscoreMinutes : "0" + highscoreMinutes) + ":" + str(highscoreSeconds >= 10 ? highscoreSeconds : "0" + highscoreSeconds); 
  }
  else {
    highscore = "No Highscore"; 
  }
  
  startY += 50;
  highscoreText = new Text(50, startY, highscore);
  highscoreText.setAlign(LEFT);
  
  startY += 50;
  generatePuzzleButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Generate Puzzle");
  generatePuzzleButton.addAction(() => {
    started = true;
    ended = false;
    
    currentMiliseconds = 0;
    currentSeconds = 0;
    currentMinutes = 0;
    timeText.setText("00:00");
    
    newHighscoreText.enable(false);
    solvedText.enable(false);
    
    board.generate();
  });
  
  startY += 60;
  loadHighscoreFromFileButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Load Highscore From File");
  loadHighscoreFromFileButton.addAction(() => {
    loadHighscoreFromJson();
    console.log("HIGHSCORE LOADED FROM FILE");
  });
  
  startY += 60;
  saveHighscoreToFileButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Save Highscore To File");
  saveHighscoreToFileButton.addAction(() => {
    saveHighscoreToJson();
    console.log("HIGHSCORE SAVED TO FILE");
  });
  
  startY += 60;
  loadGameButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Load Last Game");
  loadGameButton.addAction(() => {
    if (loadGame()) {
       started = true;
       ended = false;
       
       newHighscoreText.enable(false);
       solvedText.enable(false);
       console.log("LAST GAME LOADED");
    }
    else {
      console.log("CAN'T LOAD LAST GAME");
    }
  });
  
  startY += 60;
  loadGameFromFileButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Load Game From File");
  loadGameFromFileButton.addAction(() => {
    loadGameFromJson();
    console.log("GAME LOADED FROM FILE");
  });
  
  startY += 60;
  saveGameButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Save Game");
  saveGameButton.addAction(() => {
    if (saveGame()) {
      console.log("GAME SAVED"); 
    }
    else {
      console.log("CAN'T SAVE GAME"); 
    }
  });
  
  startY += 60;
  saveGameToFileButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Save Game To File");
  saveGameToFileButton.addAction(() => {
    saveGameToJson();
    console.log("GAME SAVED TO FILE");
  });
  
  startY += 60;
  clearDataButton = new TextButton(buttonsX, startY, buttonsWidth, 50, "Clear Data");
  clearDataButton.addAction(() => {
    clearData();
    console.log("DATA CLEARED");
  });
}

function draw() {
  screenImg.push();
  
  screenImg.background(200);
  
  // CENTER
  if (started) {
    if (!ended) {
      if (getFrameRate() != 0 && !board.isAnimating()) {
        currentMiliseconds += int(1000 / getFrameRate());
        if (currentMiliseconds >= 1000) {
          currentSeconds += int(currentMiliseconds / 1000);
          currentMiliseconds = currentMiliseconds % 1000;
        }
        if (currentSeconds >= 60) {
          currentMinutes += int(currentSeconds / 60);
          currentSeconds = currentSeconds % 60;
        }
      }
    }
    
    timeText.setText(str(currentMinutes >= 10 ? currentMinutes : "0" + currentMinutes) + ":" + str(currentSeconds >= 10 ? currentSeconds : "0" + currentSeconds));
    timeText.draw(screenImg);
    
    if (solvedText.isEnabled()) {
      solvedText.draw(screenImg);
    }
    
    if (newHighscoreText.isEnabled()) {
      newHighscoreText.draw(screenImg);
    }
    
    board.draw(screenImg);
  }
  
  // LEFT
  titleText.draw(screenImg);
  
  let highscore;
  if (hasHighscore) {
    highscore = "Highscore: " + str(highscoreMinutes >= 10 ? highscoreMinutes : "0" + highscoreMinutes) + ":" + str(highscoreSeconds >= 10 ? highscoreSeconds : "0" + highscoreSeconds);
  }
  else {
    highscore = "No Highscore";
  }
  
  highscoreText.setText(highscore);
  highscoreText.draw(screenImg);
  
  generatePuzzleButton.draw(screenImg);
  
  loadHighscoreFromFileButton.draw(screenImg);
  saveHighscoreToFileButton.draw(screenImg);
  
  let lastGameExist = localStorage.getItem("Game.Exist");
  if (lastGameExist != null) {
    loadGameButton.setColor(color(255)); 
  }
  else {
    loadGameButton.setColor(color(170));
  }
  loadGameButton.draw(screenImg);
  loadGameFromFileButton.draw(screenImg);
  
  if (ended || !started) {
    saveGameButton.setColor(color(170));
    saveGameToFileButton.setColor(color(170));
  }
  else {
    saveGameButton.setColor(color(255));
    saveGameToFileButton.setColor(color(255));
  }
  saveGameButton.draw(screenImg);
  saveGameToFileButton.draw(screenImg);
  
  clearDataButton.draw(screenImg);
  
  image(screenImg, 0, 0);
  screenImg.pop();
}

function mouseClicked() {
  generatePuzzleButton.mouseClicked();
  
  loadHighscoreFromFileButton.mouseClicked();
  saveHighscoreToFileButton.mouseClicked();
  
  let lastGameExist = localStorage.getItem("Game.Exist");
  if (lastGameExist != null) {
    loadGameButton.mouseClicked();
  }
  loadGameFromFileButton.mouseClicked();
  
  
  if (!ended && started) {
    saveGameButton.mouseClicked();
    saveGameToFileButton.mouseClicked();
    board.mouseClicked();
  }
  
  clearDataButton.mouseClicked();
  
  if (board.checkBoard()) {
    ended = true;
    
    solvedText.enable(true);
    
    if (currentMinutes < highscoreMinutes) {
      highscoreMinutes = currentMinutes;
      highscoreSeconds = currentSeconds;
      
      newHighscoreText.enable(true);
      
      if (saveHighscore()) {
        console.log("NEW HIGHSCORE SAVED"); 
      }
      else {
        console.log("CAN'T SAVE NEW HIGHSCORE");
      }
    }
    else if (currentMinutes == highscoreMinutes && currentSeconds < highscoreSeconds) {
      highscoreSeconds = currentSeconds;
      
      newHighscoreText.enable(true);
      
      if (saveHighscore()) {
        console.log("NEW HIGHSCORE SAVED");
      }
      else {
        console.log("CAN'T SAVE NEW HIGHSCORE");
      }
    }
    else if (!hasHighscore) {
      hasHighscore = true;
      highscoreMinutes = currentMinutes;
      highscoreSeconds = currentSeconds;
      
      newHighscoreText.enable(true);
      
      if (saveHighscore()) {
        console.log("NEW HIGHSCORE SAVED"); 
      }
      else {
        console.log("CAN'T SAVE NEW HIGHSCORE");
      }
    }
  }
}


// LOCAL STORAGE
function clearData() {
  localStorage.clear();
  
  hasHighscore = false;
  highscoreMinutes = 0;
  highscoreSeconds = 0;
  
  started = false;
  ended = false;
}

function saveHighscore() {
  localStorage.setItem("Highscore.HasHighscore", hasHighscore);
  localStorage.setItem("Highscore.Minutes", highscoreMinutes);
  localStorage.setItem("Highscore.Seconds", highscoreSeconds);
  localStorage.setItem("Highscore.Exist", true);
  return true;
}

function loadHighscore() {
  let exists = localStorage.getItem("Highscore.Exist");
  if (exists != null) {
    hasHighscore = boolean(localStorage.getItem("Highscore.HasHighscore"));
    highscoreMinutes = int(localStorage.getItem("Highscore.Minutes"));
    highscoreSeconds = int(localStorage.getItem("Highscore.Seconds"));
    return true;
  }
  return false;
}

function saveGame() {
  localStorage.setItem("Game.Time.Miliseconds", currentMiliseconds);
  localStorage.setItem("Game.Time.Seconds", currentSeconds);
  localStorage.setItem("Game.Time.Minutes", currentMinutes);
  if (board.saveBoard()) {
    localStorage.setItem("Game.Exist", true);
    return true;
  }
  return false;
}

function loadGame() {
  let exists = localStorage.getItem("Game.Exist");
  if (exists != null) {
    currentMiliseconds = int(localStorage.getItem("Game.Time.Miliseconds"));
    currentSeconds = int(localStorage.getItem("Game.Time.Seconds"));
    currentMinutes = int(localStorage.getItem("Game.Time.Minutes"));
    if (board.loadBoard()) {
      return true; 
    }
  }
  return false;
}

function saveHighscoreToJson() {
  let highscoreJson = JSON.parse("{}");
  highscoreJson["HasHighscore"] = hasHighscore;
  highscoreJson["Minutes"] = highscoreMinutes;
  highscoreJson["Seconds"] = highscoreSeconds;
  
  sendJsonToDownload(highscoreJson, "15Puzzle_highscore.json");
}

function loadHighscoreFromJson() {
  importFile((file) => {
     if (file.type != 'application/json') {
       console.log("WRONG FILE TYPE"); 
     }
     else {
       readTextFile(file, (content) => {
         highscoreJson = JSON.parse(content);
         hasHighscore = highscoreJson['HasHighscore'];
         highscoreMinutes = highscoreJson['Minutes'];
         highscoreSeconds = highscoreJson['Seconds'];
         if (saveHighscore()) {
           console.log("LOADED HIGHSCORE SAVED"); 
         }
         else {
           console.log("CAN'T SAVE LOADED HIGHSCORE");
         }
       });
     }
  });
}

function saveGameToJson() {
  let gameJson = JSON.parse("{}");
  
  let timeJson = JSON.parse("{}");
  timeJson["Minutes"] = currentMinutes;
  timeJson["Seconds"] = currentSeconds;
  timeJson["Miliseconds"] = currentMiliseconds;
  
  gameJson["Time"] = timeJson;
  gameJson["Board"] = board.getJson();
  
  sendJsonToDownload(gameJson, "15Puzzle_game.json");
}

function loadGameFromJson() {
  importFile((file) => {
     if (file.type != 'application/json') {
       console.log("WRONG FILE TYPE"); 
     }
     else {
       readTextFile(file, (content) => {
       gameJson = JSON.parse(content);
       
       timeJson = gameJson['Time'];
       currentMinutes = timeJson['Minutes'];
       currentSeconds = timeJson['Seconds'];
       currentMiliseconds = timeJson['Miliseconds'];
       
       board.loadJson(gameJson['Board']);
       
       started = true;
       ended = false;
    
       newHighscoreText.enable(false);
       solvedText.enable(false);
       });
     }
  });
}

function readTextFile(file, callback) {
  let reader = new FileReader();
       
   reader.onload = (function(theFile) { 
       return function(e) {
         let content = e.target.result;
         if (content) {
           callback(content);
         }
       };
   })(file);
   
   reader.readAsText(file);
}

function importFile(callback) {
  let input = document.createElement('input');
  input.style = "display: none";
  input.type = 'file';
  input.onchange = _ => {
    let files = Array.from(input.files);
    if (files.length > 0) {
      callback(files[0]);
    }
    else {
      console.log("NO FILES LOADED"); 
    }
  };
  input.click();
  input.remove();
}

function sendJsonToDownload(json, fileName) {
  let file = new Blob([JSON.stringify(json)], {type: "application/json"}),
      url = window.URL.createObjectURL(file);
  
  let a = document.createElement("a");
  a.style = "display: none";
  a.href = url;
  a.download = fileName;
  a.click();
  a.remove();
  window.URL.revokeObjectURL(url);
}
