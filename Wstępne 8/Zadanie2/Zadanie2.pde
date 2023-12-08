int viewType = 0;

void setup() {
  size(600, 360, P3D);
  fill(255);
  noStroke();
  //noLoop();
}

void draw() {
  background(0);
  lights();
  ambientLight(0,0,255);
  //pointLight(0, 255, 0, 0, 200, 200);
  //directionalLight(0, 255, 0, 0, 1, -1);
  spotLight(0, 255, 0, width/2, height/2, 0, 0, 1, -1, 90.f, 255);
  if (viewType == 0) {
    perspective(90.f * PI / 180.f, width / height, 0.1f, 1000.f);
  }
  else if (viewType == 1) {
     ortho(); 
  }
  camera(width/2 + mouseY, height/2, 0, 0, 0, 0, 0, 1, 0);
  //translate(width/2, height/2, 0);
  rotateX(-PI/6 + (mouseX * PI/2) / width);
  rotateY(PI/3);
  ambient(0, 0, 255);
  box(180);
  sphere(110);
}

void mousePressed() {
  viewType = (viewType + 1) % 2;
}
