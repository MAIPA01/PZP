PShape bomba;
PShape pomarancza;
PShape wiadro;
float wwidth;
float pheight;
PFont font;

class Item {
  public boolean isBomb;
  public float x;
  public float y;
  public float speed;
  public PShape shape;
}

ArrayList<Item> itemyNaEkranie = new ArrayList<Item>();

float points = 0f;

float timeToNextItem = 2f;
float currTime = 2f;

boolean started = false;

void setup() {
  size(500, 1000);
  smooth();
  bomba = loadShape("bomba.svg");
  pomarancza = loadShape("pomarancza.svg");
  wiadro = loadShape("wiadro.svg");
  PShape wiadrowiadro = wiadro.getChild("Wiadro");
  PShape podstawka = wiadro.getChild("Podstawka");
  
  wwidth = wiadro.width * (wiadrowiadro.width / podstawka.width);
  pheight = wiadro.height * (podstawka.height / wiadrowiadro.height);
  
  wiadro.setVisible(false);
  pomarancza.setVisible(false);
  bomba.setVisible(false);
  
  font = createFont("Shintia.otf", 50);
  textSize(200);
  textFont(font);
  textAlign(CENTER);
}

void draw() {
  background(0, 119, 179);
  
  if (started) {
    float deltaTime = 1f / frameRate;
    
    fill(128, 212, 25);
    text((int)points, width / 2f, height / 2f);
    
    int deleted = 0;
    for (int i = 0; i - deleted < itemyNaEkranie.size(); i++) {
      Item item = itemyNaEkranie.get(i - deleted);
      item.y += deltaTime * item.speed;
      if (item.y + item.shape.height >= height - wiadro.height && item.y + item.shape.height / 2.f <= height - pheight && item.x + item.shape.width / 2f >= mouseX - wwidth / 2.f && item.x + item.shape.width / 2f <= mouseX + wwidth / 2f) {
       points += item.isBomb ? -1.f : 1.f;
       itemyNaEkranie.remove(i - deleted);
       deleted++;
       println("SCORE: " + points);
      }
      else if (item.y >= height) {
         itemyNaEkranie.remove(i - deleted);
         deleted++;
         println("MISSED");
      }
      else {
       shape(item.shape, item.x, item.y); 
      }
    }
    
    currTime -= deltaTime;
    if (currTime <= 0f) {
      println("SPAWN");
     currTime = random(0.5f, timeToNextItem);
     Item item = new Item();
     item.isBomb = random(1f) > 0.5f;
     item.shape = item.isBomb ? bomba : pomarancza;
     item.speed = random(100.f, 400.f);
     item.x = random(0.f, width - item.shape.width);
     item.y = 0f;
     itemyNaEkranie.add(item);
    }
  }
  else {
    fill(255);
    rect(width / 2f - 100, height / 2f - 50, 200, 100);
    fill(0);
    text("Start", width / 2f, height / 2f + 25);
  }
  
  if (wiadro.isVisible()) {
    shape(wiadro, mouseX - wiadro.width / 2f, height - wiadro.height);
  }
}

void mousePressed() {
 if (mouseButton == LEFT) {
  if (mouseX >= width / 2f - 100 && mouseX <= width / 2f + 100 && mouseY >= height / 2f - 50 && mouseY <= height / 2f + 50) {
   started = true;
   wiadro.setVisible(true);
   pomarancza.setVisible(true);
   bomba.setVisible(true);
  }
 }
}
