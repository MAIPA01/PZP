let screen;

let testButton;

function setup() {
  createCanvas(windowWidth, windowHeight);
  
  screen = createGraphics(width, height);
  
  testButton = new TextButton(width / 2, height / 2, 100, 20, "TEST");
  testButton.addAction(function () {
    console.log("TEST");
  });
}

function draw() {  
  screen.beginDraw();
  
  screen.background(255);
  
  testButton.draw(screen);
  
  screen.endDraw();
  
  image(screen);
}

function mousePressed() {
  testButton.mousePressed(); 
}
