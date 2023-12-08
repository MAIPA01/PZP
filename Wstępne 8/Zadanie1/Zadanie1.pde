PGraphics cubeA;
PGraphics cubeB;

void setup() {
  size(200, 200, P3D); 
  cubeA = createGraphics(width, height, P3D);
  cubeB = createGraphics(width, height, P3D);
} 

void draw() {
  background(0);
  //blendMode(MULTIPLY);
  //blendMode(BLEND);
  //blendMode(ADD);
  //blendMode(SUBTRACT);
  //blendMode(DARKEST);
  //blendMode(LIGHTEST);
  //blendMode(DIFFERENCE);
  //blendMode(EXCLUSION);
  //blendMode(SCREEN);
  //blendMode(REPLACE);
  drawCube(cubeA, 100, 200);
  //tint(255, (mouseX * 255.f) / width);
  image(cubeA, 0, 0);
  drawCube(cubeB, 20, 50);
  //tint(255, (mouseY * 255.f) / height);
  image(cubeB, 0, 0);
}

void drawCube(PGraphics cube, float xr, float yr) {
  cube.beginDraw();
  cube.lights();
  cube.clear();
  cube.noStroke();
  cube.translate(cube.width/2, cube.height/2);
  cube.rotateX(frameCount/xr);
  cube.rotateY(frameCount/yr);
  cube.box(80);
  cube.endDraw(); 
}
