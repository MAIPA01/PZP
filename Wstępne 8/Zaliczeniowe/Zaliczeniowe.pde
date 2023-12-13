PGraphics scena;

PShape rocket;
PImage texture;
boolean textureEnabled = true;

PShape cone;

boolean zapisuje = false;

boolean spotlight = false;
boolean dirlight = true;
boolean pointlight = false;

enum ObjectType { CUBE, ROCKET, CONE };
class Object {
  public ObjectType type;
 public float x;
 public float y;
 public float z;
 public float size;
}
ArrayList<Object> objects = new ArrayList<Object>();

PShape makeCone(int segments) {
  PShape temp = createShape();
  temp.beginShape(TRIANGLES);
  float angle = 360.f / segments;
  for (int i = 0; i <= segments; i++) {
    // Dolny Trójkąt
    temp.vertex(cos(radians(angle * i)), sin(radians(angle * i)), -1);
    temp.vertex(0, 0, -1);
    temp.vertex(cos(radians(angle * ((i + 1) % segments))), sin(radians(angle * ((i + 1) % segments))), -1);
    
    // Boczny Trójkąt
    temp.vertex(cos(radians(angle * ((i + 1) % segments))), sin(radians(angle * ((i + 1) % segments))), -1);
    temp.vertex(cos(radians(angle * i)), sin(radians(angle * i)), -1);
    temp.vertex(0, 0, 1);
  }
  temp.endShape();
  return temp;
}

void setup() {
  size(800, 600, P3D);
  scena = createGraphics(800, 600, P3D);
  
  //noStroke();
  scena.perspective(90.f * PI / 180.f, width / height, 0.1f, 1000.f);
  
  rocket = loadShape("rocket/rocket.obj");
  texture = loadImage("rocket/rocket.png");
  cone = makeCone(10);
  
  int number = (int)random(5, 20);
  for (int i = 0; i < number; i++) {
    Object ob = new Object();
    
    int type = (int)random(0, 3);
    if (type == 0) ob.type = ObjectType.CUBE;
    else if (type == 1) ob.type = ObjectType.ROCKET;
    else ob.type = ObjectType.CONE;
    
    float alpha = random(0f, 360f);
    float dist = random(600f, 1000f);
    
    ob.x = sin(radians(alpha)) * dist + width / 2f;
    ob.y = 0;
    ob.z = cos(radians(alpha)) * dist;
    
    ob.size = random(-80, 80);
    objects.add(ob);
  }
}

void draw() {
  scena.beginDraw();
  scena.background(0);
  Camera();
  
  //scena.lights();
  scena.ambientLight(50, 50, 50);
  if (pointlight) scena.pointLight(0, 255, 0, 0, 200, 200);
  if (dirlight) scena.directionalLight(255, 255, 0, 0, 1, -1);
  if (spotlight) { 
    float alpha = (((float)mouseX * 360f) / (float)width);
    scena.spotLight(255, 0, 255, -sin(radians(alpha)) * 20 + width / 2f, 0, cos(radians(alpha)) * 20, -sin(radians(alpha)), 0, cos(radians(alpha)), 90.f, 255);
  }

  for (int i = 0; i < objects.size(); i++) {
   Object ob = objects.get(i);
   if (ob.type == ObjectType.CUBE) {
    drawCube(ob.x, ob.y, ob.z, ob.size);
   }
   else if (ob.type == ObjectType.ROCKET) {
    drawShape(rocket, ob.x, ob.y, ob.z, 1); 
   }
   else if (ob.type == ObjectType.CONE) {
    drawShape(cone, ob.x, ob.y, ob.z, ob.size); 
   }
  }
  
  
  scena.endDraw();
  image(scena, 0, 0);
  
  if (zapisuje) {
   scena.save("test.png");
   zapisuje = false;
  }
}

void keyPressed() {
  if (key != CODED) {
   if (key == 't') {
     textureEnabled = !textureEnabled;
     if (textureEnabled) {
      rocket.setTexture(texture); 
     }
     else {
      rocket.setTexture(null); 
     }
   }
   if (key == 'p') {
     pointlight = true;
     spotlight = false;
     dirlight = false;
   }
   if (key == 'd') {
     pointlight = false;
     spotlight = false;
     dirlight = true;
   }
   if (key == 's') {
     pointlight = false;
     spotlight = true;
     dirlight = false;
   }
   if (key == 'z') {
     zapisuje = true;
   }
  }
}

void Camera() {
 scena.beginCamera();
 float dist = width / 2f;
 float alpha = (((float)mouseX * 360f) / (float)width); //<>//
 scena.camera(width / 2f, 0, 0, -sin(radians(alpha)) * dist + width / 2f, 0, cos(radians(alpha)) * dist, 0, 1, 0);
 scena.endCamera();
}

void drawCube(float x, float y, float z, float size) {
  scena.pushMatrix();
  scena.pushStyle();
  scena.translate(x, y, z);
  //ambient(0, 0, 255);
  //fill(255);
  scena.box(size);
  scena.popStyle();
  scena.popMatrix();
}

void drawShape(PShape shape, float x, float y, float z, float size) {
  scena.pushMatrix();
  scena.pushStyle();
  scena.translate(x, y, z);
  scena.scale(size);
  //ambient(0, 0, 255);
  scena.shape(shape);
  scena.popStyle();
  scena.popMatrix();
}
