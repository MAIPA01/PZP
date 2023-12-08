PImage tex;
PShape sphere;

PShape rocket;
PShape texRocket;

void setup(){
  size(800, 600, P3D);
  tex = loadImage("earth.jpg");
  sphere = createShape(SPHERE, 100);
  sphere.setTexture(tex);
  sphere.beginShape(SPHERE);
  sphere.noStroke();
  //sphere.fill(255, 0, 0);
  sphere.endShape();
  
  rocket = loadShape("rocket.obj");
  
  texRocket = loadShape("rocket/rocket.obj");
  
  noLoop();
}

void drawPiramid() {
  beginShape();
  vertex(-100, -100, -100);
  vertex( 100, -100, -100);
  vertex(   0,    0,  100);
  vertex( 100, -100, -100);
  vertex( 100,  100, -100);
  vertex(   0,    0,  100);
  vertex( 100, 100, -100);
  vertex(-100, 100, -100);
  vertex(   0,   0,  100);
  vertex(-100,  100, -100);
  vertex(-100, -100, -100);
  vertex(   0,    0,  100);
  endShape();
}

void drawWalec() {
  beginShape();
  float angle = 360.f / 10.f;
  for (int i = 0; i < 10; i++) {
    // Podstawa dolna
    vertex(cos(radians(angle * i)) * 100.f, sin(radians(angle * i)) * 100.f, -100);
    vertex(0, 0, -100);
    vertex(cos(radians(angle * (i + 1))) * 100.f, sin(radians(angle * (i + 1))) * 100.f, -100);
    vertex(cos(radians(angle * i)) * 100.f, sin(radians(angle * i)) * 100.f, -100);
    
    // Podstawa górna
    vertex(cos(radians(angle * i)) * 100.f, sin(radians(angle * i)) * 100.f, 100);
    vertex(0, 0, 100);
    vertex(cos(radians(angle * (i + 1))) * 100.f, sin(radians(angle * (i + 1))) * 100.f, 100);
    vertex(cos(radians(angle * i)) * 100.f, sin(radians(angle * i)) * 100.f, 100);
  }
  endShape();
}

void drawCone() {
    beginShape();
  float angle = 360.f / 10.f;
  for (int i = 0; i < 10; i++) {
    // Podstawa dolna
    vertex(cos(radians(angle * i)) * 100.f, sin(radians(angle * i)) * 100.f, -100);
    vertex(0, 0, -100);
    vertex(cos(radians(angle * (i + 1))) * 100.f, sin(radians(angle * (i + 1))) * 100.f, -100);
    vertex(cos(radians(angle * i)) * 100.f, sin(radians(angle * i)) * 100.f, -100);
    
    // Punkt górny
    vertex(0, 0, 100);
  }
  endShape();
}

void draw() {
  background(0);
  lights();
  pushMatrix();
  translate(width/4, height/2, 0);
  shape(sphere);
  popMatrix();
  noFill();
  stroke(255);
  pushMatrix();
  translate(width*3/4, height/2, 0);
  //rotateX(PI/2);
  //drawPiramid();
  //drawWalec();
  //drawCone();
  //shape(rocket);
  shape(texRocket);
  popMatrix();
}
