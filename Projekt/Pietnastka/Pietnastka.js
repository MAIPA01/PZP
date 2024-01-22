let screen;

let board;

function setup() {
  createCanvas(windowWidth, windowHeight);
  
  screen = createGraphics(width, height);
  
  board = new PietnastkaBoard(width / 2, height / 2);
}

function draw() {
  screen.push();
  
  screen.background(200);
  
  board.draw(screen);
  
  image(screen, 0, 0);
  
  screen.pop();
}

function mouseClicked() {
  
}
