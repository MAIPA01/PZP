PShape obraz;
float angle = 0.f;

void setup() {
  size(500, 500);
  smooth();
  obraz = loadShape("plik2.svg");
}

void draw() {
  background(255);
  
  angle += 1.f;
  angle %= 360.f;
  println(angle);
  
  for(int i=0; i<6; i++) {
    if (obraz.getChild(i) == obraz.getChild("slonce")) {
      obraz.getChild(i).translate(-340.f - sin(radians(angle + 135.f)) * 360.f, 340.f + cos(radians(angle + 135.f)) * 360.f);
      shape(obraz.getChild(i), 0, 0); 
      obraz.getChild(i).translate(340.f + sin(radians(angle + 135.f)) * 360.f, -340.f - cos(radians(angle + 135.f)) * 360.f);
    }
    else if (obraz.getChild(i) == obraz.getChild("ksiezyc")) {
      obraz.getChild(i).translate(-340.f - sin(radians(angle - 45.f)) * 360.f, 340.f + cos(radians(angle - 45.f)) * 360.f);
      shape(obraz.getChild(i), 0, 0); 
      obraz.getChild(i).translate(340.f + sin(radians(angle - 45.f)) * 360.f, -340.f - cos(radians(angle - 45.f)) * 360.f);
    }
    else {
      shape(obraz.getChild(i), 0, 0); 
    }
  }
}
